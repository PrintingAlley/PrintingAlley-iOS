//
//  AlertViewController.swift
//  DesignSystem
//
//  Created by yongbeomkwak on 10/15/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem
import SnapKit
import Then

public enum AlertType {
    case onlyConfirm    // 확인 버튼
    case delete
    case offerUpdate
    case forceUpdate
    case logout
    case exit
    
    var confirmText: String {
        
        switch self {
            
        case .onlyConfirm, .logout:
            return "확인"
        case .delete:
            return "삭제"
        case .offerUpdate,.forceUpdate:
            return "업데이트"
        case .exit:
            return "종료"
        }
    }
    
    var cancelText: String {
        
        switch self {
            
        case .onlyConfirm, .delete:
            "취소"
        case .offerUpdate:
            "다음에"
        case .forceUpdate, .logout, .exit:
            ""
        }
    }
    
    var isHiddenCancelButton: Bool {
        
        switch self {
            
        case .onlyConfirm, .forceUpdate, .logout, .exit:
            return true
        case .delete, .offerUpdate:
            return false

        }
    }
    
}

public class AlertViewController: UIViewController {

    var completion: (() -> Void)?
    var cancelCompletion: (() -> Void)?
    var titleString: String = ""
    var contentString: String = ""
    var type: AlertType = .onlyConfirm
    
    lazy var alertView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
    }
    
    lazy var baseLine: UIView = UIView().then{
        $0.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    lazy var titleLabel: AlleyLabel = AlleyLabel().then {
        $0.numberOfLines = 0
    }
    lazy var contentLabel: AlleyLabel = AlleyLabel().then {
        $0.numberOfLines = 0
    }
    
    lazy var cancelButton: UIButton = UIButton()
    lazy var confirmButton: UIButton = UIButton()
    
    
    lazy var buttonStack: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fillEqually
    }
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - title: "제목"
    ///   - content: "내용"
    ///   - type: "Alert 타입"
    ///   - completion: "확인 핸들러"
    ///   - cancelCompletion: "취소 핸들러"
    public init(title: String = "", content: String = "", type: AlertType = .onlyConfirm, completion: (() -> Void)? = nil, cancelCompletion: (() -> Void)? = nil) {
        
        super.init(nibName: nil, bundle: nil)
        
        self.type = type
        self.titleString =  title
        self.contentString = content
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
    }
    
}

extension AlertViewController {
    
    func addSubViews() {
        self.view.addSubviews(alertView)
        self.alertView.addSubviews(titleLabel, contentLabel, buttonStack, baseLine)
        buttonStack.addArrangedSubview(cancelButton, confirmButton)
        
    }
    
    func preProcessing() {
        
        cancelButton.isHidden = type.isHiddenCancelButton
    
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        
        titleLabel.setTitle(title: self.titleString, textColor: .sub(.black), font: .subtitle2, alignment: .center)
        contentLabel.setTitle(title: self.contentString, textColor: .sub(.black), font: .body2, alignment: .center)
        
        confirmButton.setTitle(self.type.confirmText, for: .normal)
        confirmButton.titleLabel?.font = .setFont(.subtitle3)
        confirmButton.setTitleColor(DesignSystemAsset.MainBlue.blue500.color, for: .normal)
        confirmButton.contentHorizontalAlignment = .center
        
        cancelButton.setTitle(self.type.cancelText, for: .normal)
        cancelButton.setTitleColor(DesignSystemAsset.Grey.grey400.color, for: .normal)
        cancelButton.titleLabel?.font = .setFont(.body2)
        cancelButton.contentHorizontalAlignment = .center
        
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    }
    
    func makeConstraints() {
        
        let width = UIScreen.main.bounds.size.width
        
        alertView.snp.makeConstraints {
            $0.width.equalTo( width - ((width * (116.0))/390.0))
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.left.right.equalToSuperview().inset(30)
            
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.right.equalTo(titleLabel)
        }
        
        baseLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview()
            $0.top.equalTo(contentLabel.snp.bottom).offset(16)
        }
        
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(baseLine.snp.bottom).offset(13)
            $0.horizontalEdges.equalTo(titleLabel.snp.horizontalEdges)
            $0.bottom.equalToSuperview().inset(13)
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
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

/*
 
 사용법
 
 let vc = AlertViewController(title: "삭제하시겠나요?", content: "리스트를 삭제하면 리스트에 저장된\n장소도 함께 삭제됩니다", type: .delete)
 
 vc.modalPresentationStyle = .overFullScreen 꼭 이걸로
 
 self.present(vc,animated: false)
 
 
 */
