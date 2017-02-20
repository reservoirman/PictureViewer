//
//  PictureList.swift
//  Homework1
//
//  Created by Lan Kyoung Hong on 2/13/17.
//  Copyright © 2017 Ten-Seng Guh. All rights reserved.
//

import UIKit

class PictureList: NSObject {

    var filePath : String = ""
    // open database
    var db: OpaquePointer? = nil
    var pictureList = [PictureStruct]()
    
    func count() -> Int {
        return pictureList.count
    }
    
    override init() {
        //open textfile
        //populate pictureList using that
        //pictureList.append(PictureStruct(title: "The happy giraffe", fileName: "giraffe.jpg"))
        
        //pictureList.append(PictureStruct(title: "The majestic sunset", fileName: "sunset.jpg"))
        
        //pictureList.append(PictureStruct(title: "The scrumptious ice cream", fileName: "ice cream.jpg"))
    }
    
    func copyToDocuments()
    {
        let fileManager = FileManager.default
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("pictures.sqlite")
        
        
        
        // open database
        filePath = fileURL.path
        if fileManager.fileExists(atPath: filePath) == false
        {
            let bundlePath = Bundle.main.bundlePath + "/pictures.sqlite"
            print(bundlePath)
            
            do
            {
                
                try fileManager.copyItem(atPath: bundlePath, toPath: filePath)
            }
            catch
            {
                
            }
        }
        let attr = fileManager.contents(atPath: filePath)
        print("Count: \(attr!.count)")
    
    }
    
    func addPicture(picStruct : PictureStruct)
    {
        
    }
    
    func updatePicture(picStruct : PictureStruct)
    {
        
    }
    
    func deletePicture(picStruct : PictureStruct)
    {
        
    }
    
    func populatePictureList()
    {
        
        if sqlite3_open(filePath, &db) == SQLITE_OK
        {
            print("SUCCESS!")
            let getAll = "select * from pictures"
            var statement: OpaquePointer? = nil
            let result = sqlite3_prepare_v2(db, getAll, -1, &statement, nil)
            if result == SQLITE_OK
            {
                while sqlite3_step(statement) == SQLITE_ROW
                {
                    let queryResultCol0 = sqlite3_column_int(statement, 0)
                    let id = queryResultCol0
                    print("id = \(id)")
                    
                    let queryResultCol1 = sqlite3_column_text(statement, 1)
                    let title = String(cString: queryResultCol1!)
                    print("title = \(title)")
                    
                    let queryResultCol2 = sqlite3_column_text(statement, 2)
                    let lastAccessed = String(cString: queryResultCol2!)
                    print("lastAccessed = \(lastAccessed)")
                    
                    let queryResultCol3 = sqlite3_column_int(statement, 3)
                    let views = queryResultCol3
                    print("Views = \(views)")
                    
                    let data = sqlite3_column_blob(statement, 4)
                    let len = sqlite3_column_bytes(statement, 4)
                    
                    let imageData = NSData(bytes: data, length: Int(len))
                    
                    let image = UIImage(data: imageData as Data)
                    
                    let newPic = PictureStruct()
                    newPic.id = Int(id)
                    newPic.title = title
                    newPic.numViews = Int(views)
                    newPic.image = image
                    if (lastAccessed == "first")
                    {
                        newPic.lastAccessed = Date.init().description
                    }
                    else
                    {
                        newPic.lastAccessed = lastAccessed
                    }
                    newPic.setSize()
                    pictureList.append(newPic)
                    
                    
                }
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close_v2(db)
    }

    
}
