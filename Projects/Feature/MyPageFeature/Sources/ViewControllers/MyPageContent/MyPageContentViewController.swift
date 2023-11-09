//
//  MyPageContentViewController.swift
//  MyPageFeature
//
//  Created by yongbeomkwak on 2023/09/30.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import Then
import SnapKit
import UtilityModule
import DesignSystem
import MessageUI // import For MailSystem
import BookMarkFeatureInterface
import RxSwift
import BaseFeatureInterface
import AuthDomainInterface

public class MyPageContentViewController: UIViewController {

    var bookMarkFactory: BookMarkFactory!
    var editModalFactory: EditModalFactory!
    var viewModel: MyPageContentViewModel!
    let disposeBag = DisposeBag()
    let input = MyPageContentViewModel.Input()
    lazy var profileImage: UIButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.profilePlaceHolder.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
    }
    
    lazy var profileLabel: AlleyLabel = AlleyLabel().then {
        $0.numberOfLines = 0
    }
    
    lazy var profileNameEditButton: UIButton = UIButton().then {
        $0.setTitle("프로필 수정", for: .normal)
        $0.setImage(DesignSystemAsset.Icon.smallPencil.image, for: .normal)
        $0.setTitleColor(DesignSystemAsset.Grey.grey500.color, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.titleLabel?.font = .setFont(.caption1)
        $0.contentHorizontalAlignment = .center // // how to position content horizontally inside control. default is center
        $0.semanticContentAttribute = .forceRightToLeft //<- 중요
        //$0.imageEdgeInsets = .init(top: 0, left: 15, bottom: 0, right: 15) //<- 중요
    }
    
    lazy var headerView: MyPageHeaderView = MyPageHeaderView(frame: CGRect(x: .zero, y: .zero, width: APP_WIDTH(), height: 78)).then {
        $0.deleagte = self
    }
    
    lazy var footerView: MyPageFooterView = MyPageFooterView(frame: CGRect(x: .zero, y: .zero, width: APP_WIDTH(), height: 150))
    
    lazy var tableView: UITableView = UITableView().then {
        $0.register(MyPageCategoryTableViewCell.self, forCellReuseIdentifier: MyPageCategoryTableViewCell.identifier)
        $0.dataSource = self
        $0.delegate = self
        $0.separatorStyle = .none // 구분선 제거
        $0.bounces = false // 오버 스크롤 방지
        $0.tableHeaderView = headerView
        $0.tableFooterView = footerView
    }
    
    
    
    init(bookMarkFactory: BookMarkFactory, editModalFactory: EditModalFactory, viewModel: MyPageContentViewModel!) {
        
        self.viewModel = viewModel
        self.bookMarkFactory = bookMarkFactory
        self.editModalFactory = editModalFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureCommonUI()
        addSubViews()
        preProcessing()
        makeConstraints()
        bindViewModel()

    }
    
}

extension MyPageContentViewController {
    func preProcessing() {
        
        footerView.deleagte = self
        
    }
    
    func addSubViews() {
        self.view.addSubviews(profileImage, profileLabel, tableView, profileNameEditButton)
    }
    
    func makeConstraints() {
        profileImage.snp.makeConstraints {
            $0.width.height.equalTo(64)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(49)
            $0.left.equalToSuperview().inset(25)
        }
        
        profileLabel.snp.makeConstraints {
            $0.left.equalTo(profileImage.snp.right).offset(24)
            $0.right.equalToSuperview()
            $0.centerY.equalTo(profileImage.snp.centerY).offset(-10)
        }
        
        profileNameEditButton.snp.makeConstraints {
            $0.left.equalTo(profileLabel.snp.left)
            $0.width.equalTo(80)
            $0.height.equalTo(24)
            $0.top.equalTo(profileLabel.snp.bottom)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(37)
            $0.left.right.bottom.equalToSuperview()
        }
        
    }
    
    func showMail() {
        if MFMailComposeViewController.canSendMail() {
            
            let preBody: String = "\n\n닉네임: 익명의 제보자\n앱 버전: \(APP_VERSION())\nOS: \(OS_NAME()) \(OS_VERSION())"
            
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients(["printingstreet.cmyk@gmail.com"])
            composeVC.setSubject("인쇄골목 문의드립니다")
            composeVC.setMessageBody(preBody, isHTML: false)
            self.present(composeVC, animated: true)
        }
        else {
            DEBUG_LOG("메일 계정이 설정되어 있지 않습니다.\n설정 > Mail 앱 > 계정을 설정해주세요.")
        }
        
    }
    
    func bindViewModel() {
        
        let output = viewModel.transform(input: input)
        
        bindRefresh(input: input)
        bindPreference()
        bindUserInfo(output: output)
        bindEditName()
        bindShowToast(output: output)
        
        
    }
}


extension MyPageContentViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageCategoryTableViewCell.identifier, for: indexPath) as? MyPageCategoryTableViewCell  else {
             return UITableViewCell()
        }
        
        cell.update(category: viewModel.categories[indexPath.row])
        cell.selectionStyle = .none // 선택 시 색깔 없애기
        
        return cell
    }
    
}






