//
//  GSUSer.swift
//  GameSource
//
//  Created by Langtian Qin on 4/23/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import Foundation
import Firebase

class GSUser{
    var uid:String
    var username:String
    var realname:String
    var desc:String
    var picRefString:String
    var textdist:[String]
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"]! as! String
        self.username = dictionary["username"]as! String
        
        self.desc=dictionary["desc"] as! String
        self.textdist=dictionary["textdist"] as! [String]
        self.realname=dictionary["realname"] as! String
        self.picRefString=dictionary["picRefString"] as! String
    }
    init?(snapshot:DataSnapshot){
        guard
        let value=snapshot.value as? [String:AnyObject],
        let uid=value["uid"] as? String,
        let username=value["username"] as? String,
        let realname=value["realname"] as? String,
        let desc=value["desc"] as? String,
        let textdist=value["textdist"] as? [String],
        let picRefString=value["picRefString"] as? String
            else{
                return nil
        }
        self.uid=uid
        self.username=username
        self.realname=realname
        self.desc=desc
        self.textdist=textdist
        self.picRefString=picRefString
    }
    init(user:User) {
        self.uid=user.uid
        self.username=user.displayName ?? ""
        self.realname=""
        self.desc=""
        self.textdist=[""]
        self.picRefString=""
    }
}
extension GSUser:Equatable{
    static func ==(lhs:GSUser,rhs:GSUser)->Bool{
        return lhs.uid==rhs.uid
    }
    
    static func ==(lhs:GSUser,rhs:User)->Bool{
        return lhs.uid==rhs.uid
    }
}
