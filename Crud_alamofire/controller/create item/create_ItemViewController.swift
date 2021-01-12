//
//  create_ItemViewController.swift
//  Crud_alamofire
//
//  Created by MAC on 28/12/20.
//


import UIKit
import Alamofire
import BSImagePicker
import Photos

class create_ItemViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCells", for: indexPath) as! CollectionViewCells
        let data: UIImage = selectedImages[indexPath.item]
        cells.images.image = data
        return cells
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
  
   
    private var selectedImages: [UIImage] = []

    var storedata:String?
    var tokenstore : String = ""
    var dats = [itemmodel]()
    var imagess:UIImage?
    
   
    @IBOutlet weak var descriptions: UITextField!
    @IBOutlet weak var titles: UITextField!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titles.delegate = self
        descriptions.delegate = self
  
    }
    
    @IBAction func button(_ sender: UIButton) {
        
       selectImages()
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.delegate = self
//
//        let actionsheet = UIAlertController(title: "Photo Source", message: "Choose a Source", preferredStyle: .actionSheet)
//        actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
//            imagePickerController.sourceType = .camera
//            self.present(imagePickerController, animated: true, completion: nil)
//        }))
//        actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (UIAlertAction) in
//            imagePickerController.sourceType = .photoLibrary
//            self.present(imagePickerController, animated: true, completion: nil)
//        }))
//
//        actionsheet.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
//
//        self.present(actionsheet, animated: true, completion: nil)
        
    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let imaged = info[UIImagePickerController.InfoKey.originalImage]  as! UIImage
//        imageviw.image = imaged
//        imagess = imaged
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    @IBAction func add(_ sender: UIButton) {

        let dataimage = selectedImages
        send_img(data_img: dataimage)
    }
    
   
    
    func send_img(data_img : [UIImage]?){
  
        let headers: HTTPHeaders = ["Authorization": "Bearer \(storedata ?? "hello")","Content-type": "multipart/form-data"]
      
        let parameter:Parameters = ["title": titles.text!, "description": descriptions.text!]
       
        AF.upload(multipartFormData: { (multipartFormData) in
            print(multipartFormData)
            
            for data in data_img! {
//            if let  data = data_img {
                guard let imgData = data.jpegData(compressionQuality: 1) else { return }
                       
                multipartFormData.append(imgData, withName: "image[]", fileName: "image.jpeg", mimeType: "image/jpeg")
            }
            for (key, value) in parameter
            {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to:"https://adsumoriginator.com/apidemo/api/create_item", usingThreshold: UInt64.init(),method: .post, headers: headers).responseJSON
        { [self] (response) in
          
            switch response.result {
            case .success(let value) :
                //
                print("data sent success\(value)")
                self.titles.text = ""
                self.descriptions.text = ""

                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    
    
    @objc private func selectImages() {
        let imagePicker = ImagePickerController()
        presentImagePicker(imagePicker, select: { (asset) in
        }, deselect: { (asset) in
             
        }, cancel: { (assets) in
             
        }, finish: { (assets) in
             
            self.selectedImages = []
            let options: PHImageRequestOptions = PHImageRequestOptions()
            options.deliveryMode = .highQualityFormat
 
            for asset in assets {
                PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options) { (image, info) in
                    
                    self.selectedImages.append(image!)
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
    
    
    
    
}



