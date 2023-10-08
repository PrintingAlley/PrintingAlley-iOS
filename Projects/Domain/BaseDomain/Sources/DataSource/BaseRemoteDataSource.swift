//
//  BaseRemoteDataSource.swift
//  BaseDomain
//
//  Created by yongbeomkwak on 2023/10/06.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import Netwrok
import JwtStoreInterface
import Moya
import RxMoya
import RxSwift

open class BaseRemoteDataSource<API: AlleyAPI> {
    private let jwtStore: any JwtStore
    private let provider: MoyaProvider<API>
    private let decoder = JSONDecoder()
    private let maxRetryCount: Int = 2
    
    public init (jwtStore: any JwtStore, provider: MoyaProvider<API>? = nil) {
        self.jwtStore = jwtStore
        
        #if DEV
        self.provider = provider ?? MoyaProvider(plugins: [JwtPlugin(jwtStore: jwtStore), CustomLoggingPlugin()])
        #else
        self.provider = provider ?? MoyaProvider(plugins: [JwtPlugin(jwtStore: jwtStore)]) // PROD에는 로깅 필요 없음
        #endif
    }
    
    public func request(_ api: API) -> Single<Response> {
        Single<Response>.create { single in
            var disposabels = [Disposable]()
            disposabels.append(
                self.defaultRequest(api).subscribe(
                    onSuccess: { single(.success($0)) },
                    onFailure: { single(.failure($0)) })
            )
            return Disposables.create(disposabels)
        }
    }
    
}

private extension BaseRemoteDataSource {
    func defaultRequest(_ api: API) -> Single<Response> {
        provider.rx.request(api)
            .timeout(.seconds(10), scheduler: MainScheduler.asyncInstance)
            .catch { error in
                guard let errorCode = (error as? MoyaError)?.response?.statusCode else {
                    if let moyaError = (error as? MoyaError), moyaError.errorCode == 6 {
                        return Single.error(api.errorMap[1009] ?? error)
                    }
                    return Single.error(error)
                }
                // AlleyError에 있으면 해당 코드 사용
                return Single.error(api.errorMap[errorCode] ?? error)
            }
    }

    func checkIsApiNeedsAuthorization(_ api: API) -> Bool {
        api.jwtStoreProperties == .accessToken
    }
}
