//
//  CategorySearchViewModel.swift
//  CategorySearchFeatureDemo
//
//  Created by yongbeomkwak on 10/26/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import DesignSystem
import RxSwift
import RxRelay
import BaseDomainInterface

class CategorySearchViewModel: ViewModelType {

    public var title: String!
    public var id: Int!
    
    init(title: String, id: Int) {
        self.title = title
        self.id = id
    }
    
    public struct Input {
        
    }
    public struct Output {
        let dataSource: BehaviorRelay<[PrintShopEntity]> = .init(value: [PrintShopEntity(id: 0, name: "정다운 인쇄소", address: "대구시 중구 동성로 345번길 67, 대구빌딩 6층", phone: "02-732-7000", email: "print@gmail.com", homepage: "https://www.publishersglobal.com", representative: "홍길동", introduction: "Composed of some 1,000 Korean Printings as members.", logoImage: "https://www.publishersglobal.com", backgroundImage: "https://www.publishersglobal.com", latitude: "37.5665", longitude: " 126.978", tags: ["임시 태그1","임시 태그 2"])])
    }
    
    
    public func transform(input: Input) -> Output {
    
        let output = Output()
        
        
        
        
        return output
    }
    
}
