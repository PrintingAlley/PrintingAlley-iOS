//
//  FillterViewController.swift
//  HomeFeatureDemo
//
//  Created by yongbeomkwak on 10/25/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import BaseFeature
import DesignSystem
import SnapKit
import Then
import BaseDomainInterface
import UtilityModule
import RxSwift

class FilterViewController: UIViewController {

    lazy var titleLabel: AlleyLabel = AlleyLabel("필터",textColor: .sub(.black),font: .subtitle1)
    lazy var closeButton: UIButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.downArrow.image, for: .normal)
        $0.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
    }
    lazy var tableView: UITableView = UITableView().then {
        $0.register(TailFilterTableViewCell.self, forCellReuseIdentifier: TailFilterTableViewCell.identifier)
        $0.register(SecondFilterTableViewCell.self, forCellReuseIdentifier: SecondFilterTableViewCell.identifier)
        $0.register(FilterSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: FilterSectionHeaderView.identifer)
        $0.register(TopCellSectionFooterView.self, forHeaderFooterViewReuseIdentifier: TopCellSectionFooterView.identifer)
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = . none
        $0.bounces = false
    }
    
    lazy var baseLine: UIView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    lazy var findButton: UIButton = UIButton().then {
        $0.backgroundColor = DesignSystemAsset.MainBlue.blue500.color
        $0.setTitle("찾아보기", for: .normal)
        $0.setTitleColor(DesignSystemAsset.Sub.white.color, for: .normal)
        $0.titleLabel?.font = .setFont(.subtitle1)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(tapFind), for: .touchUpInside)
    }
    
    lazy var resetButton: UIButton = UIButton().then {
        $0.setTitle("재설정", for: .normal)
        $0.setTitleColor(DesignSystemAsset.Sub.black.color, for: .normal)
        $0.titleLabel?.font = .setFont(.subtitle2)
        $0.setImage(DesignSystemAsset.Icon.reFresh.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(tapRefresh), for: .touchUpInside)
        
    }
    
    lazy var buttonContainerView: UIView = UIView()
    
    let disposeBag = DisposeBag()
    
    var completion: (([Tag]) -> Void)?
    var idSet: Set<Tag> = .init()
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    var dummy: [ChildrenTagEntity] = []
    
    init(completion: (([Tag]) -> Void)? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.completion = completion
        
    }
    
    deinit {
        DEBUG_LOG("\(Self.self) Deinit ❌")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        configureCommonUI()
        dummy = makeDummy()
        bindGesture()
        
        tableView.reloadData()
        
        NotificationCenter.default.rx.notification(Notification.Name("filterToggle"))
            .subscribe(onNext: { [weak self] (notification) in
                
                guard let self else {return}
                guard let tag = notification.object as? Tag else { return }
                
                if idSet.contains(tag) {
                    idSet.remove(tag)
                } else {
                    idSet.insert(tag)
                }
                
                DEBUG_LOG(idSet)
            })
            .disposed(by: disposeBag)
        
    }
    
    
    @objc func tapRefresh() {
        idSet.removeAll()
        NotificationCenter.default.post(name:Notification.Name("refreshFilter") , object: nil)
    }
    
    @objc func tapFind() {
        self.dismiss(animated: true)
        self.completion?(Array<Tag>(idSet))
    }
    
    @objc func tapClose() {
        self.dismiss(animated: true)
    }
}

extension FilterViewController {
    
    func addSubviews() {
        self.view.addSubviews(titleLabel, closeButton, tableView, buttonContainerView,baseLine)
        self.buttonContainerView.addSubviews(resetButton,findButton)
    }
    
    func makeConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(18)
            $0.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.left.equalToSuperview().inset(24)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        tableView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.bottom.equalTo(baseLine.snp.top)
        }
        
        baseLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(buttonContainerView.snp.top).offset(-8)
        }
        
        buttonContainerView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        
        resetButton.snp.makeConstraints {
            
            $0.left.equalToSuperview()
            $0.right.equalTo(findButton.snp.left).offset(-20)
            $0.centerY.equalTo(findButton.snp.centerY)
            $0.height.equalTo(24)
            $0.width.equalTo(68)
        }
        
        findButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(56)
        }
    }
    
    func bindGesture() {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let distance = gestureRecognizer.translation(in: self.view)
        let height = APP_HEIGHT()
        
        switch gestureRecognizer.state {
                case .began:
                    return
                    
                case .changed:
                    let distanceY = max(distance.y, 0)
                    view.frame = CGRect(x: 0, y: distanceY, width: view.frame.width, height: height)
                    let opacity = 1 - (distanceY / height)

                    self.updateOpacity(value: Float(opacity))
                    
                case .ended:
                    let velocity = gestureRecognizer.velocity(in: self.view)
                    
                    // 빠르게 드래그하거나 화면의 40% 이상 드래그 했을 경우 dismiss
                    if velocity.y > 1000 || view.frame.origin.y > (height * 0.3) {
                        dismiss(animated: true)
                    } else {
                        UIView.animate(withDuration: 0.35,
                                       delay: 0.0,
                                       usingSpringWithDamping: 0.8,
                                       initialSpringVelocity: 0.8,
                                       options: [.curveEaseInOut],
                                       animations: {
                            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: height)
                            self.updateOpacity(value: 1)
                        })
                    }
                    
                default:
                    break
                }
    }
    
    func updateOpacity(value: Float) {
        self.view.layer.opacity = value
    }
    
    func makeDummy() -> [ChildrenTagEntity] {
        return [
        ChildrenTagEntity(id: 1, name: "수량", image: "", parentID: 2, children: [
            
            ChildrenTagEntity(id: 2, name: "소량인쇄", image: "", parentID: 12, children: []),
            ChildrenTagEntity(id: 3, name: "대량인쇄", image: "", parentID: 12, children: []),
            ChildrenTagEntity(id: 4, name: "대량인쇄", image: "", parentID: 12, children: []),
            ChildrenTagEntity(id: 5, name: "대량인쇄", image: "", parentID: 12, children: []),
            ChildrenTagEntity(id: 6, name: "대량인쇄", image: "", parentID: 12, children: []),
        ]),
        ChildrenTagEntity(id: 7, name: "후가공", image: "", parentID: 12, children: [
             
            ChildrenTagEntity(id: 8, name: "코딩", image: "", parentID: 8, children: [
                
                ChildrenTagEntity(id: 9, name: "무광/ 유광 코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 10, name: "엠보코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 11, name: "CR코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 12, name: "무광/ 유광 코팅2", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 13, name: "무광/ 유광 코팅3", image: "", parentID: 12, children: [])
            
            ]),
            
            ChildrenTagEntity(id: 14, name: "코딩123", image: "", parentID: 8, children: [
                
                ChildrenTagEntity(id: 15, name: "무광/ 유광 코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 16, name: "엠보코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 17, name: "CR코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 18, name: "무광/ 유광 코팅2", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 19, name: "무광/ 유광 코팅3", image: "", parentID: 12, children: [])
            
            ])
        
        ]),
        
        ChildrenTagEntity(id: 20, name: "후가공", image: "", parentID: 12, children: [
            
            ChildrenTagEntity(id: 21, name: "코딩", image: "", parentID: 8, children: [
                
                ChildrenTagEntity(id: 22, name: "무광/ 유광 코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 23, name: "엠보코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 24, name: "CR코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 25, name: "무광/ 유광 코팅2", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 26, name: "박 ", image: "", parentID: 12, children: [])
            
            ])
        
        ]),
        
        ChildrenTagEntity(id: 27, name: "후가공", image: "", parentID: 12, children: [

            ChildrenTagEntity(id: 28, name: "코딩", image: "", parentID: 8, children: [
                
                ChildrenTagEntity(id: 29, name: "무광/ 유광 코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 30, name: "엠보코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 31, name: "CR코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 32, name: "무광/ 유광 코팅2", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 33, name: "박 ", image: "", parentID: 12, children: [])
            
            ])
        
        ])
    
    ]
    }
    
}

extension FilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let section = indexPath.section
        let row = indexPath.row
        
        let numberOfItem = dummy[section].children[row].children.isEmpty ? dummy[section].children.count : dummy[section].children[row].children.count

        let tempLabel = AlleyLabel("않입값히", font: .body1).then {
            $0.sizeToFit()
        }
        
        let subtitleLabel =  AlleyLabel("소제목 소제목",font: .subtitle3).then{
            $0.sizeToFit()
        }
        
        let h1: CGFloat = tempLabel.frame.height + 8
        
        let h2: CGFloat = subtitleLabel.frame.height
        
        let numberOfrow = numberOfItem % 3 == .zero ?  numberOfItem / 3 : numberOfItem / 3 + 1 // 필터 줄
        
        let offset1: CGFloat = 16.0
        let offset2: CGFloat = 8.0

        if dummy[section].children[row].children.isEmpty {
            
            // (row 수 * 셀크기 ) + (row-1 셀간격) + 하단에서 보정값
            return CGFloat(numberOfrow) * h1 + (CGFloat(numberOfrow-1)*offset2) + offset1
        } else  {
             
            // 셀 상단부터 제목까지 거리(offset1) + 제목 크기(h2) + (행 * 필터크기) + ( 행-1 * 간격) +  하단에서 보정값
            return offset2 + h2 + offset2 + (CGFloat(numberOfrow) * h1 ) + (CGFloat(numberOfrow-1) * offset2) + offset1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section != .zero ? UITableView.automaticDimension : .zero
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        section == .zero ? UITableView.automaticDimension : .zero
    }
}

extension FilterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dummy.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        //  2층 구조면 1개 , 아니면 children 개수 만큼 row
        return dummy[section].children.first?.children.isEmpty ?? true ? 1 : dummy[section].children.count
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == .zero {
            return nil
        }
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FilterSectionHeaderView.identifer) as? FilterSectionHeaderView else {
            return UIView()
        }
        
        header.update(name: dummy[section].name)
        return header
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section != .zero {
            return nil
        }
        
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: TopCellSectionFooterView.identifer) as? TopCellSectionFooterView else {
            return UIView()
        }
        return footer
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
             
        if dummy[section].children[row].children.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TailFilterTableViewCell.identifier, for: indexPath) as? TailFilterTableViewCell else {
                return UITableViewCell()
            }
            
            cell.update(model: dummy[section])
            cell.selectionStyle = .none 
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondFilterTableViewCell.identifier, for: indexPath) as? SecondFilterTableViewCell else {
                
                return UITableViewCell()
            }
            
            cell.update(model: dummy[section].children[row])
            cell.selectionStyle = .none
            return cell
        }
    }
}
