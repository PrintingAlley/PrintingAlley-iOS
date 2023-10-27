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

public protocol FilterViewControllerDelegate: AnyObject {
    func receive(result: [Int])
}


class FilterViewController: UIViewController {

    lazy var titleLabel: AlleyLabel = AlleyLabel("필터",textColor: .sub(.black),font: .subtitle1)
    lazy var closeButton: UIButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.downArrow.image, for: .normal)
        $0.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
    }
    
    
    lazy var tableView: UITableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(TailFilterTableViewCell.self, forCellReuseIdentifier: TailFilterTableViewCell.identifier)
        $0.register(SecondFilterTableViewCell.self, forCellReuseIdentifier: SecondFilterTableViewCell.identifier)
        $0.register(FilterSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: FilterSectionHeaderView.identifer)
        $0.register(TopCellSectionFooterView.self, forHeaderFooterViewReuseIdentifier: TopCellSectionFooterView.identifer)
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = . none
        $0.bounces = false
        $0.backgroundColor = .white
    }
    
    lazy var baseLine: UIView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    lazy var findButton: UIButton = UIButton().then {
        $0.backgroundColor = DesignSystemAsset.MainBlue.blue500.color
        $0.setTitle("인쇄소 찾아보기", for: .normal)
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
    
    var viewModel: FilterViewModel!
    public weak var deleagte: FilterViewControllerDelegate?
    
    let disposeBag = DisposeBag()
    
    var idSet:Set<Int> = .init()
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    
    init(viewModel: FilterViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        
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
        bindViewModel()
        bindGesture()
        
        NotificationCenter.default.rx.notification(Notification.Name("filterToggle"))
            .subscribe(onNext: { [weak self] (notification) in
                
                guard let self else {return}
                guard let id = notification.object as? Int else { return }
                
                if idSet.contains(id) {
                    idSet.remove(id)
                } else {
                    idSet.insert(id)
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
        self.deleagte?.receive(result: (Array<Int>(idSet)))
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
    
    func bindViewModel() {
        let input = FilterViewModel.Input()
        let output = viewModel.transform(input: input)
        
        viewModel.dataSource
            .withUnretained(self)
            .subscribe(onNext: { (owner,dataSource) in
                owner.tableView.reloadData()
        })
        .disposed(by: disposeBag)
        
    }
    
    
}


extension FilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let section = indexPath.section
        let row = indexPath.row
        
        let numberOfItem = viewModel.dataSource.value[section].children[row].children.isEmpty ? viewModel.dataSource.value[section].children.count : viewModel.dataSource.value[section].children[row].children.count
        
        
        let tempLabel = AlleyLabel("않입값히ㅁㄴㅇ", font: .body1).then {
            $0.sizeToFit()
        }
        
        let subtitleLabel =  AlleyLabel("소제목 소제목",font: .subtitle3).then{
            $0.sizeToFit()
        }
        
        let h1: CGFloat = tempLabel.frame.height + 8
        
        let h2: CGFloat = subtitleLabel.frame.height
        
        let numberOfrow = numberOfItem % 4 == .zero ?  numberOfItem / 4 : numberOfItem / 4 + 1 // 필터 줄
        
        let offset1: CGFloat = 16.0
        let offset2: CGFloat = 8.0

        
        if viewModel.dataSource.value[section].children[row].children.isEmpty {
            
            // (row 수 * 셀크기 ) + (row-1 셀간격) + 하단에서 보정값
            return CGFloat(numberOfrow) * h1 + (CGFloat(numberOfrow-1)*offset2) + offset1
        }
        
        else  {
             
            // 셀 상단부터 제목까지 거리(offset1) + 제목 크기(h2) + (행 * 필터크기) + ( 행-1 * 간격) +  하단에서 보정값
            return offset2 + h2 + offset2 + (CGFloat(numberOfrow) * h1 ) + (CGFloat(numberOfrow-1) * offset2) + offset1
        }
        

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        section == .zero ? .zero :  UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        section != .zero ? 16 : UITableView.automaticDimension
    }
    

}

extension FilterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        DEBUG_LOG(viewModel.dataSource.value.count)
        return viewModel.dataSource.value.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        var thirdFloor: Int = 0
        var secondFloor: Int = 0
        
        
        for child in  viewModel.dataSource.value[section].children {
            if child.children.isEmpty {
                secondFloor += 1
            }
            
            else {
                thirdFloor += 1
            }
        }
        
        return thirdFloor + (secondFloor != .zero ? 1 : 0) // 마지막 +1은 2층구조를 더해주기 위해
        
    }
    


    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        if section == .zero {
            return nil
        }
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FilterSectionHeaderView.identifer) as? FilterSectionHeaderView else {
            
            
            return UIView()
        }
        
        header.update(name: viewModel.dataSource.value[section].name)
        return header
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        
        if section == .zero {
            guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: TopCellSectionFooterView.identifer) as? TopCellSectionFooterView else {
                return UIView()
            }
            
            return footer
        }
        
        else {
        
            let view = UIView(frame: CGRect(x: 0, y: 0, width: APP_WIDTH(), height: 16))
            
            return view

        }
                
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
             
        
        if viewModel.dataSource.value[section].children[row].children.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TailFilterTableViewCell.identifier, for: indexPath) as? TailFilterTableViewCell else {
                return UITableViewCell()
            }
            
            cell.update(model: viewModel.dataSource.value[section])
            cell.selectionStyle = .none
        
            
            return cell
        }
        
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondFilterTableViewCell.identifier, for: indexPath) as? SecondFilterTableViewCell else {
                
                return UITableViewCell()
            }
            
            cell.update(model: viewModel.dataSource.value[section].children[row])
            cell.selectionStyle = .none
            return cell
            
        }
        
        
    }
    
    
}


