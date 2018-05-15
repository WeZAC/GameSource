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
    var gameid:DatabaseReference?
    var developers:[String]
    var gamename:String
    var gameintro:String
    var gametext:String
    var bannerRefString:String
    var picRefString:String
    var voted=false
    var karma:Int
    var rating:Int
    var owned=false
    
    init(id:String,value:[String:Any],rating:Int) {
        self.developers=value["developers"] as! [String]
        self.gamename=value["gamename"] as! String
        self.gameintro=value["gameintro"] as! String
        self.gametext=value["gametext"] as! String
        self.bannerRefString=value["bannerRefString"] as! String
        self.picRefString=value["picRefString"] as! String
        self.karma=value["karma"] as! Int
        self.rating=value["rating"] as! Int
    }
    
    init? (snapshot: DataSnapshot){
        guard
            let value = snapshot.value as? [String:AnyObject],
            let gamename = value["gamename"] as? String,
            let developers=value["developers"] as? [String],
            let gameintro=value["gameintro"] as? String,
            let gametext=value["gametext"] as? String,
            let bannerRefString=value["bannerRefString"] as? String,
            let picRefString=value["picRefString"] as? String,
            let karma=value["karma"] as? Int,
            let rating=value["rating"] as? Int else{
                return nil
        }
        self.gameid=snapshot.ref
        self.gamename=gamename
        self.developers=developers
        self.gameintro=gameintro
        self.gametext=gametext
        self.bannerRefString=bannerRefString
        self.picRefString=picRefString
        self.karma=karma
        self.rating=rating
    }
}
