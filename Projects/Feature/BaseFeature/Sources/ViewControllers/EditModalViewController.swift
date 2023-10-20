//
//  EditModalViewController.swift
//  DesignSystemDemo
//
//  Created by yongbeomkwak on 10/15/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DesignSystem
import RxCocoa
import RxSwift
import RxKeyboard
import UtilityModule


//TODO:  업데이트 노티 쏴주기

public class EditModalViewController: UIViewController {

    var viewModel: EditModalViewModel!
    var titleString: String = ""
    
    let disposeBag = DisposeBag()
    
    lazy var contentView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
    }

    lazy var titleLabel: AlleyLabel = AlleyLabel()
    
    lazy var textFieldContainerView: UIView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = DesignSystemAsset.Grey.grey300.color.cgColor
        $0.layer.borderWidth = 1
        
    }
    
    lazy var textField: UITextField = UITextField().then {
        $0.font = .setFont(.body1)
        $0.autocorrectionType = .no // 자동완성 끄기
        $0.delegate = self
    }
    
    lazy var limitLabel: AlleyLabel = AlleyLabel()
    
    lazy var cancelButton: UIButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(DesignSystemAsset.Sub.black.color, for: .normal)
        $0.titleLabel?.font = .setFont(.body1)
        $0.contentHorizontalAlignment = .center
    }
    lazy var confirmButton: UIButton = UIButton().then {
        
        $0.setTitle("저장하기", for: .normal)
        $0.titleLabel?.font = .setFont(.body1)
        $0.setTitleColor(DesignSystemAsset.MainBlue.blue500.color, for: .normal)
        $0.contentHorizontalAlignment = .center
        
        $0.setTitle("저장하기", for: .disabled)
        $0.titleLabel?.font = .setFont(.body1)
        $0.setTitleColor(DesignSystemAsset.Grey.grey400.color, for: .disabled)
        $0.contentHorizontalAlignment = .center
        
    }
    
    lazy var baseLine: UIView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    lazy var buttonStack: UIStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fillEqually
    }
    
    public init(title: String = "",viewModel: EditModalViewModel) {
        
        super.init(nibName: nil, bundle: nil)
     
        self.titleString =  title
        self.viewModel = viewModel

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        DEBUG_LOG(Self.self)
    }
    
   public override func viewDidLoad() {
        super.viewDidLoad()
       
        addSubViews()
        makeConstraints()
        preProcessing()
        bindViewModel()

    }
    
}

extension EditModalViewController {
    
    func isWhite(_ str: String) -> Bool {
        str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
    
    
    func bindViewModel() {
        let input = EditModalViewModel.Input()
        let output = viewModel.transform(input: input)
        
        bindButtons(input: input)
        bindTextField(input: input)
        bindKeyboard()
        bindResult(output: output)
        
        
        
    }
    
    func bindButtons(input: EditModalViewModel.Input) {
        
        cancelButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                
                guard let self else {return}
                self.dismiss(animated: false)
                
            })
            .disposed(by: disposeBag)
        
        confirmButton
            .rx
            .tap
            .bind(to: input.tapConfirm)
            .disposed(by: disposeBag)
        
        
    }
    
    func bindTextField(input: EditModalViewModel.Input) {
        
        // TextField 델리게이트로 .. 
        textField
            .rx
            .text
            .orEmpty
            .do(onNext: { [weak self] str in
                
                guard let self else {return}
                
                self.confirmButton.isEnabled  = !((str.first?.isWhitespace ?? true)) // 앞에 시작이 공백일 때
                self.limitLabel.setTitle(title: "\(str.count)/14자", textColor: .grey(.grey400), font: .caption1)
               
            })
            .bind(to:input.text)
            .disposed(by: disposeBag)
        
    }
    
    func bindKeyboard() {
        
        
        RxKeyboard.instance.visibleHeight //드라이브: 무조건 메인쓰레드에서 돌아감
        .drive(onNext: { [weak self] keyboardVisibleHeight in
            print("keyboardVisibleHeight: \(keyboardVisibleHeight)")
            guard let self = self else {
                return
            }
            //키보드는 바텀 SafeArea부터 계산되므로 빼야함
           
            let safeAreaInsetsBottom: CGFloat = SAFEAREA_BOTTOM_HEIGHT()
            let tmp = keyboardVisibleHeight  - safeAreaInsetsBottom
            
            self.contentView.snp.updateConstraints {
                $0.left.right.equalToSuperview().inset(14)
                $0.bottom.equalToSuperview().inset( tmp <= .zero ?  APP_HEIGHT()/3 : tmp + 50)
            }
            
            UIView.animate(withDuration: 1.0) {
                self.view.layoutIfNeeded()
                
            }
            
        })
        .disposed(by: disposeBag)
        
    }
    
    func bindResult(output: EditModalViewModel.Output) {
        output
            .showToast
            .subscribe(onNext: { [weak self] result in
                
                
                guard let self else {return}
                
                
                if result.statusCode == 0 {
                    self.view.showToast(text: result.message)
                }
                
                else if result.statusCode == 401 {
                    self.view.showToast(text: result.message)
                    // TODO: 토큰 exired 경우 LOGOUT
                }
                
                else {
                    
                    switch viewModel.type {
                    
                    case .newBookMark:
                        NotificationCenter.default.post(name: .refreshBookMark, object: nil) // 리프래쉬
                        self.dismiss(animated: false)
                    
                    default:
                        
                        self.dismiss(animated: false)
                    }
                    
            
                }
            })
            .disposed(by: disposeBag)
    }
    
    func addSubViews() {
        self.view.addSubviews(contentView)
        self.contentView.addSubviews(titleLabel, buttonStack,baseLine, textFieldContainerView)
        self.textFieldContainerView.addSubviews(textField, limitLabel)
        buttonStack.addArrangedSubview(cancelButton, confirmButton)
        
    }
    
    func preProcessing() {
        textField.setPlaceHolder(text: viewModel.type.placeHolder, textColor: .setColor(.grey(.grey300)), font: .body1)
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        titleLabel.setTitle(title: self.titleString, textColor: .sub(.black), font: .header3, alignment: .center)
    }
    
    func makeConstraints() {
        
        contentView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview().inset(APP_HEIGHT()/4)
        }
        
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.left.right.equalToSuperview().inset(40)
            
        }
        
        textFieldContainerView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(25)
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
        
        textField.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(55)
            $0.top.bottom.equalToSuperview().inset(17)
           
        }
        
        limitLabel.snp.makeConstraints {
            
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalTo(textField.snp.centerY)
        }
        
        baseLine.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalTo(textFieldContainerView.snp.bottom).offset(24)
        }

        buttonStack.snp.makeConstraints {
            $0.top.equalTo(baseLine.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(titleLabel.snp.horizontalEdges)
            $0.bottom.equalToSuperview().inset(16)
        }
        
    }
    

}


extension EditModalViewController : UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 백스페이스 처리
           if let char = string.cString(using: String.Encoding.utf8) {
                  let isBackSpace = strcmp(char, "\\b") //  백스페이스는 UInt32값으로  -92
                  if isBackSpace == -92 {
                      return true
                  }
            }
        
        guard textField.text!.count < 14 else { return false } // 15 글자로 제한
             return true
    }
}
