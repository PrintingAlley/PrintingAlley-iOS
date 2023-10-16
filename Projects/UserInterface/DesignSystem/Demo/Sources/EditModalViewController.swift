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

public class EditModalViewController: UIViewController {
    var completion: (() -> Void)?
    var cancelCompletion: (() -> Void)?
    var titleString: String = ""
    var contentString: String = ""
    
    lazy var contentView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
    }
    
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
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - title: "제목"
    ///   - content: "내용"
    ///   - type: "Alert 타입"
    ///   - completion: "확인 핸들러"
    ///   - cancelCompletion: "취소 핸들러"
    public init(title: String = "", content: String = "", type: AlertType = .onlyConfirm, completion: (() -> Void)? = nil, cancelCompletion: (() -> Void)? = nil) {
        
        super.init(nibName: nil, bundle: nil)
    
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

extension EditModalViewController {
    
    func addSubViews() {
        self.view.addSubviews(contentView)
        self.contentView.addSubviews(titleLabel,contentLabel, buttonStack)
        buttonStack.addArrangedSubview(cancelButton, confirmButton)
        
    }
    
    func preProcessing() {
        
    
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        
        titleLabel.setTitle(title: self.titleString, textColor: .sub(.black), font: .subtitle2, alignment: .center)
        contentLabel.setTitle(title: self.contentString, textColor: .sub(.black), font: .body2, alignment: .center)
        confirmButton.titleLabel?.font = .setFont(.subtitle3)
        confirmButton.setTitleColor(DesignSystemAsset.MainBlue.blue500.color, for: .normal)
        confirmButton.contentHorizontalAlignment = .center
        
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    }
    
    func makeConstraints() {
        
        contentView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
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
