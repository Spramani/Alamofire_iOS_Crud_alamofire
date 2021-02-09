//
//  ViewController.swift
//  alamofire_crud
//
//  Created by MAC on 21/12/20.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON



class ViewController: UIViewController{
    
    
    
    @IBOutlet weak var tblViews: UITableView!
    
    var valuetoken: String!
    var getmodels = [Data]()
    var storetokens:String?
    var tokens:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tblViews.rowHeight = 50
        //        print(storedatas)
        datagets()
        
    }
    
    //get data
    //    http://adsumoriginator.com/apidemo/api/list_item
    
    
    
    func datagets() {
        
        let token = UserDefaults.standard.string(forKey: "stateSelected")
        print(token)
        tokens = token
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token!)", "Content-type": "multipart/form-data"]
        
        AF.request("https://adsumoriginator.com/apidemo/api/list_item", method: .get, parameters: nil, encoding: URLEncoding.default,headers: headers, interceptor: nil, requestModifier: nil).response(completionHandler:  { [self] (responses) in
            
            
            do {
                let datas = responses.data!
                
                
                //                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                //                    print(json)
                let itemm = try! JSONDecoder().decode(itemmodel.self, from: datas)
                // let datas = itemm.data
                print(itemm)
                
                
                self.getmodels.append(contentsOf: itemm.data!)
                //                    self.getmodels.append(contentsOf: itemm.data)
                self.tblViews.reloadData()
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        })
        
    }
    
    
    
    @IBAction func addItem(_ sender: UIButton) {
        let storybrd = UIStoryboard(name: "Main", bundle: nil)
        let details:create_ItemViewController = storybrd.instantiateViewController(withIdentifier: "create_ItemViewController") as! create_ItemViewController
        self.navigationController?.pushViewController(details, animated: true)
    }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getmodels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = tblViews.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tableCell
        let getdata = getmodels[indexPath.row]
        
        cells.first.text = getdata.title
        cells.second.text = getdata.description
        cells.imgstr = getdata.image
        //                cells.imgviewss.ima
        return cells
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            let ids = getmodels[indexPath.row].id
            let token = UserDefaults.standard.string(forKey: "stateSelected")
            
            let headers: HTTPHeaders = ["Authorization": "Bearer \(token!)", "Content-type": "multipart/form-data"]
            
//            AF.request("https://adsumoriginator.com/apidemo/api/delete_item/\(indexPath.row)", method: .delete, parameters: nil,headers: headers).response(completionHandler:  {  (responses) in
//                print(responses.result)
//
//            })

            AF.request("https://adsumoriginator.com/apidemo/api/delete_item/\(ids!)", method: .delete, parameters: nil, headers: headers).validate(statusCode: 200 ..< 299).responseJSON { AFdata in
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: AFdata.data!) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            return
                        }

                        print(prettyPrintedJson)
                       
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
            }.resume()
            self.tblViews.reloadData()
            print("delete data")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
     {
         let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                 success(true)
            
            
            let storybrd = UIStoryboard(name: "Main", bundle: nil)
            let details:create_ItemViewController = storybrd.instantiateViewController(withIdentifier: "create_ItemViewController") as! create_ItemViewController
            details.indexValue = self.getmodels[indexPath.row].id
            self.navigationController?.pushViewController(details, animated: true)
            
            
             })
            editAction.backgroundColor = .blue

             return UISwipeActionsConfiguration(actions: [editAction])
     }
    
   
}



class tableCell:UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    var getdatss:ViewController?
    var imgstr:[String]?
    
    @IBOutlet weak var first:UILabel!
    
    @IBOutlet weak var second: UILabel!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgstr!.count 
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cells = collectionview.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! collectionviewsCell
        let urlimages = imgstr?[indexPath.row]
        
        
        
        AF.request(urlimages!, method: .get).responseImage { response in
            guard let images = response.value else {
                // Handle error
                
                return
            }
            cells.imgviewss.image = images
            // Do stuff with your image
        }
        return cells
    }
}


class collectionviewsCell:UICollectionViewCell{
    
    @IBOutlet weak var imgviewss: UIImageView!
    
    
}


