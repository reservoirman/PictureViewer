//
//  ViewController.swift
//  Homework1
//
//  Created by Lan Kyoung Hong on 2/3/17.
//  Copyright © 2017 Ten-Seng Guh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
        if (indexPath.row == thePicList.count())
        {
            cell!.textLabel?.text = "Add new Picture..."
            cell!.textLabel?.textColor = UIColor.blue
            cell!.editingAccessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        else
        {
            let thisPicture : PictureStruct = thePicList.pictureList[indexPath.row]
            cell!.textLabel?.text = thisPicture.title
            cell!.textLabel?.textColor = UIColor.black
            
        }
        return cell!
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(editing, animated: true)
        tableView.reloadData()
    }
    
    //need to overload this to change the icon for the row to add new pictures...
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if (indexPath.row == thePicList.count())
        {
            return UITableViewCellEditingStyle.insert
        }
        else
        {
            return UITableViewCellEditingStyle.delete
        }
    }
    
    //for deleting a row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
                thePicList.pictureList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.right)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isEditing
        {
            return thePicList.count() + 1
        }
        else
        {
            return thePicList.count()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PictureController"
        {
            let indexPath = tableView.indexPathForSelectedRow?.row
            print("So don't let me down \(indexPath)")

            if let picStruct = thePicList.pictureList[indexPath!] as PictureStruct?
            {
                let correspondingPicController : PictureController = segue.destination as! PictureController
                picStruct.lastAccessed = Date.init().description
                picStruct.numViews = picStruct.numViews + 1
                correspondingPicController.picStruct = picStruct
            }
        }
        else if segue.identifier == "AddPictureController"
        {
            let correspondingAddPicController : AddPictureController = segue.destination as! AddPictureController
            correspondingAddPicController.thePicList = self.thePicList
        }
    }
    
    // action to take when selecting a row.  Either you will jump to the next page to display 
    // the selected picture or you will add a new picture
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if (indexPath.row != thePicList.count() && !self.isEditing)
        {
            performSegue(withIdentifier: "PictureController", sender: self)
        }
        else if (indexPath.row == thePicList.count() && self.isEditing)
        {
            performSegue(withIdentifier: "AddPictureController", sender: self)
        } 
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //@IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Picture Viewer!"
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        print(SQLITE_VERSION)
        thePicList.copyToDocuments()
        thePicList.populatePictureList()
    }
        
    func loadList(){
        //load data here
        self.tableView.reloadData()
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

