//
//  AddPictureController.swift
//  Homework1
//
//  Created by Lan Kyoung Hong on 2/19/17.
//  Copyright © 2017 Ten-Seng Guh. All rights reserved.
//

import UIKit

class AddPictureController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    let picturePicker = UIImagePickerController()
    
    @IBAction func addButtonAction(_ sender: UIButton) {
            self.present(picturePicker, animated: true, completion: nil)
    }
    @IBOutlet weak var addButtonAction: UIImageView!
    var addedImage : UIImage? = nil
    
    @IBOutlet weak var addButton: UIButton!

    @IBOutlet var thePicList: PictureList!

    
    @IBOutlet weak var textView: UITextView!
    
    func savePicture()
    {

        if CFStringGetLength(self.textView!.text as CFString!) > 0
        {
            let newPic = PictureStruct()
            newPic.title = self.textView!.text
            newPic.image = addedImage
            newPic.lastAccessed = Date.init()
            thePicList.pictureList.append(newPic)
    
            //exit the Add Picture Screen and return to the list of pictures:
            self.navigationController?.popViewController(animated: true)
        
            //reload the table list view
            let viewController = self.navigationController?.topViewController as! ViewController
            viewController.tableView.reloadData()
            //set editing to false
            viewController.isEditing = false
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        //dismiss the Add Picture View
        self.dismiss(animated: true, completion: nil)
        addedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = addedImage
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = ""
        let save_button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(AddPictureController.savePicture))
        self.navigationItem.rightBarButtonItem = save_button
        textView.becomeFirstResponder()
        picturePicker.delegate = self
        picturePicker.sourceType = .photoLibrary
        picturePicker.allowsEditing = false
        
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
