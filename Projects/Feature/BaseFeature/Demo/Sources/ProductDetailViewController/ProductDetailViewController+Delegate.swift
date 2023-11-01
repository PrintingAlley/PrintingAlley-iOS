//
//  ProductDetailViewController+Delegate.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 11/1/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit

extension ProductDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 542
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProductDetailTableHeaderView.identifer) as? ProductDetailTableHeaderView  else {
            return nil
        }
        
        headerview.update()
        
        return headerview
    }
}
