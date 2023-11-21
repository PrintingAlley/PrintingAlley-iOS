//
//  EditType.swift
//  BaseFeatureInterface
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public enum EditType {
    case newBookMark
    case reNameBookMark
    case reNameprofileName
    
    
    public var limit: Int {
        switch self {
            
        case .reNameprofileName:
            return 14

        case .reNameBookMark,.newBookMark:
            return 10
        }
    }
    
    public var titleString: String {
        switch self {
            
        case .reNameprofileName:
            "이름 수정"
        case .newBookMark:
            "저장 목록 만들기"
        case .reNameBookMark:
            "저장목록 이름 수정"
        }
    }
    
    public var placeHolder: String {
        switch self {
            
        case .newBookMark, .reNameBookMark:
            return "저장 목록의 이름을 적어주세요."
 
        case .reNameprofileName:
            return "이름을 입력하세요."
        }
    }
    
}
