//
//  TestDTO.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import AuthDomainInterface

public struct TestDTO: Decodable {
    let url: String
}

extension TestDTO {
    func toDomain() -> TestEntity {
        TestEntity(url: self.url)
    }
}
