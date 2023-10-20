//
//  BookMarkDetailFactory.swift
//  BookMarkFeatureInterface
//
//  Created by yongbeomkwak on 10/20/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit

public protocol BookMarkDetailFactory {
    func makeView(id: Int,name : String) -> UIViewController
}


