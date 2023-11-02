//
//  ProductDetailViewController+Delegate.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 11/1/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit
import UtilityModule

extension ProductDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 492
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProductDetailTableHeaderView.identifer) as? ProductDetailTableHeaderView  else {
            return nil
        }
        
        headerview.update()
        headerview.delegate = self 
        
        return headerview
    }
}

extension ProductDetailViewController: ProductDetailTableHeaderViewDelegate {
    func save(id: Int, isBookmarked: Bool) {
        DEBUG_LOG("SAVE")
    }
}
