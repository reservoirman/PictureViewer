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
 
    init(views: Int, title : String, fileName : String, lastAccessed : Date?, imageSize : Int)
    {
        self.numViews = views
        self.title = title
        self.fileName = fileName
        self.lastAccessed = lastAccessed
        self.imageSize = imageSize
    }
}
