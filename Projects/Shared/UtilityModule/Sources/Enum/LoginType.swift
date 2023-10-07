//
//  LoginType.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 2023/09/28.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import DesignSystem
import UIKit

public enum LoginType: Codable {
    
    case kakao
    case naver
    case google
    case apple
    
    public var image: UIImage {
        switch self {
            
        case .kakao:
            return DesignSystemAsset.Logo.kakaoTalk.image
            
        case .naver:
            return DesignSystemAsset.Logo.naver.image
            
        case .google:
            return DesignSystemAsset.Logo.google.image
            
        case .apple:
            return DesignSystemAsset.Logo.apple.image
        }
    }
    
    public var text: String {
        switch self {
            
        case .kakao:
            return "카카오 로그인"
            
        case .naver:
            return "네이버 로그인"
            
        case .google:
            return "Google 로그인"
            
        case .apple:
            return "Apple 로그인"
        }
    }
    
    public var color: UIColor {
        switch self {
        default:
            return .white
        }
    }
    
}
