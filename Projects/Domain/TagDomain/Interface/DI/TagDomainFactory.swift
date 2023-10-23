//
//  TagDomainFactory.swift
//  TagDomainInterface
//
//  Created by 박의서 on 2023/10/19.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

// Domain : Feature와 Domain Factory 분리하기 위해 네이밍

public protocol TagDomainFactory {
    
    var fetchTagToplevelUseCase: any FetchTagToplevelUseCase { get }
    var fetchHierarchyUseCase: any FetchHierarchyUseCase { get }
}
// usecase 이름과 똑같이
