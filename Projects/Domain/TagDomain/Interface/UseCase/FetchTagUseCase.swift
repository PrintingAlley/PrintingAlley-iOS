//
//  FetchTagToplevelUseCase.swift
//  TagDomainInterface
//
//  Created by 박의서 on 2023/10/19.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import BaseDomainInterface

public protocol FetchTagUseCase {
    func execute(id: Int) -> Single<TagEntity>
}
