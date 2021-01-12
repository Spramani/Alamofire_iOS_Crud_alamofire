//
//  Register.swift
//  alamofire_crud
//
//  Created by MAC on 21/12/20.
//

import Foundation
import Alamofire

struct RegisterModel : Codable {
    let name : String?
    let email : String?
    let phone : String?
    let password : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case email = "email"
        case phone = "phone"
        case password = "password"
    }
}


//
//class Registerservicess {
//
//
//     fileprivate var datas = ""
//    fileprivate var baseurl = ""
//    typealias serviescallback = (_ getmodels: [RegisterModel]?, _ status: Bool, _ message:String) -> Void
//    var service:serviescallback?
//    init(baseurl:String) {
//        self.baseurl = baseurl
//    }
//
//    func callingRegisterApi(register: RegisterModel,endpoint: String ){
//
//    let headers: HTTPHeaders = [.contentType("application/json")]
//
////    let data: [String: Any] = ["name": FirstName.text!, "lastname": LastName.text!, "mobile_no": phonenumber.text!, "email":  Emails.text!, "password": password.text!]
        
//        AF.request(self.baseurl + endpoint, method: .get, parameters: datas, encoding: URLEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).response { (responseData) in
//            guard let datas = responseData.data else {
//                self.service?(nil, false, "")
//                return
//            }
//            print(datas)
//            do {
//                let Registerservices = try JSONDecoder().decode(RegisterModel.self, from: datas)
//                print(Registerservices)
//                self.service?(Registerservices, true , "")
//            }catch{
//
//                self.service?(nil, false , error.localizedDescription)
//
//            }
//
//
//        }confirmPassword
//    }
//
//}
//
//class regservices {
//    
//    fileprivate var baseurl = ""
//    typealias serviescallbacks = (_ regmodels: RegisterModel?, _ status: Bool, _ message:String) -> Void
//    var services:serviescallbacks?
//    init(baseurl:String) {
//        self.baseurl = baseurl
//    }
//    
//  
//    func complitionHandlers(callBacks: @escaping serviescallbacks) {
//        self.services = callBacks
//    }
//    
//}
