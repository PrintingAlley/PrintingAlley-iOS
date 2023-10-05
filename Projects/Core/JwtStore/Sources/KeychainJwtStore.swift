//
//  KeychainJwtStore.swift
//  JwtStore
//
//  Created by yongbeomkwak on 2023/10/05.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import JwtStoreInterface

/*
 OAuth 기반 서버에서 인증 API를 사용할 때 토큰 전송해야 합니다.

 토큰을 전송받았을 때 UserDefault에 토큰 값을 저장할 수도 있지만

 이 저장소는 암호화를 하지 않기 때문에 다른 암호화 작업을 진행하고 저장할 수 있지만 번거롭습니다.

 
 그래서 키 체인을 이용해서 인증 토큰을 저장하는 방법을 알아보겠습니다.

 
 키 체인 (Key Chain)

 보안이 필요한 요소를 저장하는데 사용되는 암호화된 저장소입니다.
 
 ​

 키 체인의 특징

 - 앱은 자신의 키 체인에만 접근 가능

 - 해당 앱을 삭제해도 키 체인에 저장된 정보는 삭제 안됨

 - 동일한 앱이라도 프로비저닝 파일을 변경하면 기존 키 체인에 저장된 정보를 조회할 수 없음

 - 키 체인 그룹을 사용하면 다른 앱에서도 데이터를 공유 가능

 - 보호가 필요한 항목은 암호화, 보호가 필요하지 않은 항목은 비 암호화

 - 키 체인은 잠글 수 있지만 iOS는 기기 잠금 해제로 키 체인 잠금도 함께 해제됨

 ​

 키 체인은

 키 체인 아이템 - 저장되는 데이터

 아이템 클래스 - 저장할 데이터의 종류

 어트리뷰트로 - 아이템 클래스에 대한 속서

 으로 구성되어 있습니다.
 
 kSecClassGenericPassword: 이 클래스는 일반 비밀번호를 저장할 때 사용됩니다.
 
 
 
 let keyChainQuery: NSDictionary = [
     kSecClass: 아이템 클래스,  // 어떠한 타입의 데이터를 저장할지
     kSecAttrService: 서비스 아이디, // 앱 번들 아이디
     kSecAttrAccount: 사용자 계정,
     kSecValueData: 저장할 값
 ]
 
 
 
 
 키 체인을 다루는 메서드 (Security 프레임워크에 정의)

 저장 - SecItemAdd

 삭제 - SecitemDelete

 읽기 - SecItemCopyMatching

 수정 - SecItemUpdate
 
 
 */

final class KeychainJwtStore: JwtStore {
    private let service: String = Bundle.main.bundleIdentifier ?? ""

    func save(property: JwtStoreProperties, value: String) {
        let query: NSDictionary = [
            kSecAttrService: service,
            kSecAttrAccount: property.rawValue,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false) ?? .init(), // allowLossyConversion은 인코딩 과정에서 손실이 되는 것을 허용할 것인지 설정
        ]
        
        // 2. Delete
        // Key Chain은 Key값에 중복이 생기면 저장할 수 없기때문에 먼저 Delete
        SecItemDelete(query)
        
        //제거후 저장
        SecItemAdd(query, nil)
    }

    func load(property: JwtStoreProperties) -> String {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
           kSecAttrService: service,
           kSecAttrAccount: property.rawValue,
           kSecReturnData: kCFBooleanTrue!, // CFData타입으로 불러오지 말라는 의미
           kSecMatchLimit: kSecMatchLimitOne // 중복되는 경우 하나의 값만 가져오라는 의미
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == errSecSuccess {
            guard let data = dataTypeRef as? Data else { return "" }
            return String(data: data, encoding: .utf8) ?? ""
        }
        return ""
    }

    func delete(property: JwtStoreProperties) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: property.rawValue
        ]
        SecItemDelete(query)
    }
}
