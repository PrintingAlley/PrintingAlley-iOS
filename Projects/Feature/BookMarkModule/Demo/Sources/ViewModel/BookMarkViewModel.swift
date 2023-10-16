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

final class BookMarkViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let isEdit: BehaviorRelay<Bool> = .init(value: false)
        let tapStateButton: PublishSubject<Void> = .init()
 
    }
    
    struct Output {
        let dataSource: BehaviorRelay<[TmpModel]> = .init(value: TmpModel.makeDummy())
        
    }
    
    func transform(input: Input) -> Output {
        
        let output = Output()
        
        input.tapStateButton
            .withLatestFrom(input.isEdit)
            .subscribe(onNext: { [weak self] isEdit in
            
            guard let self else { return }
            
                input.isEdit.accept(!isEdit)
            
        })
        .disposed(by: disposeBag)
        
        
        return output
    }
    
}

struct TmpModel {
    let name: String
    let contents: [TmpContentModel]
    
    static func makeDummy() -> [Self] {
        [TmpModel(name: "즐겨찾기 1", contents: [TmpContentModel(name: "정다운 인쇄소 1", options: ["인쇄","후가공"], adress: "경북 포항시 남구 지곡로 80"), TmpContentModel(name: "정다운 인쇄소 2", options: ["인쇄","후가공"], adress: "경북 포항시 남구 지곡로 80")]),
          TmpModel(name: "즐겨찾기 1", contents: [TmpContentModel(name: "정다운 인쇄소 1", options: ["인쇄","후가공"], adress: "경북 포항시 남구 지곡로 80"), TmpContentModel(name: "정다운 인쇄소 2", options: ["인쇄","후가공"], adress: "경북 포항시 남구 지곡로 80"), TmpContentModel(name: "정다운 인쇄소 2", options: ["인쇄","후가공"], adress: "경북 포항시 남구 지곡로 80")])]
    }
}

struct TmpContentModel {
    let name: String
    let options: [String]
    let adress: String
}
