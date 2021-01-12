//
//  itemlist.swift
//  Crud_alamofire
//
//  Created by MAC on 28/12/20.
//

import Foundation

struct itemmodel : Codable {
    let status : String?
    let data : [Data]?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent([Data].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}

struct Data : Codable {
    let id : Int?
    let title : String?
    let description : String?
    let image : [String]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case description = "description"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image = try values.decodeIfPresent([String].self, forKey: .image)
    }

}

//
//struct itemmodel : Codable {
//    let title : String?
//    let description : String?
//    let image : [String]?
//
//    init(title: String, description: String, image: String) {
//
//        self.title = title
//        self.description = description
//        self.image = [image]
//
//    }
//
//    enum CodingKeys: String, CodingKey {
//
//
//        case title = "title"
//        case description = "description"
//        case image = "image"
//    }
//
//
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        title = try values.decodeIfPresent(String.self, forKey: .title)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        image = try values.decodeIfPresent([String].self, forKey: .image)
//    }


