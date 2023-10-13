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

public enum LoginType: String, Codable  {
    
    case kakao = "kakao"
    case naver = "naver"
    case google = "google"
    case apple = "apple"
    
    public var image: UIImage {
        switch self {
            
        case .kakao:
            return DesignSystemAsset.Logo.kakaoTalk.image
            
        case .naver:
            return DesignSystemAsset.Logo.naverWhite.image
            
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
    
    public var textColor: UIColor.AlleyColorSystem {
        switch self {
        case .naver:
            
            return .sub(.white)
            
        default:
            return .sub(.black)
        }
    }
    
    public var color: UIColor {
        switch self {
            
        case .kakao:
            return colorFromRGB("FEE500")
            
        case .naver:
            return colorFromRGB("03C75A")
            
        case .google:
            return .white
            
        case .apple:
            return .white
        }
    }
    
}
