//
//  User.swift
//  SalonUp! Individual
//
//  Created by Doğukan Çatmakaş on 4.06.2023.
//

import Foundation
import UIKit


struct User: Codable {
    
    var username: String
    var firstName: String
    var lastName: String
    var email: String
    var profileImageData: Data
    var userUUID: UUID
    
    init(username: String, firstName: String, lastName: String, email: String, profileImageData: Data, userUUID: UUID) {
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.profileImageData = profileImageData
        self.userUUID = userUUID
    }
    
}


class UserManager {
    static let shared = UserManager()
    private let userDefaults = UserDefaults.standard
    private let userKey = "currentUser"
    
    func saveUser(_ user: User) {
        do {
            let encoder = JSONEncoder()
            let userData = try encoder.encode(user)
            userDefaults.set(userData, forKey: userKey)
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
    
    func getUser() -> User? {
        guard let userData = userDefaults.data(forKey: userKey) else { return nil }
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: userData)
            return user
        } catch {
            print("Failed to get user: \(error.localizedDescription)")
            return nil
        }
    }
    
    func deleteUser() {
        userDefaults.removeObject(forKey: userKey)
    }
}
