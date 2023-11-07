//
//  FetchContentsUseCaseImpl.swift
//  ContentDomain
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import ContentDomainInterface

struct FetchContentsUseCaseImpl: FetchContentsUseCase {
    
    var contentRepository: any ContentRepository
    
    
    init(contentRepository: any ContentRepository) {
        self.contentRepository = contentRepository
    }
    
    func execute() -> ContentGroupEntity {
        contentRepository.fetchContents()
    }
    
    
}
