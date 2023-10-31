//
//  TestDataSource.swift
//  ReviewFeatureDemo
//
//  Created by yongbeomkwak on 10/28/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import Moya
import RxMoya
import RxSwift

open class TestDataSource<API: TestAPI> {
    private let provider: MoyaProvider<API>
    private let decoder = JSONDecoder()
    private let maxRetryCount: Int = 2
    
    public init (provider: MoyaProvider<API>? = nil) {
        self.provider = MoyaProvider()

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

private extension TestDataSource {
    func defaultRequest(_ api: API) -> Single<Response> {
        provider.rx.request(api)
            .timeout(.seconds(10), scheduler: MainScheduler.asyncInstance)
            .catch { error in
                guard let errorCode = (error as? MoyaError)?.response?.statusCode else {
                    if let moyaError = (error as? MoyaError), moyaError.errorCode == 6 {
                        return Single.error(error)
                    }
                    return Single.error(error)
                }
                // AlleyError에 있으면 해당 코드 사용
                return Single.error(error)
            }
    }

}



