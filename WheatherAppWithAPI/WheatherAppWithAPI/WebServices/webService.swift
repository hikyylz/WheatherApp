//
//  webService.swift
//  WheatherAppWithAPI
//
//  Created by Kaan Yıldız on 18.03.2023.
//

import Foundation

struct WebService{
    
    
    // bu method verilen url deki json data sını indirip Dic<String,Any> formatında işemeye verecek bana.
    static func dowlandData(URL : URL , completion: @escaping ( wheatherInfo? ) -> ()){
        
        URLSession.shared.dataTask(with: URL) { dataFromInternet, _, error in
            guard let data = dataFromInternet else{
                completion(nil)
                return
            }
            
            do{
                let fetchedData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                
                // fetchedData içerisinde json objesinden oluşturduğum data duruyor..
                
                let newWheatherInfo = wheatherInfo(fetchedData: fetchedData)
                completion(newWheatherInfo)
                
            }catch{
                completion(nil)
            }
            
        }.resume()
        
    }
    
    
    
}
