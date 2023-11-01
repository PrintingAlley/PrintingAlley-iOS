//
//  FetchTagToplevelUseCaseImpl.swift
//  TagDomain
//
//  Created by 박의서 on 2023/10/19.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import TagDomainInterface
import RxSwift
import BaseDomainInterface

struct FetchTagUseCaseImpl: FetchTagUseCase {

    
    
    private let tagRepository: any TagRepository // any와 some의 차이 공부 . any - 프로토콜을 채택하고 있는 타입
    
    init(tagRepository: any TagRepository) {
        self.tagRepository = tagRepository
    }
    

    func execute(id: Int) -> Single<TagEntity> {
        tagRepository.fetchTag(id: id)
    }
    
}
