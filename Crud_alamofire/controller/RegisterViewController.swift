//
//  RegisterViewController.swift
//  alamofire_crud
//
//  Created by MAC on 21/12/20.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var conpassword: UITextField!
    var register = [RegisterModel]()
    
    
    
   
    
        @IBAction func submit(_ sender: UIButton) {
            datagets()

    }
  
    
    
    func datagets() {
        let headers: HTTPHeaders = [.contentType("application/json")]
        
        let data: [String: Any] = ["name": name.text!, "email": email.text!, "phone": phone.text!, "password": password.text!, "confirmPassword": conpassword.text!]
      
        AF.request("https://adsumoriginator.com/apidemo/api/register", method: .post, parameters: data, encoding: JSONEncoding.default,headers: headers).responseJSON { (response) in
            debugPrint(response)
            
            switch response.result {
                    case .success:
//                        lbl.text = response.
                        print("Success:==\(response.result)")
                        self.name.text = ""
                        self.email.text = ""
                        self.phone.text = ""
                        self.password.text = ""
                        self.conpassword.text = ""
                        
                        self.performSegue(withIdentifier: "datashow", sender: nil)
                        
                    case .failure(let err):
                        print(err.localizedDescription)
            
            }

        }
           
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
