//
//  HomeViewController.swift
//  HomeFeatureInterface
//
//  Created by 박의서 on 2023/10/11.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import UtilityModule

final class HomeViewController: UIViewController {

    var viewModel: HomeViewModel!

    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
