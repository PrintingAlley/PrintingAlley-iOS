//
//  ProdcutEntity.swift
//  BaseDomainInterface
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct ProductEntity {
    
    public let id: Int
    public let name, size, paper,printType,afterProcess,designer ,introduction, description: String
    public let mainImage: String
    public let images: [String]
    public let category: CategoryEntity
    public let printShop: PrintShopEntity
    public let tags: [ChildrenTagEntity]
    public let reviews: [ReviewEntity]
    public let isBookmarked: Bool
    public var width: Int {
        return findIntFromString(string: mainImage, pattern: "width=(\\d+)")
    }
    public var height: Int {
        return findIntFromString(string: mainImage, pattern: "&height=(\\d+)")
    }
    public let statusCode: Int
    public let message: String

    public init(id: Int, name: String, size: String, paper: String, printType: String, afterProcess: String, designer: String, introduction: String, description: String, mainImage: String, images: [String], category: CategoryEntity, printShop: PrintShopEntity, tags: [ChildrenTagEntity], reviews: [ReviewEntity], isBookmarked: Bool, statusCode: Int, message: String) {
        self.id = id
        self.name = name
        self.size = size
        self.paper = paper
        self.printType = printType
        self.afterProcess = afterProcess
        self.designer = designer
        self.introduction = introduction
        self.description = description
        self.mainImage = mainImage
        self.images = images
        self.category = category
        self.printShop = printShop
        self.tags = tags
        self.reviews = reviews
        self.isBookmarked = isBookmarked
        self.statusCode = statusCode
        self.message = message
    }
    
    public static func makeErrorEntity(message: String) -> Self {
        ProductEntity(id: 0, name: "", size: "" ,  paper: "",printType: "",afterProcess: "", designer: "" , introduction: "", description: "", mainImage: "", images: [], category: .makeErrorEntity(), printShop: .makeErrorEntity(), tags: [ChildrenTagEntity.makeErrorEntity()], reviews: [ReviewEntity.makeErrorEnitity(message: "")], isBookmarked:  false  , statusCode: 400, message: message)
    }
    
    public func findIntFromString(string: String, pattern: String) -> Int {
        var result = 0
        do {
        let regex = try NSRegularExpression(pattern: pattern)
            
            if let match = regex.firstMatch(in: string, range: NSRange(string.startIndex..., in: string)) {
                let range = Range(match.range(at: 1), in: string)
                
                if let resultStr = range.flatMap({ String(string[$0]) }), let resultInt = Int(resultStr) {
                    result = resultInt
                }
            }
        } catch {
            print("정규표현식 에러")
        }
        return result
    }
}
