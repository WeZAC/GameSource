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
    var picURL:[URL]
    var voted=false
    var rating=0
    var owned=false
    
    init(id:String,value:[String:Any]) {
        self.gameid=id
        self.developers=value["developers"]
        self.gamename=value["gamename"]
        self.gameintro=value["gameintro"]
        self.gametext=value["gametext"]
        let bannerURLString=value["bannerURLString"]
        bannerURL=URL(string: bannerURLString)
        let picURLString=value["picURLString"]
        picURL=URL(string:picURL)
    }
    
}
