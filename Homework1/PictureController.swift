//
//  PictureController.swift
//  Homework1
//
//  Created by Lan Kyoung Hong on 2/16/17.
//  Copyright © 2017 Ten-Seng Guh. All rights reserved.
//

import UIKit

class PictureController: UIViewController, UITextFieldDelegate {

    var index : IndexPath? = []
    
    //this will update the title of the picture in the database
    //and refresh the table view in the view controller
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        picStruct.title = textField.text!
        let vc = self.navigationController?.viewControllers[0] as! ViewController
        
        vc.thePicList.updatePicture(picStruct: picStruct)
        vc.loadList()
        
        print(textField.text!)
        textView.text = "Total views: \(picStruct.numViews)\nTitle: \(picStruct.title)\nLast Accessed: \(picStruct.lastAccessed)\nFile Size:\(picStruct.imageSize) bytes"
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var pictureTextField: UITextField!
    var picTitle : String? = ""
    
    @IBOutlet var picStruct: PictureStruct!
    
    @IBOutlet weak var textView: UITextView!
    
    
    //resize image to make it fit in the UIImage view
    func resizeImage(image: UIImage) -> UIImage {
        
        let newWidth = pictureView.bounds.size.width
        let newHeight = pictureView.bounds.size.height
        
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        let rect = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    
    override func viewDidLoad() {
        
        pictureView.image = resizeImage(image: picStruct.image!)
        textView.text = "Total views: \(picStruct.numViews)\nTitle: \(picStruct.title)\nLast Accessed: \(picStruct.lastAccessed)\nFile Size:\(picStruct.imageSize) bytes"

        pictureTextField.delegate = self
        pictureTextField.text = picStruct.title
        pictureTextField.adjustsFontSizeToFitWidth = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
