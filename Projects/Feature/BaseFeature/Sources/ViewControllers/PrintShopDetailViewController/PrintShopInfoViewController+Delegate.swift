//
//  PrintShopInfoViewController+Delegate.swift
//  BaseFeature
//
//  Created by 박의서 on 11/19/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit

extension PrintShopInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
}

extension PrintShopInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PrintShopInfoTableViewCell.identifier, for: indexPath) as? PrintShopInfoTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.update(model: viewModel.printShop, index: indexPath.row)
        return cell
    }
}



