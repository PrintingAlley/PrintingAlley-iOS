//
//  ContentFactory.swift
//  ContentDomainInterface
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public protocol ContentDomainFactory {
    var fetchContentsUseCase: any FetchContentsUseCase { get }
}
