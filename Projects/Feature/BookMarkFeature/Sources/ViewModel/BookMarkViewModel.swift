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
import BaseDomainInterface

final class BookMarkViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    var fetchMyBookMarksUseCase: any FetchMyBookMarksUseCase
    var removeBookMarkGroupUseCase: any RemoveBookMarkGroupUseCase
    
    init(fetchMyBookMarksUseCase: FetchMyBookMarksUseCase!, removeBookMarkGroupUseCase: RemoveBookMarkGroupUseCase) {
        self.fetchMyBookMarksUseCase = fetchMyBookMarksUseCase
        self.removeBookMarkGroupUseCase = removeBookMarkGroupUseCase
    }
    
    struct Input {
        let fetchDataSource: PublishSubject<Void> = .init()
        let isEdit: BehaviorRelay<Bool> = .init(value: false)
        let tapStateButton: PublishSubject<Void> = .init()
        let tapItem: PublishSubject<Int> = .init()
        let runDelete: PublishSubject<Void> = .init()
        
    }
    
    struct Output {
        let dataSource: BehaviorRelay<[MyBookMarkEntity]> = .init(value: [])
        let indexOfSelectedItem: BehaviorRelay<[Int]> = .init(value: [])
        let showToast: PublishSubject<BaseEntity> = .init()
        let runIndicator: BehaviorRelay<Void> = .init(value: ())
    }
    
    func transform(input: Input) -> Output {
        
        let output = Output()
        
        bindFetchDataSource(input: input, output: output)
        bindTapEditButton(input: input)
        bindInputTapItem(input: input, output: output)
        bindIndexOfSelected(output: output)
        bindIsEdit(input: input, output: output)
        bindRunDelete(input: input, output: output)
        
        return output
    }
    
}

///input
extension BookMarkViewModel {
    
    //편집모드 on/off
    func bindIsEdit(input: Input, output: Output) {
        input.isEdit
            .skip(1)
            .withLatestFrom(output.indexOfSelectedItem){($0, $1)}
            .map({ $0.0 == false ? [] : $0.1 }) // $0.0 == false 편집 종료
            .bind(to: output.indexOfSelectedItem) // 편집 종료 면 , 선택된 애들 모두 해제
            .disposed(by: disposeBag)
    }
    
    func bindInputTapItem(input: Input, output: Output) {
        /// 아이템 체크 표시 클릭 시 , 체크 표시되어 있으면  삭제 , 없으면 추가
        input.tapItem
            .withLatestFrom(output.indexOfSelectedItem) { (id, selectedItems) -> [Int] in
                
                var selectedItemsSet = Set(selectedItems)
                
                if selectedItemsSet.contains(id) {
                    selectedItemsSet.remove(id)
                }
                
                else {
                    selectedItemsSet.insert(id)
                }
                
                return Array(selectedItemsSet)
                
            }
            .bind(to: output.indexOfSelectedItem)
            .disposed(by: disposeBag)
    }
    
    func bindTapEditButton(input: Input) {
        
        //편집 버튼 눌렀을 때 상태 바꿈
        input.tapStateButton
            .withLatestFrom(input.isEdit)
            .map({!$0})
            .bind(to: input.isEdit)
            .disposed(by: disposeBag)
    }
    
    func bindFetchDataSource(input: Input, output: Output) {
        input.fetchDataSource
            .flatMap{ [weak self] _ -> Observable<[MyBookMarkEntity]> in
            
                guard let self else {return Observable.empty()}
                
                return self.fetchMyBookMarksUseCase.execute()
                    .asObservable()
                
            }
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
    }
    
    func bindRunDelete(input: Input, output: Output){
        
        input.runDelete
            .withLatestFrom(output.indexOfSelectedItem){$1}
            .withUnretained(self)
            .flatMap({ (owner,ids) -> Observable<BaseEntity> in
            
                return owner.removeBookMarkGroupUseCase
                    .execute(ids: ids)
                    .catch({ error in
                        
                        let alleryError = error.asAlleyError
                        
                        if alleryError == .tokenExpired {
                            return Single<BaseEntity>.create { single in
                                single(.success(BaseEntity(statusCode: 401, message: alleryError.errorDescription)))
                                return Disposables.create()
                            }
                        }
                        
                        return Single<BaseEntity>.create { single in
                            single(.success(BaseEntity(statusCode: 0, message: alleryError.errorDescription)))
                            return Disposables.create()
                        }
                    })
                    .asObservable()
            })
            .bind(to: output.showToast)
            .disposed(by: disposeBag)
    }
}


///output
extension BookMarkViewModel {
    func bindIndexOfSelected(output: Output) {
        /// 선택된 것들의 체크 표시를 반영하기 위한 dataSource 바인딩
        output.indexOfSelectedItem
            .withLatestFrom(output.dataSource){ ($0, $1) }
            .map{ (selectedItems: Array<Int>, dataSource) -> [MyBookMarkEntity] in
                var realData = dataSource
                
                var selectedItemsSet = Set(selectedItems)
                
                realData.indices.forEach({
                    realData[$0].isSelected = selectedItemsSet.contains(realData[$0].id)
                })
                

                return realData
                
            }
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
    }
}

