//
//  EditModalComponent.swift
//  BaseFeature
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseFeatureInterface
import NeedleFoundation
import UIKit
import BookMarkDomainInterface
import UserDomainInterface

public protocol EditModalDependency: Dependency {
    
    var bookMarkDomainFactory: any BookMarkDomainFactory { get }
    var userDomainFactory: any UserDomainFactory { get }
}

public final class EditModalComponent: Component<EditModalDependency>, EditModalFactory {
    public func makeView(id: Int, title: String, type: EditType) -> UIViewController {
        EditModalViewController(title: title, viewModel: EditModalViewModel(id: id, type: type, generateBookMarkUseCase: dependency.bookMarkDomainFactory.generateBookMarkUseCase, renameBookMarkGroupUseCase: dependency.bookMarkDomainFactory.renameBookMarkGroupUseCase, renameUserUseCase: dependency.userDomainFactory.renameUserUseCase))
    }
    
}
