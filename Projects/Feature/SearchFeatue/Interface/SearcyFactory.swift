//
//  SearcyFactory.swift
//  SearchFeatueInterface
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit

public protocol SearchFactory {
    func makeView() -> UIViewController
}
