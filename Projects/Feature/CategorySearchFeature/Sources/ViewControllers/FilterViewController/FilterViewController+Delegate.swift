//
//  FilterViewController+Delegate,DataSource.swift
//  CategorySearchFeature
//
//  Created by yongbeomkwak on 10/28/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit
import DesignSystem

extension FilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let section = indexPath.section
        let row = indexPath.row
        
        let numberOfItem = viewModel.dataSource.value[section].children[row].children.isEmpty ? viewModel.dataSource.value[section].children.count : viewModel.dataSource.value[section].children[row].children.count
         
        let tempLabel = AlleyLabel("않입값히ㅁㄴㅇ", font: .body1).then {
            $0.sizeToFit()
        }
        
        let subtitleLabel = AlleyLabel("소제목 소제목",font: .subtitle3).then {
            $0.sizeToFit()
        }
        
        let h1: CGFloat = tempLabel.frame.height + 8
        
        let h2: CGFloat = subtitleLabel.frame.height
        
        let numberOfrow = numberOfItem % 4 == .zero ?  numberOfItem / 4 : (numberOfItem / 4 + 1) // 필터 줄
        
        let offset1: CGFloat = 16.0
        let offset2: CGFloat = 6.0

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
        
            UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        section != .zero ? 16 : UITableView.automaticDimension
    }
    

}
