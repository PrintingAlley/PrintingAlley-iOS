//
//  AlleyPageFactory.swift
//  BaseFeatureInterface
//
//  Created by yongbeomkwak on 11/11/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit

public protocol AlleyPageFactory {
    func makeView(titles: [String]) -> UIViewController
}
