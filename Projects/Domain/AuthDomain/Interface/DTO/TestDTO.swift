//
//  TestDTO.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

struct TestDTO: Decodable {
    let message: String
}

extension TestDTO {
    func toDomain() -> TestEntity {
        TestEntity(message: self.message)
    }
}
