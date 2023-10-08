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

public class MyPageContentViewController: UIViewController {

    lazy var profileImage: ImageButton = ImageButton()
    
    lazy var profileLabel: AlleyLabel = AlleyLabel().then {
        $0.numberOfLines = 0
    }
    
    lazy var headerVIew: MyPageHeaderView = MyPageHeaderView(frame: CGRect(x: .zero, y: .zero, width: APP_WIDTH(), height: 80)).then {
        $0.deleagte = self
    }
    
    lazy var tableView: UITableView = UITableView().then {
        $0.register(MyPageCategoryTableViewCell.self, forCellReuseIdentifier: MyPageCategoryTableViewCell.identifier)
        $0.dataSource = self
        $0.delegate = self
        $0.separatorStyle = .none // 구분선 제거
        $0.bounces = false // 오버 스크롤 방지
        $0.tableHeaderView = headerVIew
    }
    
    var viewModel: MyPageContentViewModel!
    
    init(viewModel: MyPageContentViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addSubViews()
        preProcessing()
        makeConstraints()

    }
    
}

extension MyPageContentViewController {
    func preProcessing() {
        self.profileImage.delegate = self
        self.profileImage.setImage(image: DesignSystemAsset.Icon.profilePlaceHolder.image)
        
        // TODO: 닉네임 프리퍼런스 매니저 연결
        profileLabel.setTitle(title: "첫 번째 골목대장 ", textColor: .sub(.black), font: .subtitle1)
    }
    
    func addSubViews() {
        self.view.addSubviews(profileImage, profileLabel, tableView)
    }
    
    func makeConstraints() {
        profileImage.snp.makeConstraints {
            $0.width.height.equalTo(64)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.left.equalToSuperview().inset(25)
        }
        
        profileLabel.snp.makeConstraints {
            $0.left.equalTo(profileImage.snp.right).offset(24)
            $0.right.equalToSuperview()
            $0.centerY.equalTo(profileImage.snp.centerY).offset(-10)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(40)
            $0.left.right.bottom.equalToSuperview()
        }
        
    }
}

extension MyPageContentViewController: ImageButtonDelegate {
    public func action() { // TODO: 프로필 이미지 변경
        DEBUG_LOG("ACT")
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

extension MyPageContentViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch viewModel.categories[indexPath.row] {
                // TODO: 추후 해당 화면 이동 코드
//        case .notice:
//
//        case .faq:
//
//        case .request:
//
//        case .service:
            
        default:
            print(viewModel.categories[indexPath.row])
            
        }
        
    }
}

extension MyPageContentViewController: MyPageHeaderViewDelegate {
    public func headerTap(type: HeaderItemType) {
        DEBUG_LOG(type)
    }
 
}
