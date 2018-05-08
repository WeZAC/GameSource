//
//  DatabaseManager.swift
//  GameSource
//
//  Created by Langtian Qin on 4/23/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//
/*
import Foundation
import Firebase
import FirebaseAuthUI

class DatabaseManager{
    
    lazy var database=Database.database()
    func rateGame(game:GSGame,rating:Int){
        let pastrating=game.rating
        let gamekarma=database.reference(withPath:"games/\(game.gameid)/karma")
        let gamerating=database.reference(withPath:"games/\(game.gameid)/userratings/\(Auth.auth().currentUser?.uid)")
        if(pastrating==0){
            if(rating==1){
                gamerating.setValue(1)
                gamekarma.setValue(gamekarma.+1)
            }
            else if(rating==2){
                gamerating.setValue(2)
                gamekarma.setValue(gamekarma-1)
            }
        }
        else if(pastrating==0){
            if(rating==1){
                gamerating.setValue(1)
                gamekarma.setValue(gamekarma+1)
            }
            else if(rating==2){
                gamerating.setValue(2)
                gamekarma.setValue(gamekarma-1)
            }
        }
    }
}
 */
