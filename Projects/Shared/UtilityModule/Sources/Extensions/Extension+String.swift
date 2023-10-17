//
//  Extension+String.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 10/17/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public extension String {
    var isWhiteSpace: Bool{
              return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0
    }
}
