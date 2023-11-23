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
    
    func separateVowels() -> [String] {
        var result: [String] = []

        for scalar in self.unicodeScalars {
            let scalarValue = scalar.value
            if (0xAC00 <= scalarValue && scalarValue <= 0xD7A3) { // 한글 유니코드 범위
                let index = Int(scalarValue - 0xAC00)
                let lead = 0x1100 + index / 28 / 21
                let vowel = 0x1161 + index / 28 % 21
                let tail = (index % 28 == 0) ? 0 : 0x11A7 + index % 28

                if let leadUnicodeScalar = UnicodeScalar(lead),
                   let vowelUnicodeScalar = UnicodeScalar(vowel),
                   let tailUnicodeScalar = UnicodeScalar(tail) {
                    result.append(String(leadUnicodeScalar))
                    result.append(String(vowelUnicodeScalar))
                    if tail != 0 {
                        result.append(String(tailUnicodeScalar))
                    }
                }
            } else {
                result.append(String(scalar))
            }
        }

        return result
    }
    
    func endsWithVowel(_ targetVowel: String) -> Bool {
        
        var mappingTargetVowl = ""
        
        
        // 받침으로 들어가는 ㅡ 와 그냥 ㅡ는 다른 값
        switch targetVowel {
            case "ㅗ" :
                mappingTargetVowl = "도".separateVowels().last!
            case "ㅜ" :
                mappingTargetVowl = "두".separateVowels().last!
            case "ㅡ":
                mappingTargetVowl = "드".separateVowels().last!
            default:
                mappingTargetVowl = ""
        }
        
        
        if let lastVowel = self.separateVowels().last {
        
            return lastVowel == mappingTargetVowl
        }
        return false
    }
}
