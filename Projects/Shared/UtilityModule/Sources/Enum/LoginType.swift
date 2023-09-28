//
//  LoginType.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 2023/09/28.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation


public enum LoginType {
    
    case kakao
    case naver
    case google
    case apple
    
    var image: UIImage {
        switch self {
            
        case .kakao:
            return UIImage(systemName: "home")!
            
        case .naver:
            return UIImage(systemName: "home")!
            
        case .google:
            return UIImage(systemName: "home")!
            
        case .apple:
            return UIImage(systemName: "home")!
        }
    }
    
    var text: String {
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
}
