//
//  MyPageHeaderView.swift
//  MyPageFeature
//
//  Created by yongbeomkwak on 2023/10/08.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import UtilityModule

public protocol MyPageHeaderViewDelegate: AnyObject {
    func headerTap(type: HeaderItemType)
}

class MyPageHeaderView: UIView {
    
    lazy var baseLine = UIView().then {
        $0.backgroundColor = .black
     }
    
    lazy var flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
        $0.bounces = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(MyPageCollectionViewCell.self, forCellWithReuseIdentifier: MyPageCollectionViewCell.identifer)
        $0.backgroundColor = .red
    }
    
    let headers: [HeaderItemType] = [.notice, .bookMark, .like]
    
    weak var deleagte: MyPageHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(baseLine, collectionView)
        makeConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }

}

extension MyPageHeaderView {
    func makeConstraints() {
        
        collectionView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(47)
            $0.top.equalToSuperview()
            $0.bottom.equalTo(baseLine.snp.top).offset(-16)
        }
        
        baseLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.right.bottom.equalToSuperview()
        }
        
    }
}

extension MyPageHeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        deleagte?.headerTap(type: headers[indexPath.row])
    }
}

extension MyPageHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        headers.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCollectionViewCell.identifer, for: indexPath) as? MyPageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        print(headers[indexPath.row])
        cell.update(type: headers[indexPath.row])
        
        cell.backgroundColor = .green
        return cell
    }
    
}

extension  MyPageHeaderView: UICollectionViewDelegateFlowLayout {
    // MARK: cellSize
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
          let collectionViewWidth = collectionView.bounds.width
          let cellItemForRow: CGFloat = 3
          let minimumSpacing: CGFloat = 2

          let width = (collectionViewWidth - (cellItemForRow - 1) * minimumSpacing) / cellItemForRow
          
          return CGSize(width: 60, height: 60)
      }
    
    // 섹션안에 Item 끼리 간격
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 60
    }
    
    // MARK: minimumSpacing
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
      

}
