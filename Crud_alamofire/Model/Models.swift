//
//  Models.swift
//  alamofire_crud
//
//  Created by MAC on 21/12/20.
//

import Foundation
import Alamofire

struct getModeles : Codable {
    let id : Int?
    let title : String?
    let description : String?
    let image : [String]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case description = "description"
        case image = "image[]"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image = try values.decodeIfPresent([String].self, forKey: .image)
    }


}


class getservices {
    fileprivate var baseurl = ""
    fileprivate var token = ""
  
    typealias serviescallback = (_ getmodels: getModeles?, _ status: Bool, _ message:String) -> Void
    var service:serviescallback?
    init(baseurl:String, token:String) {
        self.baseurl = baseurl
        self.token = token

    }
    
    
    func getdata(endpoint: String ) {
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)","Content-type": "multipart/form-data"]
   
        AF.request(self.baseurl + endpoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers, interceptor: nil, requestModifier: nil ).response { (responseData) in
            guard let datas = responseData.data else {
                self.service?(nil, false, "")
                return
            }
            print(datas)
            do {
                let modelservices = try JSONDecoder().decode(getModeles.self, from: datas)
                print(modelservices)
                self.service?(modelservices, true , "")
            }catch{
                
                self.service?(nil, false , error.localizedDescription)
                
            }
          
        }
    }
    func complitionHandler(callBack: @escaping serviescallback) {
        self.service = callBack
    }
    
}
