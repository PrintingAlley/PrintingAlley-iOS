//
//  FetchBookMarkDetailUseCase.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/20/23.
//  Copyright © 2023 com. All rights reserved.
//


import Foundation
import RxSwift
import BaseDomainInterface

public protocol FetchBookMarkDetailUseCase {
    func execute(id: Int) -> Single<[BookMarkDetailEntity]>
}
