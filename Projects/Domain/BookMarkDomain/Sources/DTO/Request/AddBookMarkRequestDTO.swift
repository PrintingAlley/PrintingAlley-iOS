//
//  AddBookMarkRequestDTO.swift
//  BookMarkDomain
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BookMarkDomainInterface

struct AddBookMarkRequestDTO : Encodable {
    let prodcutId: Int
    let groupId: Int
    
}
