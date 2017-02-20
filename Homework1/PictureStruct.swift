//
//  PictureStruct.swift
//  Homework1
//
//  Created by Lan Kyoung Hong on 2/12/17.
//  Copyright © 2017 Ten-Seng Guh. All rights reserved.
//

import UIKit

class PictureStruct: NSObject {
    var numViews : Int = 0
    var title : String = ""
    var fileName : String = ""
    var lastAccessed : Date?
    var imageSize : Int = 0     //in kilobytes
    var image : UIImage? = nil
    
    override init()
    {
        self.image = UIImage.init(named: "sunset.jpg")
    }
    

    
    init(title : String, fileName : String)
    {
        self.numViews = 0
        self.title = title
        self.fileName = fileName
        self.lastAccessed = Date.init()
        self.image = UIImage.init(named: self.fileName)
        if self.image == nil
        {
            print("\(self.fileName) does not exist!" )
        }
        else
        {
            let jpegRep = UIImageJPEGRepresentation(self.image!, 1.0)
            self.imageSize = (jpegRep?.count)!
        }
    }
}
