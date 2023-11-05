//
//  RootViewController.swift
//  RootFeature
//
//  Created by yongbeomkwak on 2023/09/24.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import UtilityModule
import SnapKit
import Then
import MainTabFeatureInterface
import RxSwift

public class RootViewController: UIViewController {

    
    var viewModel: RootViewModel!
    var mainTabFactory: MainTabFactory!
    let input: RootViewModel.Input = .init()
    let disposeBag = DisposeBag()
    
    lazy var label: UILabel = UILabel().then{
        $0.text = "스플래쉬"
        $0.textColor = .blue
    }
    
    
    init(mainTabFactory: MainTabFactory ,viewModel: RootViewModel!) {
        self.mainTabFactory = mainTabFactory
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        configureCommonUI()
        bidViewModel()
        
        DEBUG_LOG("APPVER \(APP_VERSION())")
    }

}

extension RootViewController {
    func addSubviews() {
        self.view.addSubview(label)
    }
    
    func makeConstraints() {
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func bidViewModel() {
        let output = viewModel.transform(input: input)
     
        /*
          1. 앱 버전 체크 하며 네트워크 체크
          2.
         
         */
        
        bindStartLottieAndAppCheck(input: input)
        bindMoveMain(output: output)
        
    }
    
    func bindStartLottieAndAppCheck(input: RootViewModel.Input) {
        input.startLottie.onNext(())
        input.fetchAppCheck.onNext(())
    }
    
    func bindEndLottie(output: RootViewModel.Output) {
        output.endLottie
            .withUnretained(self)
            .subscribe(onNext: { (owner,_) in 
            
        })
    }
    
    func bindMoveMain(output: RootViewModel.Output) {
        output.moveMain
            .withUnretained(self)
            .subscribe(onNext: { (owner,_) in
                owner.navigationController?.pushViewController(owner.mainTabFactory.makeView(), animated: false)
            })
            .disposed(by: disposeBag)
    }
}
