//
//  ViewController.swift
//  WheatherAppWithAPI
//
//  Created by Kaan Yıldız on 18.03.2023.
//

import UIKit

class EnrtanceOfApp: UIViewController {

    
    @IBOutlet var TypedCity: UITextField!
    @IBOutlet var SearchButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchButton.tintColor = .black
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.TypedCity.text = ""
    }

    @IBAction func SerachStatusTapped(_ sender: Any) {
        
        if TypedCity.text != ""{
            performSegue(withIdentifier: "ToSearchResults", sender: nil)
        }else{
            makeAlert(M: "No city", E: "Please type a city you want to get wheather status")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSearchResults"{
            if let destinationVC = segue.destination as? SearchResultViewController{
                // hava durumunu alacağım şehri diğer VC a taşımasını yapıyorum.
                destinationVC.CityTyped = TypedCity.text
            }else{
                makeAlert(M: "Error", E: "typed city was not transfered")
            }
            
        }
    }
    
    
    func makeAlert(M: String, E: String){
        let alert = UIAlertController(title: M, message: E, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "ok", style: UIAlertAction.Style.default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}

