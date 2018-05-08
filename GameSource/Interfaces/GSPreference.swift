//
//  GSPreference.swift
//  GameSource
//
//  Created by Langtian Qin on 4/23/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import Foundation
import Firebase

class GSPreference{
    var prefdic:[String:Bool]
    
    init(value:[String:String]) {
        prefdic=[:]
        for (spec,rating) in value{
            if rating=="true"{
                prefdic[spec]=true
            }
            else{
                prefdic[spec]=false
            }
        }
    }
}
