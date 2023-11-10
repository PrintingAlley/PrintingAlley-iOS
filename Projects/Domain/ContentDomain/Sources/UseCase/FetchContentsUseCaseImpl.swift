//
//  FetchContentsUseCaseImpl.swift
//  ContentDomain
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import ContentDomainInterface
import RxSwift

struct FetchContentsUseCaseImpl: FetchContentsUseCase {
    
    var contentRepository: any ContentRepository
    
    
    init(contentRepository: any ContentRepository) {
        self.contentRepository = contentRepository
    }
    
    func execute() -> Single<ContentGroupEntity>{
        contentRepository.fetchContents()
    }
    
    
}
