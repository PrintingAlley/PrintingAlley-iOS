//
//  ImageButton.swift
//  DesignSystem
//
//  Created by yongbeomkwak on 2023/10/07.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then

public protocol ImageButtonDelegate: AnyObject {
    
    func action()
}

public class ImageButton: UIView {

    var button: UIButton = UIButton()
    var imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    public weak var delegate: ImageButtonDelegate?
    
    public init() {
        super.init(frame: .zero)
        self.addSubviews(button, imageView)
        
        makeConstraints()
        self.button.addTarget(self, action: #selector(buttonTap), for: .touchDown)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ImageButton {
    
    public func setImage(image: UIImage) {
        self.imageView.image = image
    }
    
    func makeConstraints() {
        
        button.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
    }
    
    @objc func buttonTap() {
        delegate?.action()
    }
    
}


