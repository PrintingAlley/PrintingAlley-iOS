//
//  RootViewController.swift
//  RooFuture
//
//  Created by yongbeomkwak on 2023/09/24.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit



public class RootViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .roundedRect)
              button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
              button.setTitle("Test Crash", for: [])
              button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
              view.addSubview(button)

        // Do any additional setup after loading the view.
    }
    @IBAction func crashButtonTapped(_ sender: AnyObject) {
        let numbers = [0]
        let _ = numbers[1]
    }
    
}
