//
//  wheatherInfo.swift
//  WheatherAppWithAPI
//
//  Created by Kaan Yıldız on 18.03.2023.
//

import Foundation

struct wheatherInfo{
    var location : Location?
    var current : Current?
    
    init(fetchedData : Dictionary<String,Any>) {
        
        if let locationDic = fetchedData["location"] as? Dictionary<String,Any>{
            location = Location(locationDic: locationDic)
        }
        
        if let currentDic = fetchedData["current"] as? Dictionary<String,Any>{
            current = Current(currentDic: currentDic)
        }
        
    }
}

struct Location{
    // guaerd let ile yapsam atribute ları optinal dan kurtarabilir miyim??? dene sonra
    var name : String?
    var region : String?
    
    init(locationDic: Dictionary<String,Any>){
        
        if let name = locationDic["name"] as? String{
            self.name = name
        }
        if let region = locationDic["region"] as? String{
            self.region = region
        }
        
    }
}

struct Current{
    var last_updated : String?
    var temprture : Int?
    var condition : Condition?
    
    init(currentDic: Dictionary<String,Any> ) {
        if let temprture = currentDic["temp_c"] as? Int{
            self.temprture = temprture
        }
        if let last_update = currentDic["last_updated"] as? String{
            self.last_updated = last_update
        }
        if let condition = currentDic["condition"] as? Dictionary<String,Any>{
            
            if let wheatherStatus = condition["text"] as? String{
                self.condition = Condition(wheatherStatus: wheatherStatus)
            }
            
        }
    }
}

struct Condition{
    var wheatherStatus : String
}
