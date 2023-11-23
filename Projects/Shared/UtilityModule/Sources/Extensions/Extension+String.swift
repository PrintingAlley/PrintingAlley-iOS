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
    
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
    }
    
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }

    
    func hasCharacters() -> Bool {
            do {
                let regex = try NSRegularExpression(pattern: "^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ`~!@#$%^&*()\\-_=+\\[{\\]}\\\\|;:'\",<.>/?\\s]$", options: .caseInsensitive)
                if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                    return true
                }
            }catch {
                return false
            }
            return false
    }
    
    
    // 글자가 자음인지 체크
    var isConsonant: Bool {
        guard let scalar = UnicodeScalar(self)?.value else {
            return false
        }
        
        let consonantScalarRange: ClosedRange<UInt32> = 12593...12622
        
        return consonantScalarRange ~= scalar
    }
}
