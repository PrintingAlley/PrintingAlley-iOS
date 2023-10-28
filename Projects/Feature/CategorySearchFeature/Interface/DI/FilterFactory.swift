//
//  FilterFactory.swift
//  CategorySearchFeatureInterface
//
//  Created by yongbeomkwak on 10/27/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit

public protocol FilterFactory {
    func makeView(id: Int) -> UIViewController
}
