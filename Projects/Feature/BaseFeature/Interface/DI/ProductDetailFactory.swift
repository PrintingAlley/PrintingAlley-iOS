//
//  ProductDetailFactory.swift
//  BaseFeatureInterface
//
//  Created by yongbeomkwak on 11/1/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit

public protocol ProductDetailFactory {
    func makeView(id: Int) -> UIViewController
}
