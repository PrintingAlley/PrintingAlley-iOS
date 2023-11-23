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



public class EditModalViewController: UIViewController {

    var viewModel: EditModalViewModel!
    
    let disposeBag = DisposeBag()
    
    lazy var contentView: UIView = UIView().then {
        $0.backgroundColor = .setColor(.sub(.white))
        $0.layer.cornerRadius = 8
    }

    lazy var titleLabel: AlleyLabel = AlleyLabel()
    
    lazy var textFieldContainerView: UIView = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Grey.grey50.color
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = DesignSystemAsset.Grey.grey100.color.cgColor
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
    
    public init(viewModel: EditModalViewModel) {
        
        super.init(nibName: nil, bundle: nil)
     
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
        
        textField
            .rx
            .text
            .orEmpty
            .do(onNext: { [weak self] str in
                
                guard let self else {return}
                
                self.confirmButton.isEnabled  = !((str.first?.isWhitespace ?? true)) // 앞에 시작이 공백일 때
                self.limitLabel.setTitle(title: "\(str.count)/\(viewModel.type.limit)자", textColor: .grey(.grey400), font: .caption1)
               
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
                self.hideKeyboard()
                
                
                if result.statusCode == 0 {
                    self.view.showBottomToast(text: result.message)
                }
                
                else {
                    
                    switch viewModel.type {
                    
                    case .newBookMark:
                        NotificationCenter.default.post(name: .refreshBookMarkGroup, object: nil) // 리프래쉬 그룹
                        self.dismiss(animated: false)
                    
                    case .reNameBookMark:
                        NotificationCenter.default.post(name: .refreshBookMark, object: nil) // 리프래쉬 북마크
                        self.dismiss(animated: false)
                        
                    
                    case .reNameprofileName:
                        NotificationCenter.default.post(name: .refreshUserInfo, object: nil)
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
        titleLabel.setTitle(title: viewModel.type.titleString, textColor: .sub(.black), font: .header3, alignment: .center)
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
            $0.left.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.right.equalToSuperview().inset(55)
            $0.top.bottom.equalToSuperview().inset(17)
           
        }
        
        limitLabel.snp.makeConstraints {
            
            $0.right.equalToSuperview().inset(HORIZON_MARGIN1())
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
        
        let maxLength = viewModel.type.limit // 원하는 글자 수를 설정해 줍니다.
        let oldText = textField.text ?? "" // 입력하기 전 textField에 표시되어있던 text 입니다.
        let addedText = string // 입력한 text 입니다.
        let newText = oldText + addedText // 입력하기 전 text와 입력한 후 text를 합칩니다.
        let newTextLength = newText.count // 합쳐진 text의 길이 입니다.
        
  
      
    
        
        
         //글자수 제한
           if newTextLength <= maxLength {
               
               // 백스페이스 처리
              if let char = string.cString(using: String.Encoding.utf8) {
                     let isBackSpace = strcmp(char, "\\b") //  백스페이스는 UInt32값으로  -92
                     if isBackSpace == -92 {
                         return true
                     }
              }
               
               if addedText.hasCharacters() { // 이모지 싫어
                 
                   return true
               }
               
               return false
        }
        
        let lastWordOfOldText = String(oldText[oldText.index(before: oldText.endIndex)]) // 입력하기 전 text의 마지막 글자 입니다.
        let separatedCharacters = lastWordOfOldText.decomposedStringWithCanonicalMapping.unicodeScalars.map{ String($0) } // 입력하기 전 text의 마지막 글자를 자음과 모음으로 분리해줍니다.
        let separatedCharactersCount = separatedCharacters.count // 분리된 자음, 모음의 개수입니다.
        
        DEBUG_LOG("HELLO: \(separatedCharactersCount)")
        
    
            
        
            
            if separatedCharactersCount == 1 && !addedText.isConsonant { // -- A
                
                /*
                 입력되어 있는 마지막 글자의 자음 + 모음 개수가 1개이고, 새로 입력되는 글자가 자음이 아닐 경우 입력이 되도록합니다.

                 입력되어 있는 마지막 글자가 모음 혹은 알파벳일 경우에도 해당 조건을 만족합니다. 하지만 이렇게 되면 설정한 최대 글자 수 + 1 이 됩니다. 이를 방지하기 위한 방법은 2번째 함수에서 다루겠습니다.
                 
                 */
                  return true
              }
              
              if separatedCharactersCount == 2 && addedText.isConsonant { // -- B
                  
                  /*
                   입력되어 있는 마지막 글자의 자음 + 모음 개수가 2개이고, 새로 입력되는 글자가 자음일 경우 입력이 되도록합니다.

                   즉, 자음과 모음이 각 1개씩 있는 상태입니다. 해당 상태일 경우에는 조건에 있는 것 처럼 자음을 받아야만 글자 수를 넘지 않고 글자가 완성되기 때문에 자음만 입력받을 수 있도록 합니다.
                   
                   */
                  return true
              }
        
              
              if separatedCharactersCount == 3 && addedText.isConsonant { // -- C
                  
                  /*
                   입력되어 있는 마지막 글자의 자음 + 모음 개수가 3개이고, 새로 입력되는 글자가 자음일 경우 입력이 되도록합니다.

                   겹받침을 허용하기 위한 로직입니다. 자음 + 모음 개수가 3인 경우는 자음 + 모음 + 자음(받침) 인 경우 입니다.

                   이 경우에는 새로운 글자가 겹받침이 되는 글자만을 허용해야하며, 그러기 위해서는 자음만 입력 받아야합니다.

                   하지만 모든 자음 + 자음이 겹받침이 되는 것이 아니기 때문에 추가적인 설정이 필요합니다. 겹받침이 성립하지 않는 자음은 독립적인 글자가 되며, 이렇게 되면 설정한 최대 글자 수 + 1 이 됩니다. 이를 방지하기 위한 방법 또한 2번째 함수에서 다루겠습니다.
                   
                   */
                  return true
              }
        
                if separatedCharactersCount == 2 && !addedText.isConsonant {
                    
                   
                    
                    let lastWord = String(oldText.last!)
                    DEBUG_LOG("")
                    if lastWord.endsWithVowel("ㅗ") {
                        if addedText == "ㅏ" || addedText == "ㅐ" || addedText == "ㅣ" {
                            return true
                        }
                
                    }
                    
                    else if lastWord.endsWithVowel("ㅜ") {
                        if addedText == "ㅓ" || addedText == "ㅔ" || addedText == "ㅣ" {
                            return true
                        }
                    } else if lastWord.endsWithVowel("ㅡ") , addedText == "ㅣ" {
                        return true
                    }

                }
        

              return false
        
    
    }

    public func textFieldDidChangeSelection(_ textField: UITextField) {
        
        /*
         func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool 함수에서 처리해주었지만 미처 잡지 못한 케이스를 잡기 위해 사용합니다
         
         */
        
        var text = textField.text ?? "" // textField에 수정이 반영된 후의 text 입니다.
        let maxLength = viewModel.type.limit // 원하는 글자 수를 설정해 줍니다. (위 함수에서 설정한 값과 동일하게 해주세요.)
        if text.count > maxLength {
            let startIndex = text.startIndex
            let endIndex = text.index(startIndex, offsetBy: maxLength - 1)
            let fixedText = String(text[startIndex...endIndex])
            textField.text = fixedText
        }
    }
}


extension EditModalViewController {
    func hideKeyboard() {
        if textField.isFirstResponder {
               textField.resignFirstResponder()
           }
    }
}
