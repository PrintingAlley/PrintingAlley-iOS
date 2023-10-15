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
    
    var confirmText: String {
        
        switch self {
            
        case .onlyConfirm:
            return "확인"
        case .delete:
            return "삭제"
        }
    }
    
    var isHiddenCancelButton: Bool {
        
        switch self {
            
        case .onlyConfirm:
            return true
        case .delete:
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
    
    lazy var titleLabel: AlleyLabel = AlleyLabel().then {
        $0.numberOfLines = 0
    }
    lazy var contentLabel: AlleyLabel = AlleyLabel().then {
        $0.numberOfLines = 0
    }
    lazy var cancelButton: UIButton = UIButton().then{
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(DesignSystemAsset.Grey.grey400.color, for: .normal)
        $0.titleLabel?.font = .setFont(.subtitle2)
        $0.contentHorizontalAlignment = .center
    }
    lazy var confirmButton: UIButton = UIButton()
    
    lazy var buttonStack: UIStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fillEqually
    }
    
    
    public init(title: String = "",
         content: String = "",
         type: AlertType = .onlyConfirm,
         completion: (() -> Void)? = nil,
         cancelCompletion: (() -> Void)? = nil){
        
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
        self.view.addSubviews(titleLabel,contentLabel, buttonStack)
        buttonStack.addArrangedSubview(cancelButton, confirmButton)
        
    }
    
    func preProcessing() {
        
        cancelButton.isHidden = type.isHiddenCancelButton
        
        self.view.layer.cornerRadius = 8
        self.view.backgroundColor = .white
        
        titleLabel.setTitle(title: self.titleString, textColor: .sub(.black), font: .subtitle2, alignment: .center)
        contentLabel.setTitle(title: self.contentString, textColor: .sub(.black), font: .body2, alignment: .center)
        confirmButton.setTitle(self.type.confirmText, for: .normal)
        confirmButton.titleLabel?.font = .setFont(.subtitle3)
        confirmButton.setTitleColor(DesignSystemAsset.MainBlue.blue500.color, for: .normal)
        confirmButton.contentHorizontalAlignment = .center
        
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    }
    
    func makeConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.left.right.equalToSuperview().inset(40)
            
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.right.equalTo(titleLabel)
        }
        
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(24)
            $0.horizontalEdges.equalTo(titleLabel.snp.horizontalEdges)
            $0.bottom.equalToSuperview().inset(16)
        }
        
    }
    
    @objc func cancelAction() {
        print("삭제")
        self.dismiss(animated: false)
        self.cancelCompletion?()
    }
    
    @objc func confirmAction() {
        print("확인")
        self.dismiss(animated: false)
        self.completion?()
    }
}