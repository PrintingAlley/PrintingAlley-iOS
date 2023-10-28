//
//  TestAPI.swift
//  ReviewFeatureDemo
//
//  Created by yongbeomkwak on 10/28/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import Moya

public protocol TestAPI: TargetType {
    
}


extension TestAPI {
    public var baseURL: URL {
        URL(string: "https://dev.printingstreets.com")!
    }
    
    public var path: String {
        "/upload"
    }

    public var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }

    public var validationType: ValidationType {
        .successCodes
    }
    

}

public enum TestAPIImpl {
    case upload(data: Data)
}

extension TestAPIImpl: TestAPI {
    public var method: Moya.Method {
        .post
    }
    
    public var task: Moya.Task {
        switch self {
            
        case .upload(data: let data):
            let imageData = MultipartFormData(provider: .data(data), name: "file" ,fileName: "file")
            
            return .uploadMultipart([imageData])
        }
    }
    
    
}

