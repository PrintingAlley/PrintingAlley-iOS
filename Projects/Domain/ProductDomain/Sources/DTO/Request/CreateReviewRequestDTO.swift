//
//  CreateReviewRequestDTO.swift
//  ProductDomain
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation


struct ReviewRequestDTO: Encodable {
    let content: String
    let rating: Int
    let images: [String]
}
