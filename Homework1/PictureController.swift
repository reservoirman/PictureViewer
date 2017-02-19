//
//  PictureController.swift
//  Homework1
//
//  Created by Lan Kyoung Hong on 2/16/17.
//  Copyright © 2017 Ten-Seng Guh. All rights reserved.
//

import UIKit

class PictureController: UIViewController {

    var index : IndexPath? = []
    
    @IBOutlet weak var pictureView: UIImageView!
    
    var picTitle : String? = ""
    
    @IBOutlet var picStruct: PictureStruct!
    
    @IBOutlet weak var textView: UITextView!
    
    func initWithIndexPath(index : IndexPath) -> PictureController
    {
        self.index? = index
        return self
    }
    
    func resizeImage(image: UIImage) -> UIImage {
        
        let newWidth = pictureView.bounds.size.width
        let newHeight = pictureView.bounds.size.height
        
        let widthRatio  = newWidth  / image.size.width
        let heightRatio = newHeight / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: image.size.width * heightRatio, height: image.size.height * heightRatio)
        } else {
            newSize = CGSize(width: image.size.width * widthRatio,  height: image.size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    override func viewDidLoad() {
        
        //pictureView.contentMode = UIViewContentMode.scaleAspectFit
        
        pictureView.image = resizeImage(image: picStruct.image!)
        textView.text = "Title: \(picStruct.title)\nFile Size:\(picStruct.imageSize)"
        

        // Do any additional setup after loading the view.
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
