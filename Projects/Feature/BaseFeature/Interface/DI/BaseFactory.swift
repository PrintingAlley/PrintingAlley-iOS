//
//  BookMarkBottomSheetFactory.swift
//  BaseFeatureInterface
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit

public protocol BaseFactory {
    func makeBookMarkBottomSheet() -> UIViewController
    func makeEditMoal() -> UIViewController
}
