//
//  VersionCheckUseCase.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 11/5/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift

public protocol VersionCheckUseCase {
    func execute(version: String) -> Single<VersionCheckEntity>
}
