// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let users = try? newJSONDecoder().decode(Users.self, from: jsonData)

import Foundation

// MARK: - User
struct User: Codable {
    let id: Int
    let name: String
    let img: String
    let username: String
}

//typealias Users = [User]
