//
//  JwtStore.swift
//  JwtStoreInterface
//
//  Created by yongbeomkwak on 2023/10/05.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

/*
 JWT(Json Web Token)란 Json 포맷을 이용하여 사용자에 대한 속성을 저장하는 Claim 기반의 Web Token이다.
 JWT는 토큰 자체를 정보로 사용하는 Self-Contained 방식으로 정보를 안전하게 전달한다.
 
 장점:
 1. 자가수용적(self-contained) 이다.
 JWT는 필요한 모든 정보를 자체적으로 지니고 있다. 토큰에 대한 기본정보, 저달할 정보, 토큰 검증됐다는 것을 증명해 주는 signature를 포함하고 있다.
 
 2.쉽게 전달된다.
 자가수용적이므로, 두 개체간에 손쉽게 전달이 된다. 웹서버의 경우 HTTP의 헤더에 넣어서 전달 할 수도 있고, URL의 페라미터로도 전달할 수 있다.

 
 구조
 
 JWT는 크게 헤더(Header), 페이로드(Payload), 서명(Signature)의 3 부분으로 구분되고, 각 부분을 점(.)으로 구분한다.
 HEADER.PAYLOAD.SIGNATURE
 
 Json 형태인 각 부분은 Base64로 인코딩 되어 표현된다. Base64는 암호화된 문자열이 아니고, 같은 문자열에 대해 항상 같은 인코딩 문자열을 반환한다.

 3 부분을 합한 형식을 아래와 같다.
 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9 (Header)
 .eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ (Payload)
 .SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c (Signature)
 
 
 
 1. Header
 
 에는 토큰의 타입과 해시 암호화 알고리즘으로 구성되어 있다. JWT를 검증하는데 필요한 정보를 가진 JSON 객체는 Base64 URL-Safe 인코딩된 문자열이다.

 {
   "alg": "HS256",
   "typ": "JWT"
 }
 
 2. Payload
 
 JWT에 담아서 전달할 data를 정의한다. 토큰의 페이로드에는 토큰에서 사용할 정보의 조각들인 클레임(Claim)이 담겨 있다.
 Json(Key/Value) 형태로 다수의 정보를 넣을 수 있다.
 
 {
   "exp": 1620290493,
   "jti": "7d8b0d7b-08a3-4bad-96a4-911b8945553e",
   "http://www.devkuma.com/": true,
   "username": "araikuma",
   "authorities": [
     "ROLE_USER"
   ],
   "scope": [
     "read",
     "write"
   ]
   ... 기타 등등 ....
 }
 
 3.Signature
 
 서명(Signature)은 토큰을 인코딩하거나 유효성 검증을 할 때 사용하는 고유한 암호화 코드이다.
 서명(Signature)은 위에서 만든 헤더(Header)와 페이로드(Payload)의 값을 각각 BASE64로 인코딩하고,
 인코딩한 값을 비밀 키를 이용해 헤더(Header)에서 정의한 알고리즘으로 해싱을 하고, 이 값을 다시 BASE64로 인코딩하여 생성한다.
 
 JWT 인증 방식
 대략적인 JWT를 사용한 인증의 흐름은 아래와 같다.

 헤더 or 페이로드가 변조되지 않았는지 확인한다.
 페이로드가 만료일(exp) 등에 문제가 없는지 확인한다.
 문제가 없으면 인증이 완료된다.
 
*/



public enum JwtStoreProperties: String {
    case accessToken = "Authorization"
    
}

public protocol JwtStore {
    func save(property: JwtStoreProperties, value: String)
    func load(property: JwtStoreProperties) -> String
    func delete(property: JwtStoreProperties)
}

public protocol JwtAuthorizable {
    var jwtStore: JwtStoreProperties { get }
}


