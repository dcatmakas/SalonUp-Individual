//
//  User.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 4.06.2023.
//

import Foundation
import UIKit


class User {
    
    var username: String
    var firstName: String
    var lastName: String
    var email: String
    var profileImage: UIImage
    var userUUID: UUID
    
    init(username: String, firstName: String, lastName: String, email: String, profileImage: UIImage, userUUID: UUID) {
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.profileImage = profileImage
        self.userUUID = userUUID
    }
    
}
