//
//  RemoteContentDataSource.swift
//  ContentDomainInterface
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift

public protocol RemoteContentDataSource {
    func fetchContents() -> Single<ContentGroupEntity>
}
