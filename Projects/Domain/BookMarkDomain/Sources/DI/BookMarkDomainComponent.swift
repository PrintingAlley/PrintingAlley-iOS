//
//  BookMarkDomainComponent.swift
//  BookMarkDomain
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

//
import NeedleFoundation
import BookMarkDomainInterface
import JwtStoreInterface

public protocol BookMarkDomainDependency: Dependency {
    var jwtStoreFactory: any JwtStoreFactory { get }
}

public final class BookMarkDomainComponent: Component<BookMarkDomainDependency>, BookMarkDomainFactory {
    
    
    public var fetchBookMarkDetailUseCase: any FetchBookMarkDetailUseCase {
        FetchMyBookMarksDetailUseCaseImpl(bookMarkRepository: bookMarkRepository)
    }
    
    public var fetchMyBookMarksUseCase:  any FetchMyBookMarksUseCase {
        FetchMyBookMarksUseCaseImpl(bookMarkRepository: bookMarkRepository)
    }
    
    public var addBookMarkUseCase: any AddBookMarkUseCase {
        AddBookMarkUseCaseImpl(bookMarkRepository: bookMarkRepository)
    }
    
    public var removeBookMarkUseCase: any RemoveBookMarkUseCase {
        RemoveBookMarkUseCaseImpl(bookMarkRepository: bookMarkRepository)
    }
    
    public var linkBookMarkUseCase: any LinkBookMarkUseCase {
        LinkBookMarkUseCaseImpl(bookMarkRepository: bookMarkRepository)
    }
    
    public var generateBookMarkUseCase: any GenerateBookMarkUseCase {
        GenerateBookMarkUseCaseImpl(bookMarkRepository: bookMarkRepository)
    }
    
    public var removeBookMarkGroupUseCase: any RemoveBookMarkGroupUseCase {
        RemoveBookMarkGroupUseCaseImpl(bookMarkRepository: bookMarkRepository)
    }
    
    public var renameBookMarkGroupUseCase: any RenameBookMarkGroupUseCase {
        RenameBookMarkGroupUseCaseImpl(bookMarkRepository: bookMarkRepository)
    }
    
    var remoteBookMarkDataSource: any RemoteBookMarkDataSource {
        RemoteBookMarkDataSourceImpl(jwtStore: dependency.jwtStoreFactory.jwtStore)
    }
    


    
    
    public var bookMarkRepository: any BookMarkRepository {
        BookMarkRepositoryImpl(
            remoteBookMarkDataSource: remoteBookMarkDataSource
        )
    }
    
   
    
}

