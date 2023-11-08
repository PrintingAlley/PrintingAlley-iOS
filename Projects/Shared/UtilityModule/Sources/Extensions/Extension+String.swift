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
              return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
    
    func findIntFromString(pattern: String) -> Int {
        do {
        let regex = try NSRegularExpression(pattern: pattern)
            
            if let match = regex.firstMatch(in: self, range: NSRange(self.startIndex..., in: self)) {
                let range = Range(match.range(at: 0), in: self)
                
                if let resultStr = range.flatMap({ String(self[$0]) }), let extractedResult = Int(resultStr) {
                    return extractedResult
                }
            }
        } catch {
            DEBUG_LOG("정규표현식 에러")
        }
        return 0
    }
}
