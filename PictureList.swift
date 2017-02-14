//
//  PictureList.swift
//  Homework1
//
//  Created by Lan Kyoung Hong on 2/13/17.
//  Copyright © 2017 Ten-Seng Guh. All rights reserved.
//

import UIKit

class PictureList: NSObject {

    var pictureList = [PictureStruct]()
    
    func count() -> Int {
        return pictureList.count
    }
    
    override init() {
        //open textfile
        //populate pictureList using that
        do {
            // get the documents folder url
            let documentDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            // create the destination url for the text file to be saved
            let fileDestinationUrl = documentDirectoryURL.appendingPathComponent("file.txt")
            
            let t1 = "i need you right now"
            let text = "some text don't let me down"
            let t3 = "think i'm losing my mind now"
            do {
                // writing to disk
                try t1.write(to: fileDestinationUrl, atomically: false, encoding: .utf8)
                try text.write(to: fileDestinationUrl, atomically: false, encoding: .utf8)
                try t3.write(to: fileDestinationUrl, atomically: false, encoding: .utf8)
                
                
                // saving was successful. any code posterior code goes here
                // reading from disk
                do {
                    
                    let mytext = try String(contentsOf: fileDestinationUrl)
                    print(mytext)   // "some text\n"
                    let mytext2 = try String(contentsOf: fileDestinationUrl)
                    print(mytext2)   // "some text\n"
                    
                } catch let error as NSError {
                    print("error loading contentsOf url \(fileDestinationUrl)")
                    print(error.localizedDescription)
                }
            } catch let error as NSError {
                print("error writing to url \(fileDestinationUrl)")
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print("error getting documentDirectoryURL")
            print(error.localizedDescription)
        }
        
        
        pictureList.append(PictureStruct(views: 0, title: "giraffe", fileName: "giraffe.jpg", lastAccessed: Date.init(), imageSize: 144))
        
        pictureList.append(PictureStruct(views: 0, title: "sunset", fileName: "sunset.jpg", lastAccessed: Date.init(), imageSize: 178))
        
    }
}
