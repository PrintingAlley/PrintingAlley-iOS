//
//  EncodingURL.swift
//  BaseDomainInterface
//
//  Created by yongbeomkwak on 11/20/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

extension String {
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
    }
}


