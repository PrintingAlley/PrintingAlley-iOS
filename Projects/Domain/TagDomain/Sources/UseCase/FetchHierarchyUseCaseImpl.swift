//
//  FetchHierarchyUseCaseImpl.swift
//  TagDomain
//
//  Created by yongbeomkwak on 10/23/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import TagDomainInterface
import RxSwift

struct FetchHierarchyUseCaseImpl: FetchHierarchyUseCase {
    
    private let tagRepository: any TagRepository // any와 some의 차이 공부 . any - 프로토콜을 채택하고 있는 타입
    
    init(tagRepository: any TagRepository) {
        self.tagRepository = tagRepository
    }
    
    func execute() -> Single<HierarchyEntity> {
        tagRepository.fetchHierarchy()
    }
    

}
