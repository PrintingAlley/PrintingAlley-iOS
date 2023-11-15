//
//  PrintShopDetailFactory.swift
//  BaseFeatureInterface
//
//  Created by 박의서 on 2023/11/13.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit

public protocol PrintShopDetailFactory {
    func makeView(id: Int) -> UIViewController
}

