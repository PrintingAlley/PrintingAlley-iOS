

import Foundation


public struct UserInfoEntity {
    public let id: Int
    public let provider: String
    public let name: String
    public let profileImage: String
    public let email: String
    let statusCode: Int
    let message: String
    
    public init(id: Int, provider: String, name: String, profileImage: String, email: String, statusCode: Int, message: String) {
        self.id = id
        self.provider = provider
        self.name = name
        self.profileImage = profileImage.encodeUrl()!
        self.email = email
        self.statusCode = statusCode
        self.message = message
    }
}
