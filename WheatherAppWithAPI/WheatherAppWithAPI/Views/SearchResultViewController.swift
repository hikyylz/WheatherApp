//
//  SearchResultViewController.swift
//  WheatherAppWithAPI
//
//  Created by Kaan Yıldız on 18.03.2023.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var api_key = "262e4de72a3045328e4112648231803"
    var url : URL?
    var CityTyped : String?
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var City: UILabel!
    @IBOutlet var Regian: UILabel!
    @IBOutlet var TempCel: UILabel!
    @IBOutlet var StatusText: UILabel!
    @IBOutlet var LastUpdatedTime: UILabel!  // bu internetten çektiğin data dan gelecek, Sonuç olarak bu değişirse data mın aktif olarak çalıştığını söyleyebilirim.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isHidden = false
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // 1- internetten typedcity nin bilgilerini çek
        // 2- internetten çekilen json data sını istediğim formatta store et
        // 3- istediğim formatta elimde tutuğum veriyi bu VC un view larında göster.
        
        hideContent(flag: true)
        
        if wrongCharsIn(text: CityTyped!){
            // problem
            letterAlert()
            return
        }
        
        
        url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(api_key)&q=\(CityTyped!)&aqi=no")
        
        
        WebService.dowlandData(URL: url!) { returnedData in
            if returnedData != nil{
                
                DispatchQueue.main.sync {
                    
                    if let tempTempruture = returnedData?.current?.temprture as? Int{
                        let tempruture = String(tempTempruture)
                        self.TempCel.text = tempruture + " C"
                        
                        if tempTempruture > 10{
                            self.imageView.image = UIImage(named: "nice")
                        }else{
                            self.imageView.image = UIImage(named: "tunder")
                            self.LastUpdatedTime.textColor = .white
                        }
                        
                        
                        self.hideContent(flag: false)
                        
                        if let name = returnedData?.location?.name as? String{
                            self.City.text = name
                        }
                        if let region = returnedData?.location?.region as? String{
                            self.Regian.text = region
                        }
                        
                        if let wheatherStatus = returnedData?.current?.condition?.wheatherStatus as? String{
                            self.StatusText.text = wheatherStatus
                        }
                        if let last_update = returnedData?.current?.last_updated as? String{
                            self.LastUpdatedTime.text = "last update Time: " + last_update
                        }
                        
                        
                    }else{
                        self.letterAlert()
                    }
                    
                    
                    
                }
                
                
            }
        }
        
        
    }
    
    func hideContent(flag: Bool){
        if flag{
            self.City.isHidden = true
            self.Regian.isHidden = true
            self.TempCel.isHidden = true
            self.StatusText.isHidden = true
            self.LastUpdatedTime.isHidden = true
        }else{
            self.City.isHidden = false
            self.Regian.isHidden = false
            self.TempCel.isHidden = false
            self.StatusText.isHidden = false
            self.LastUpdatedTime.isHidden = false
        }
    }
    
    func wrongCharsIn(text: String) -> Bool{
        let wrongChars = ["ı", "İ", "ü", "Ü", "ğ", "ç", "Ç", "ö", "Ö", " "]
        
        for item in wrongChars{
            if text.contains(item){
                return true
            }
        }
        
        return false
    }
    
    func letterAlert(){
        let alert = UIAlertController(title: "City you typed contains wrong charachters", message: "Please type a proper city name", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "return", style: UIAlertAction.Style.default) { myalertaction in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    

    
}
