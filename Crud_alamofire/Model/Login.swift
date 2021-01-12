//
//  Login.swift
//  alamofire_crud
//
//  Created by MAC on 24/12/20.
//

import Foundation
struct Errormessage: Codable {
    let status: String?
    let message: String?
   
        enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        }
}
struct Json4Swift_Base : Codable {
    let status : String?
    let data : InnerData?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent(InnerData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}

struct InnerData : Codable {
    let token, type, expiresAt: String?
    let user: Logins?
    
    enum CodingKeys: String, CodingKey {
            case token = "token"
            case type = "type"
            case expiresAt = "expires_at"
            case user = "user"
        }
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            token = try values.decodeIfPresent(String.self, forKey: .token)
            type = try values.decodeIfPresent(String.self, forKey: .type)
            expiresAt = try values.decodeIfPresent(String.self, forKey: .expiresAt)
            user = try values.decodeIfPresent(Logins.self, forKey: .user)
        }
}

//struct DataClass : Codable {
//    let token, type, expiresAt: String?
//    let user: Logins?
//
//    enum CodingKeys: String, CodingKey {
//        case token = "token"
//        case type = "type"
//        case expiresAt = "expires_at"
//        case user = "user"
//    }
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        token = try values.decodeIfPresent(String.self, forKey: .token)
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//        expiresAt = try values.decodeIfPresent(String.self, forKey: .expiresAt)
//        user = try values.decodeIfPresent(Logins.self, forKey: .user)
//    }
//}

struct Logins : Codable {
    let id : Int?
    let name : String?
    let email : String?
    let phone : String?
    let dob : String?
    let country : String?
    let city : String?
    let marital_status : String?
    let sexual_orientation : String?
    let height : String?
    let device_token : String?
    let device_id : String?
    let device_info : String?
    let reset_link : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case email = "email"
        case phone = "phone"
        case dob = "dob"
        case country = "country"
        case city = "city"
        case marital_status = "marital_status"
        case sexual_orientation = "sexual_orientation"
        case height = "height"
        case device_token = "device_token"
        case device_id = "device_id"
        case device_info = "device_info"
        case reset_link = "reset_link"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        marital_status = try values.decodeIfPresent(String.self, forKey: .marital_status)
        sexual_orientation = try values.decodeIfPresent(String.self, forKey: .sexual_orientation)
        height = try values.decodeIfPresent(String.self, forKey: .height)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
        device_id = try values.decodeIfPresent(String.self, forKey: .device_id)
        device_info = try values.decodeIfPresent(String.self, forKey: .device_info)
        reset_link = try values.decodeIfPresent(String.self, forKey: .reset_link)
    }

}
