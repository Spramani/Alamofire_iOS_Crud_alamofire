//
//  getdata.swift
//  Crud_alamofire
//
//  Created by MAC on 25/12/20.
//

import Foundation


// MARK: - Welcome
struct getdatamodel: Codable {
    let status: String
    let data: DataClass
    let message: String
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseDataClass { response in
//     if let dataClass = response.result.value {
//       ...
//     }
//   }

// MARK: - DataClass
struct DataClass: Codable {
    let token, type, expiresAt: String?
    let user: [User]

    enum CodingKeys: String, CodingKey {
        case token, type
        case expiresAt = "expires_at"
        case user
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseUser { response in
//     if let user = response.result.value {
//       ...
//     }
//   }

// MARK: - User
struct User: Codable {
    let id: Int?
    let name, email, phone: String?
    let dob, country, city, maritalStatus: String?
    let sexualOrientation, height, deviceToken, deviceID: String?
    let deviceInfo, resetLink: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, dob, country, city
        case maritalStatus = "marital_status"
        case sexualOrientation = "sexual_orientation"
        case height
        case deviceToken = "device_token"
        case deviceID = "device_id"
        case deviceInfo = "device_info"
        case resetLink = "reset_link"
    }
}
