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
    private var pictureList = [PictureStruct]()
    
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
    
    func getPicStruct(index : Int) -> PictureStruct
    {
        return pictureList[index]
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
    
    //adds picture to both the database (via INSERT call)
    //and the array (via append)
    func addPicture(picStruct : PictureStruct)
    {
        if sqlite3_open(filePath, &db) == SQLITE_OK
        {
            var insertStatement: OpaquePointer? = nil
            let insertString = "INSERT INTO pictures(id, title, lastAccessed, views, image) VALUES (NULL, ?, ?, 1, ?)"
            
            let result = sqlite3_prepare_v2(db, insertString, -1, &insertStatement, nil)
            if result == SQLITE_OK
            {
                //title
                sqlite3_bind_text(insertStatement, 1, (picStruct.title as NSString).utf8String, -1, nil)
                
                //lastAccessed
                sqlite3_bind_text(insertStatement, 2, (picStruct.lastAccessed as NSString).utf8String, -1, nil)
                
                //image
                let pictureData = UIImageJPEGRepresentation(picStruct.image!, 1.0)
                let data = NSData(data: pictureData!)
                let length = Int32(data.length)
                
                let returnValue = sqlite3_bind_blob(insertStatement, 3, data.bytes, length, nil)
                
                print ("Return value = \(returnValue)")
                if sqlite3_step(insertStatement) == SQLITE_DONE
                {
                    sqlite3_finalize(insertStatement)
                    pictureList.append(picStruct)
                }
            }
        }
        sqlite3_close_v2(db)
    }
    
    //updates picture in the database (via UPDATE call)
    func updatePicture(picStruct : PictureStruct)
    {
        if sqlite3_open(filePath, &db) == SQLITE_OK
        {
            var updateStatement: OpaquePointer? = nil
            let updateString = "UPDATE pictures SET title = ?, lastAccessed = ?, views =  ? WHERE id = ?;"
            let result = sqlite3_prepare_v2(db, updateString, -1, &updateStatement, nil)
            if result == SQLITE_OK
            {
                //title
                sqlite3_bind_text(updateStatement, 1, (picStruct.title as NSString).utf8String, -1, nil)
                
                //lastAccessed
                sqlite3_bind_text(updateStatement, 2, (picStruct.lastAccessed as NSString).utf8String, -1, nil)
                
                //viewcount
                sqlite3_bind_int(updateStatement, 3, Int32(picStruct.numViews))
                
                
                //primary key lookup
                sqlite3_bind_int(updateStatement, 4, Int32(picStruct.id))
                

                if sqlite3_step(updateStatement) == SQLITE_DONE
                {
                    sqlite3_finalize(updateStatement)
                }
            }
        }
        sqlite3_close_v2(db)
    }
    
    //deletes picture from database (via DELETE call)
    //and the array (via remove)
    func deletePicture(index : Int)
    {
        let picStruct = pictureList[index]
        if sqlite3_open(filePath, &db) == SQLITE_OK
        {
            var deleteStatement: OpaquePointer? = nil
            let deleteString = "DELETE FROM pictures WHERE id = ?;"
            let result = sqlite3_prepare_v2(db, deleteString, -1, &deleteStatement, nil)
            if result == SQLITE_OK
            {
                //primary key lookup
                sqlite3_bind_int(deleteStatement, 1, Int32(picStruct.id))
                
                
                if sqlite3_step(deleteStatement) == SQLITE_DONE
                {
                    sqlite3_finalize(deleteStatement)
                    pictureList.remove(at: index)
                }
            }
        }
        sqlite3_close_v2(db)
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
                    print("Size = \(newPic.imageSize)")
                    pictureList.append(newPic)
                    
                    
                }
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close_v2(db)
    }

    
}
