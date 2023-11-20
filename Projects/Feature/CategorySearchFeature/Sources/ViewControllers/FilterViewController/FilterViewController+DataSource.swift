//
//  FilterViewController+DataSource.swift
//  CategorySearchFeature
//
//  Created by yongbeomkwak on 10/28/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit
import DesignSystem
import UtilityModule

extension FilterViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataSource.value.count
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
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
          
        
        return thirdFloor + (secondFloor != .zero ? 1 : 0) // 섹션안에 2층짜리가 있으면 무조건 하나는 있어야함
        
    }
     
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          
//        if section == .zero {
//            return nil
//        }
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FilterSectionHeaderView.identifer) as? FilterSectionHeaderView else {
             
            return UIView()
        }
        
        header.update(name: viewModel.dataSource.value[section].name)
        return header
        
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
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
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
             

            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondFilterTableViewCell.identifier, for: indexPath) as? SecondFilterTableViewCell else {
                
                return UITableViewCell()
            }
            
            DEBUG_LOG("KKKK: \(viewModel.fillterIdSet)")
            cell.update(model: viewModel.dataSource.value[section].children[row], preTags: viewModel.fillterIdSet)
            
            cell.selectionStyle = .none
            return cell
            
        
        
        
    }
    
    
}
