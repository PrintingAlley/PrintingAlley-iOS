//
//  PrintShopProudctsViewController.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/11/14.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit

public class PrintShopProudctsViewController: UIViewController {

    let viewModel: PrintShopProudctsViewModel!
    
    init(viewModel: PrintShopProudctsViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
