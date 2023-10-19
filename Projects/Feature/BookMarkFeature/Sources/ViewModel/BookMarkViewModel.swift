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

final class BookMarkViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    var fetchMyBookMarksUseCase: any FetchMyBookMarksUseCase
    
    init(fetchMyBookMarksUseCase: FetchMyBookMarksUseCase!) {
        self.fetchMyBookMarksUseCase = fetchMyBookMarksUseCase
    }
    
    struct Input {
        let fetchDataSource: PublishSubject<Void> = .init()
        let isEdit: BehaviorRelay<Bool> = .init(value: false)
        let tapStateButton: PublishSubject<Void> = .init()
        let tapItem: PublishSubject<Int> = .init()
        
 
    }
    
    struct Output {
        let dataSource: BehaviorRelay<[MyBookMarkEntity]> = .init(value: [])
        let indexOfSelectedItem: BehaviorRelay<[Int]> = .init(value: [])
    }
    
    func transform(input: Input) -> Output {
        
        let output = Output()
        
        input.fetchDataSource
            .flatMap{ [weak self] _ -> Observable<[MyBookMarkEntity]> in
            
                guard let self else {return Observable.empty()}
                
                return self.fetchMyBookMarksUseCase.execute()
                    .asObservable()
                
            }
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
        
        
        //편집 버튼 눌렀을 때 상태 바꿈
        input.tapStateButton
            .withLatestFrom(input.isEdit)
            .map({!$0})
            .bind(to: input.isEdit)
            .disposed(by: disposeBag)
        
        /// 아이템 체크 표시 클릭 시 , 체크 표시되어 있으면  삭제 , 없으면 추가
        input.tapItem
            .withLatestFrom(output.indexOfSelectedItem) { (index, selectedItems) -> [Int] in
                if selectedItems.contains(index) {
                    guard let removeTargetIndex = selectedItems.firstIndex(where: { $0 == index }) else { return selectedItems }
                    var newSelectedItems = selectedItems
                    newSelectedItems.remove(at: removeTargetIndex)
                    
                    return newSelectedItems
                }
                
                else {
                    return selectedItems + [index]
                }
                
            }
            .debug("ID")
            .bind(to: output.indexOfSelectedItem)
            .disposed(by: disposeBag)
        
        /// 선택된 것들의 체크 표시를 반영하기 위한 dataSource 바인딩
        output.indexOfSelectedItem
            .withLatestFrom(output.dataSource){ ($0, $1) }
            .map{ (selectedItems, dataSource) -> [MyBookMarkEntity] in
                var realData = dataSource
                
                realData.indices.forEach({
                    realData[$0].isSelected = false
                })
                
                selectedItems.forEach { i in
                    realData[i].isSelected = true
                }

                return realData
                
            }
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
        
        input.isEdit
            .skip(1)
            .withLatestFrom(output.indexOfSelectedItem){($0, $1)}
            .map({ $0.0 == false ? [] : $0.1 }) // $0.0 == false 편집 종료
            .bind(to: output.indexOfSelectedItem) // 편집 종료 면 , 선택된 애들 모두 해제
            .disposed(by: disposeBag)
            
        
        return output
    }
    
}

