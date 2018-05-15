//
//  DatabaseManager.swift
//  GameSource
//
//  Created by Langtian Qin on 4/23/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuthUI

class DatabaseManager{
    
    
    class func rateGame(user:GSUser,game:GSGame,vote:Bool) -> Void{
        let databaseRef=Database.database().reference()
        let prefRef=databaseRef.child("preference")
        var karma = -1
        let userPref=prefRef.child(user.uid)
        userPref.observeSingleEvent(of: .value, with: {(snapshot) in
            if(snapshot.hasChild(game.gameid)){
                let value=snapshot.value as? NSDictionary
                karma=value?[game.gameid] as! Int
            }
        })
        if(karma==1 && !vote){
            game.gameRef?.setValue(["karma":game.karma-2])
        }else if(karma==0&&vote){
            game.gameRef?.setValue(["karma":game.karma+2])
        }else if(karma+1==0){
            let newK=vote ? game.karma+1 : game.karma-1;
            game.gameRef?.setValue(["karma":newK])
        }
    }
    
    
}

