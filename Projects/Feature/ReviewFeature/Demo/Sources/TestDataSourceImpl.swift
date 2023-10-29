//
//  TestDataSourceImpl.swift
//  ReviewFeatureDemo
//
//  Created by yongbeomkwak on 10/28/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift

public class TestDataSourceImpl: TestDataSource<TestAPIImpl> {
    func upload(data: Data) -> Single<TmpEntity> {
        request(.upload(data: data))
            .map(TmpDTO.self)
            .map{$0.toDomain()}
        
    }
}


struct TmpDTO: Decodable {
    let url: String
    
    func toDomain() -> TmpEntity {
        TmpEntity(url: url)
    }
}

public struct TmpEntity {
    
    public let url: String
    
    init(url: String) {
        self.url = url
    }
}
