//
//  GSPost.swift
//  GameSource
//
//  Created by Langtian Qin on 4/23/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import Foundation
import Firebase

class GSGame{
    var gameid:String
    var developers:[String]
    var gamename:String
    var gameintro:String
    var gametext:String
    var bannerURL:URL
    var picURL:URL
    var voted=false
    var karma:Int
    var rating:Int
    var owned=false
    
    init(id:String,value:[String:Any],rating:Int) {
        self.gameid=id
        self.developers=value["developers"] as! [String]
        self.gamename=value["gamename"] as! String
        self.gameintro=value["gameintro"] as! String
        self.gametext=value["gametext"] as! String
        let bannerURLString=value["bannerURLString"] as! String
        bannerURL=URL(string: bannerURLString)!
        let picURLString=value["picURLString"] as! String
        picURL=URL(string:picURLString)!
        self.karma=value["karma"] as! Int
        self.rating=value["rating"] as! Int
    }
    
}
