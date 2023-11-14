
//  SVGImgProcessor.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 11/14/23.
//  Copyright © 2023 com. All rights reserved.


import Foundation
import UIKit
import Kingfisher
import SVGKit


public struct SVGImgProcessor: ImageProcessor {
    public var identifier: String = "com.PrintingAlley"
    public func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            print("already an image")
            return image
        case .data(let data):
            let imsvg = SVGKImage(data: data)
            return imsvg?.uiImage
        }
    }
    
    public init() {
     
    }
}
