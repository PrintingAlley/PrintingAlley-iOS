//
//  DummyModel.swift
//  SearchFeatueInterface
//
//  Created by 박의서 on 2023/10/18.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct RecommendModel {
    public let title: String
    
    public init(title: String) {
        self.title = title
    }
    
    public static func makeDummy() -> [Self] {[
        RecommendModel(title: "스프링노트"),
        RecommendModel(title: "리소인쇄"),
        RecommendModel(title: "레터프레스"),
        RecommendModel(title: "하이"),
        RecommendModel(title: "아아아아아아아아아"),
        RecommendModel(title: "리소인쇄"),
        RecommendModel(title: "카테고리"),
        RecommendModel(title: "카테고리")
    ]}
}
