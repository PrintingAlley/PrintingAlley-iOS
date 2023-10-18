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


public class EditModalViewController: UIViewController {
    var completion: (() -> Void)?
    var cancelCompletion: (() -> Void)?
    var titleString: String = ""
    
    let disposeBag = DisposeBag()
    let appHeight =  UIScreen.main.bounds.size.height
    
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
        $0.setPlaceHolder(text: "이름을 입력하세요.", textColor: .setColor(.grey(.grey300)), font: .body1)
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
    
    //TODO: 나중에 유즈케이스 주입할 수 있음
    /// <#Description#>
    /// - Parameters:
    ///   - title: "제목"
    ///   - completion: "확인 핸들러"
    ///   - cancelCompletion: "취소 핸들러"
    public init(title: String = "",completion: (() -> Void)? = nil, cancelCompletion: (() -> Void)? = nil) {
        
        super.init(nibName: nil, bundle: nil)
     
        self.titleString =  title
        self.completion = completion
        self.cancelCompletion = cancelCompletion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   public override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        preProcessing()
        makeConstraints()
        bindTextField()
        bindKeyboard()
    }
    
}

extension EditModalViewController {
    
    func isWhite(_ str: String) -> Bool {
        str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
    
    func bindTextField() {
        
        textField
            .rx
            .text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .map({ str -> String in
                
                var str: String = str
                if str.count > 14 { // 길이 제한
                    let index = str.index(str.startIndex, offsetBy: 14)
                    str = String(str[..<index])
                }
                
                return str
                
            })
            .do(onNext: { [weak self] str in
                
                guard let self else {return}
                
                self.confirmButton.isEnabled  = !((str.first?.isWhitespace ?? true)) // 앞에 시작이 공백일 때
  
                self.limitLabel.setTitle(title: "\(str.count)/14자", textColor: .grey(.grey400), font: .caption1)
            })
            .bind(to: textField.rx.text)
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
            let window: UIWindow? = UIApplication.shared.windows.first
            let safeAreaInsetsBottom: CGFloat = window?.safeAreaInsets.bottom ?? 0
            let tmp = keyboardVisibleHeight  - safeAreaInsetsBottom
            
            self.contentView.snp.updateConstraints {
                $0.left.right.equalToSuperview().inset(14)
                $0.bottom.equalToSuperview().inset( tmp <= .zero ?  self.appHeight/3 : tmp + 50)
            }
            
            UIView.animate(withDuration: 1.0) {
                self.view.layoutIfNeeded()
                
            }
            
            
           
            
            print(tmp)

            
        })
        
    }
    
    func addSubViews() {
        self.view.addSubviews(contentView)
        self.contentView.addSubviews(titleLabel, buttonStack,baseLine, textFieldContainerView)
        self.textFieldContainerView.addSubviews(textField, limitLabel)
        buttonStack.addArrangedSubview(cancelButton, confirmButton)
        
    }
    
    func preProcessing() {
        
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        titleLabel.setTitle(title: self.titleString, textColor: .sub(.black), font: .header3, alignment: .center)
        
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    }
    
    func makeConstraints() {
        
        contentView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview().inset(appHeight/4)
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
    
    @objc func cancelAction() {
        self.dismiss(animated: false)
        self.cancelCompletion?()
    }
    
    @objc func confirmAction() {
        self.dismiss(animated: false)
        self.completion?()
    }
}
