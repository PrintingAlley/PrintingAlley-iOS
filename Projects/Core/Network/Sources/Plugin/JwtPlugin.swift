//
//  JwtPlugin.swift
//  Netwrok
//
//  Created by yongbeomkwak on 2023/10/06.
//  Copyright © 2023 com. All rights reserved.
//

import Moya
import Foundation
import JwtStoreInterface

struct TokenDTO: Equatable, Decodable {
    let access_token: String

}

public struct JwtPlugin: PluginType {
    private let jwtStore: any JwtStore

    public init(jwtStore: any JwtStore) {
        self.jwtStore = jwtStore
    }

    /// 토큰 실어 보낼 준비 
    public func prepare(
        _ request: URLRequest,
        target: TargetType
    ) -> URLRequest {
        guard let jwtTokenType  = (target as? JwtAuthorizable)?.jwtStoreProperties,
              jwtTokenType != .none
        else { return request }
        var req = request
        let token = "\(getToken(type: .accessToken))"
        req.addValue(token, forHTTPHeaderField: jwtTokenType.rawValue)
        return req
    }

    /// 토큰 확인 결과
    public func didReceive(
        _ result: Result<Response, MoyaError>,
        target: TargetType
    ) {
        switch result {
            
        case let .success(res):
            if let new = try? res.map(TokenDTO.self) {
                saveToken(token: new)
            }
            
        default:
            break
        }
    }
}

private extension JwtPlugin {
    func getToken(type: JwtStoreProperties) -> String { // 가져오기 
        "Bearer \(jwtStore.load(property: .accessToken))"
    }

    func saveToken(token: TokenDTO) {
        jwtStore.save(property: .accessToken, value: token.access_token)
    }
}
