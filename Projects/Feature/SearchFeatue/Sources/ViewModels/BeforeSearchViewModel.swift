//
//  BeforeSearchViewModel.swift
//  SearchFeatue
//
//  Created by 박의서 on 2023/10/25.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import UtilityModule
import RxRelay
import RxSwift
import BaseFeature

final class BeforeSearchViewModel: ViewModelType {
    public struct Input {
        let viewDidLoad: PublishSubject<Void> = .init()
        // PublishSubject: Element 없이 빈 상태로 생성되고, subscribe 시점 이후에 발생되는 이벤트만 전달받음.
    }
    
    public struct Output {
        // TODO: - 추천 검색어 연결 필요
        let dataSource: BehaviorRelay<[RecommendModel]> = .init(value: RecommendModel.makeDummy()) // 더미모델을 초기값으로 가지는 Relay 생성
        // Relay 는 .completed, .error를 발생시키지 않고 Dispose 되기 전까지 계속 동작하므로 UI 작업에 용이
    }
    
    public func transform(input: Input) -> Output {
        let output = Output()
        
        return output
    }
}
