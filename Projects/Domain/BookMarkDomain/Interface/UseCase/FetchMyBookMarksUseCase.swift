//
//  FetchMyBookMark.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift


public protocol FetchMyBookMarksUseCase {
    func execute() -> Single<MyBookMarkEntity>
}
