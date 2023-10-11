//
//  NearByMeViewController.swift
//  NearByMeFeature
//
//  Created by yongbeomkwak on 10/11/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import NMapsMap

class NearByMeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
        // Do any additional setup after loading the view.
    }
    



}
