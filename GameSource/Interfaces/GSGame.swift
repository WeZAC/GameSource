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
    var gameRef:DatabaseReference?
    var gameid:String
    var developer:String
    var gamename:String
    var gameintro:String
    var picRefString:String
    var voted=false
    var karma:Int
    var rating:Int
    var owned=false
    var pagedist:[Int]
    var textdist=[String]()
    var tagdist=[String]()
    
    init(id:String,value:[String:Any],rating:Int) {
        self.gameid=value["gameid"] as! String
        self.developer=value["developers"] as! String
        self.gamename=value["gamename"] as! String
        self.gameintro=value["gameintro"] as! String
        self.picRefString=value["picRefString"] as! String
        self.karma=value["karma"] as! Int
        self.rating=value["rating"] as! Int
        self.pagedist=value["pagedist"] as! [Int]
        self.tagdist=value["tagdist"]as![String]
    }
    
    init? (snapshot: DataSnapshot){
        guard
            let value = snapshot.value as? [String:AnyObject],
            let gameid = value["gameid"] as? String,
            let gamename = value["gamename"] as? String,
            let developers=value["developers"] as? String,
            let gameintro=value["gameintro"] as? String,
            let picRefString=value["picRefString"] as? String,
            let karma=value["karma"] as? Int,
            let rating=value["rating"] as? Int,
            let pagedist=value["pagedist"] as? [Int],
            let tagdist=value["tagdist"] as? [String]
            else{
                return nil
        }
        self.gameid=gameid
        self.gameRef=snapshot.ref
        self.gamename=gamename
        self.developer=developers
        self.gameintro=gameintro
        self.picRefString=picRefString
        self.karma=karma
        self.rating=rating
        self.pagedist=pagedist
        self.tagdist=tagdist
        for i in stride(from: 0, to: pagedist.count, by: 1){
            switch pagedist[i]{
            case 0:continue;
            case 1:let Path1=String(i)+"-"+String(1)
                textdist.append(value[Path1] as! String)
            case 2:let Path1=String(i)+"-"+String(1)
                let Path2=String(i)+"-"+String(2)
                textdist.append(value[Path1] as! String)
                textdist.append(value[Path2] as! String)
            default:continue;
            }
        }
    }
}
