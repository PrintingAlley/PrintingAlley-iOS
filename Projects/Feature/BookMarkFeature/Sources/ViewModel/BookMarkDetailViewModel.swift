//
//  BookMarkViewModel.swift
//  BookMarkModuleDemo
//
//  Created by yongbeomkwak on 10/14/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import UtilityModule
import BookMarkDomainInterface


public final class BookMarkDetailViewModel: ViewModelType {
    
    
    var fetchBookMarkDetailUseCase: any FetchBookMarkDetailUseCase
    var removeBookMarkUseCase: any RemoveBookMarkUseCase
    
    init(fetchBookMarkDetailUseCase: FetchBookMarkDetailUseCase, removeBookMarkUseCase: RemoveBookMarkUseCase) {
        self.fetchBookMarkDetailUseCase = fetchBookMarkDetailUseCase
        self.removeBookMarkUseCase = removeBookMarkUseCase
    }
    
    public struct Input {
        
    }
    
    public struct Output {
        let dataSource: BehaviorRelay<[TmpModel]> = .init(value: TmpModel.makeDummy())
    }
    
    public func transform(input: Input) -> Output {
        let output = Output()
        
        
        return output
    }
    
    
 
    
}

struct TmpModel {
    let id: Int = 0
    let name: String
    let location: String
    let types: [String]
    
    static func makeDummy() -> [Self] {
        [TmpModel(name: "정다운 인쇄소124124125125215152ㅁㅎㅎ", location: "경북 포항시 남구 지곡로 801241241242515215", types: ["인쇄", "후가공"]),
         TmpModel(name: "정다운 인쇄소123451251251251251251", location: "경북 포항시 남구 지곡로 80125151251241241241241241421", types: ["인쇄", "비가공"])
        ]
    }
}


