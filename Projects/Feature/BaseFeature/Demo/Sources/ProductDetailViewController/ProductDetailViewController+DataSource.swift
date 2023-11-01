//
//  ProductDetailViewController+DataSource.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 11/1/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit

extension ProductDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifer, for: indexPath) as? ProductDetailTableViewCell else {
            return UITableViewCell()
        }
        
        
        cell.update(model: "1241414141241241241241241412412412412", index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    

    
}
