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
    var pictureURL:URL?
    var intro:String
    var signature:String
    
    init(dictionary: [String: String]) {
        self.uid = dictionary["uid"]!
        self.fullname = dictionary["username"] ?? ""
        guard let pictureURLString = dictionary["pictureURL"],
            let pictureURL = URL(string: pictureURLString) else { return }
        self.pictureURL = pictureURL
    }
    
    private init(user: User) {
        self.uid = user.uid
        self.username = user.displayName ?? ""
        self.pictureURL = user.photoURL
    }
    
    static func currentUser() -> GSUser{
        return GSUser(user:Auth.auth().currentUser!)
    }
    
    
    extension GSUser:Equatable{
        static func ==(lhs:GSUser,rhs:GSUser)->Bool{
            return lhs.uid==rhs.uid
        }
        
        static func ==(lhs:GSUser,rhs:User)->Bool{
            return lhs.uid==rhs.uid
        }
    }
    
    
    
}
