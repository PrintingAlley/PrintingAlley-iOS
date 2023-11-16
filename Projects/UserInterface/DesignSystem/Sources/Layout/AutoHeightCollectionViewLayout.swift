//
//  AutoHeightCollectionViewLayout.swift
//  DesignSystem
//
//  Created by 박의서 on 2023/10/31.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit

public class AutoHeightCollectionViewLayout: UICollectionViewLayout {
    public weak var delegate: AutoHeightLayoutDelegate?
    
    private let numberOfColumns = 2
    private let cellInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    
    private var cache: [UICollectionViewLayoutAttributes] = [] // 아이템 정보 저장할 캐시
    
    private var contentHeight: CGFloat = 0 // CollectionView에서의 ScrollView height 값과 같음
    
    private var contentWidth: CGFloat { // CollectionView에서의 ScrollView Width 값과 같음
        guard let collectionView = collectionView else {
            return 0
        }
        
        let insets = collectionView.contentInset
        return UIScreen.main.bounds.size.width - (cellInsets.left + cellInsets.right)
    }
    
    public override var collectionViewContentSize: CGSize {
        CGSize(width: contentWidth, height: contentHeight)
    }
    
    public override func prepare() {
        guard let collectionView = collectionView else {
                return
        }
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        
        for column in 0..<numberOfColumns { // xOffset은 height과 달리 사용자가 지정한 column만큼 일정
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0 // xOffset과 yOffset의 index (column이 2개이니 0,1 두 개)
        
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) { // 전체 item 개수를 돌면서, 캐시에 아이템 정보 저장
            let indexPath = IndexPath(item: item, section: 0)
            if indexPath.row == 0 {
                contentHeight = 0
            }
            
            // 동적 높이 계산
            let photoHeight = delegate?.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath) ?? 200
            let height = cellInsets.top + cellInsets.bottom + photoHeight + 40 // 50은 터치 영역을 위한 셀 공간
            
            // item의 frame
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth + cellInsets.left + cellInsets.right, height: height)
            
            let insetFrame = frame.insetBy(dx: cellInsets.left + cellInsets.right, dy: cellInsets.top + cellInsets.bottom)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    attributes.frame = insetFrame
                    cache.append(attributes)
            
            contentHeight = max(frame.maxY, contentHeight) + 2 // contentInset을 위해 6 더함 (가장 밑 간격 24)
            
            yOffset[column] += height
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    public override func layoutAttributesForElements(in rect: CGRect)
    -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in cache {
            if attributes.frame.intersects(rect) { // rect과 겹치는지 확인.
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }

    // item에 대한 layout속성을 CollectionView에게 알려줌.
    public override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
      cache[indexPath.item]
    }
    
    public override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
