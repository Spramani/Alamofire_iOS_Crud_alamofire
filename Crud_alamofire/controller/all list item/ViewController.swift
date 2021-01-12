//
//  ViewController.swift
//  alamofire_crud
//
//  Created by MAC on 21/12/20.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController{
    var storedatas:String?
    //    var tokenstore// : String = ""
    
    
    @IBOutlet weak var collecitonviews: UICollectionView!
    var valuetoken: String!
    var getmodels = [Data]()
    
    @IBOutlet weak var tblViews: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tblViews.rowHeight = 50
        print(storedatas)
        datagets()
        
        
        
    }
    //get data
    //    http://adsumoriginator.com/apidemo/api/list_item
    
    
    
    func datagets() {
        let headers: HTTPHeaders = ["Authorization": "Bearer \(storedatas!)", "Content-type": "multipart/form-data"]
        
        AF.request("https://adsumoriginator.com/apidemo/api/list_item", method: .get, parameters: nil, encoding: URLEncoding.default,headers: headers, interceptor: nil, requestModifier: nil).response(completionHandler:  { (responses) in
            
            
            do {
                let data = responses.data!
                // make sure this JSON is in the format we expect
       

                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print(json)
                    let itemm = try! JSONDecoder().decode(itemmodel.self, from: data)

                    print(itemm.data)
                    self.getmodels.append(contentsOf: itemm.data!)
//                    self.getmodels.append(contentsOf: itemm.data)
                    self.tblViews.reloadData()
                    
//                    let jsonData = json.data(using: .utf8)!
//                    // Convert from JSON to nsdata
//                    func jsonToNSData(json: AnyObject) -> NSData?{
//                        do {
//                            let valuews = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
//                            print(valuews)
//                        } catch let myJSONError {
//                            print(myJSONError)
//                        }
//                        return nil;
//                    }
                }
                
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        
        //            var dataas = responses.data
        //            print(responses.result)
        //
        //
        ////            let stringFromByteArray = String(decoding: responses.data!, as: UTF8.self) // "Caf�"
        //           // let stringFromByteArray = String(data: Data(bytes: responses.data!), encoding: .utf8)
        //
        //            print(stringFromByteArray)
        //
    })
    
}
//
//func dataget() {
//
//    let dataes = getservices(baseurl: "https://adsumoriginator.com/apidemo/api/",token: "\(storedatas)")
//    dataes.getdata(endpoint: "list_item")
//    dataes.complitionHandler {[weak self] (getmodels, status, message) in
//        if status {
//            guard let self = self  else {
//                return
//            }
//            guard let getmodeldats = getmodels else {
//                return
//            }
//            self.getmodels = [getmodeldats]
//            self.tblViews.reloadData()
//        }
//    }
//    print(dataes)
//}
//}
//
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
        return cells
    }
}


class tableCell:UITableViewCell{
    
    //@IBOutlet weak var collectionviews: UICollectionView!
    
    //    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //        return 10
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //        let cells = collectionviews.dequeueReusableCell(withReuseIdentifier: "images", for: indexPath)
    //        return cells
    //    }
    ////
    @IBOutlet weak var first:UILabel!
    
    @IBOutlet weak var second: UILabel!
}


