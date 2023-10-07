//
//  MyPageContentViewController.swift
//  MyPageFeature
//
//  Created by yongbeomkwak on 2023/09/30.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import Then
import SnapKit
import UtilityModule
import DesignSystem

public class MyPageContentViewController: UIViewController {

    var profileImage: ImageButton = ImageButton()

    public override func viewDidLoad() {
        self.view.backgroundColor = .blue
        super.viewDidLoad()
        addSubViews()
        preProcessing()
        makeConstraints()


    }
    
}

extension MyPageContentViewController {
    func preProcessing() {
        self.profileImage.delegate = self
        self.profileImage.setImage(image: DesignSystemAsset.Icon.profilePlaceHolder.image)
    }
    
    func addSubViews() {
        self.view.addSubviews(profileImage)
    }
    
    func makeConstraints(){
        profileImage.snp.makeConstraints {
            $0.width.height.equalTo(64)
            $0.center.equalToSuperview()
        }
    }
}

extension MyPageContentViewController: ImageButtonDelegate {
    public func action() {
        DEBUG_LOG("ACT")
    }
    
}
