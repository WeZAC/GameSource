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
    
    let databaseRef=Database.database().reference()
    
    class func rateGame(user:GSUser,game:GSGame,vote:Bool) -> Void{
        let prefRef=databaseRef.child("preference")
        var karma = -1
        let userPref=prefRef.child(user.uid)
        userPref.observeSingleEvent(of: .value, with: {(snapshot) in
            if(snapshot.hasChild(game.gameid)){
                karma=value[game.gameid]
            }
        })
        if(karma==1&&!vote){
            game.gameRef?.setValue(["karma":game.karma-2])
        }else if(karma==0&&vote){
            game.gameRef?.setValue(["karma":game.karma+2])
        }else if(karma==-1){
            var newK=vote ? game.karma+1 : game.karma-1;
            game.gameRef?.setValue(["karma":newK])
        }
    }
    
    
}

