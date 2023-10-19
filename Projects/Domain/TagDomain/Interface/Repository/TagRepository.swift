//
//  TagRepository.swift
//  TagDomainInterface
//
//  Created by 박의서 on 2023/10/19.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import BaseDomainInterface // status 와 메세지만 오는 경우를 위해

public protocol TagRepository {
    func fetchTagToplevel() -> Single<[TagToplevelEntity]>
}
// Usecase 정의 후 Repository 생성
