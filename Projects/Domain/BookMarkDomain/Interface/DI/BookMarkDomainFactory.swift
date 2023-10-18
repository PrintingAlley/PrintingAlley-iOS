//
//  BookMarkDomainFactory.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation


public protocol BookMarkDomainFactory {
    
    var fetchMyBookMarksUseCase: any FetchMyBookMarksUseCase { get }
    var addBookMarkUseCase: any AddBookMarkUseCase { get }
    var removeBookMarkUseCase: any RemoveBookMarkUseCase { get }
    var linkBookMarkUseCase: any LinkBookMarkUseCase { get }
    var generateBookMarkUseCase: any GenerateBookMarkUseCase { get }
    var removeBookMarkGroupUseCase: any RemoveBookMarkGroupUseCase { get }
    
}
