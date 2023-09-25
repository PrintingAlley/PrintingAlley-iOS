//
//  RootViewController.swift
//  RooFuture
//
//  Created by yongbeomkwak on 2023/09/24.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import GoogleSignIn


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
//    @IBAction func crashButtonTapped(_ sender: AnyObject) {
//        let id =  // 여기서는 반전시키지 말고 ID값 그대로 적용한다.
//        let signInConfig = GIDConfiguration(clientID: id)
//        
//        GIDSignIn.sharedInstance.configuration = signInConfig
//        
//        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
//            guard error == nil else { return }
//            guard let signInResult = signInResult else { return }
//
//            let user = signInResult.user
//
//            let emailAddress = user.profile?.email
//
//            let fullName = user.profile?.name
//            let givenName = user.profile?.givenName
//            let familyName = user.profile?.familyName
//
//           // let profilePicUrl = user.profile?.imageURL(withDimension: 320)
//            
//            print(user)
//        }
//    }
    
}
