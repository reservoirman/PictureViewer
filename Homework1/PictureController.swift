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
    

    
    override func viewDidLoad() {
        //super.viewDidLoad()
        
        /*
        let appDelegate = UIApplication.shared.delegate as! ViewController
        picStruct = appDelegate.thePicList.pictureList[(index?.row)!]
        
        
        if let name = picStruct.title as String? {
            picTitle = name
        }*/
        
        textView.text = "Welcome to the next level"//"Title: \(picStruct.title)\nFile Size:\(picStruct.imageSize)"
        

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
