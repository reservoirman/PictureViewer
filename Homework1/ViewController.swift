//
//  ViewController.swift
//  Homework1
//
//  Created by Lan Kyoung Hong on 2/3/17.
//  Copyright © 2017 Ten-Seng Guh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var picTitle: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet var thePicList: PictureList!
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if (cell == nil)
        {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        let thisPicture : PictureStruct = thePicList.pictureList[indexPath.row]
        cell!.textLabel?.text = thisPicture.title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thePicList.count()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thisPicture : PictureStruct = thePicList.pictureList[indexPath.row]
        let alert : UIAlertController = UIAlertController.init(title: thisPicture.fileName, message: thisPicture.title, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.show(self, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return thePicList.pictureList.count
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return thePicList.pictureList[row].title
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        picTitle.text = thePicList.pictureList[row].title
    }
    
    
    //@IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

