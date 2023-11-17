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
import DesignSystem
import Lottie

public class RootViewController: UIViewController {

    
    var viewModel: RootViewModel!
    var mainTabFactory: MainTabFactory!
    let input: RootViewModel.Input = .init()
    let disposeBag = DisposeBag()
    
    lazy var logoContentView: UIView = UIView()
        
    
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
        
        self.view.backgroundColor = DesignSystemAsset.MainBlue.blue500.color
        lottiePlay()
    }

}

extension RootViewController {
    func addSubviews() {
        self.view.addSubview(logoContentView)
    }
    
    func makeConstraints() {
        logoContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bidViewModel() {
        let output = viewModel.transform(input: input)
     
        bindStartLottieAndAppCheck(input: input)
        bindVersionCheck(input: input, output: output)
        bindUserResult(output: output)
        
        
    }
    
    func bindStartLottieAndAppCheck(input: RootViewModel.Input) {
        input.startLottie.onNext(())
        input.fetchVersionCheck.onNext(())
        lottiePlay()
    }
    
    
    func bindVersionCheck(input: RootViewModel.Input, output: RootViewModel.Output) {
        
        output.appCheckReesult
            .withUnretained(self)
            .subscribe(onNext: { (owner, result) in
                
                switch result {
                    
                case let .success(entity):
                    
                    var alertVc: AlertViewController
                    
                    
                    switch entity.code {
                        
                    case 0: //성공
                        input.fetchUserCheck.onNext(())
                        return
                    
                    case 1: // 업데이트 권유
                        alertVc = AlertViewController(title: "인쇄골목 업데이트 알림", content: "최신 버전으로 업데이트 후 이용하시기 바랍니다.감사합니다.", type: .offerUpdate,completion: {
                            owner.goAppStore()
                        } ,cancelCompletion: {
                            input.fetchUserCheck.onNext(())
                        })
                        
                    case 2:
                        alertVc = AlertViewController(title: "인쇄골목 업데이트 알림", content: "최신 버전으로 업데이트 후 이용하시기 바랍니다.감사합니다.", type: .forceUpdate,completion: {
                            owner.goAppStore()
                        })
                        
                    
                    
                    default:
                        
                        alertVc = AlertViewController(title: "네트워크 알림", content: entity.message, type: .exit,completion: {
                            exit(0)
                        })
                        
                        
                    }
                    
                    alertVc.modalPresentationStyle = .overFullScreen
                    
                    owner.present(alertVc, animated: false)
                    
                    
                
                case let .failure(error):
                    let vc = AlertViewController(title: "오류 발생",content: error.asAlleyError.localizedDescription, type: .exit) {
                        exit(0)
                    }
                    
                    vc.modalPresentationStyle = .overFullScreen
                    
                    owner.present(vc, animated: false)
                    
                }
                
            })
            .disposed(by: disposeBag)
        
    }
    
    func bindUserResult(output: RootViewModel.Output) {
        
        Observable.zip(output.userInfoResult, output.endLottie)
            .map{$0.0}
            .withUnretained(self)
            .subscribe(onNext: { (owner, result) in
                
                let vc = AlertViewController(title: "인증 만료", content: result.message, type: .logout,completion: {
                    LOGOUT()
                    owner.navigationController?.pushViewController(owner.mainTabFactory.makeView(), animated: false)
                })
                
                vc.modalPresentationStyle = .overFullScreen
                
                switch result.isValid {
                    
                case true:
                    owner.navigationController?.pushViewController(owner.mainTabFactory.makeView(), animated: false)
                case false:
                    owner.present(vc, animated: false)
    
                }
                
            })
        
        
    }
}


extension RootViewController {
    func goAppStore() {
        let appID: String = APP_ID()
        guard let storeURL = URL(string: "https://itunes.apple.com/kr/app/id/\(appID)"),
            UIApplication.shared.canOpenURL(storeURL) else { return }
        UIApplication.shared.open(storeURL)
    }
    
    private func lottiePlay() {
        let animationView = LottieAnimationView(name: "Splash", bundle: DesignSystemResources.bundle)
        animationView.frame = self.logoContentView.bounds
        animationView.backgroundColor = .clear
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .playOnce

        self.logoContentView.addSubview(animationView)
        
        let originWidth: CGFloat = 156.0
        let originHeight: CGFloat = 160.0
        let rate: CGFloat = originHeight/max(1.0, originWidth)

        let width: CGFloat = (156.0 * APP_WIDTH()) / 375.0
        let height: CGFloat = width * rate

        animationView.snp.makeConstraints {
            $0.width.equalTo(width)
            $0.height.equalTo(height)
            $0.centerX.equalTo(self.logoContentView.snp.centerX)
            $0.centerY.equalTo(self.logoContentView.snp.centerY).offset(-16)
        }
        animationView.play()
    }
}
