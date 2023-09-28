//
//  LoginType.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 2023/09/28.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit

public enum LoginType {
    
    case kakao
    case naver
    case google
    case apple
    
    public var image: UIImage {
        switch self {
            
        case .kakao:
            return UIImage(systemName: "house")!
            
        case .naver:
            return UIImage(systemName: "house")!
            
        case .google:
            return UIImage(systemName: "house")!
            
        case .apple:
            return UIImage(systemName: "house")!
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
    
    public var color:UIColor {
        switch self {
        case .kakao:
            return .yellow
            
        case .naver:
            return .green
            
        case .google:
            return .white
            
        case .apple:
            return .blue
        }
    }
    
}
