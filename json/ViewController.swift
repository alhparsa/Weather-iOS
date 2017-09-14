//
//  ViewController.swift
//  json
//
//  Created by Parsa Alamzadeh on 2017-09-11.
//  Copyright © 2017 Parsa Alamzadeh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    
    @IBOutlet weak var usrInput: UISearchBar!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var dailyDetails: UITableView!
    @IBOutlet weak var summaryText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyDetails.delegate = self
        dailyDetails.dataSource = self
        usrInput.delegate = self
        
        }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell=dailyDetails.dequeueReusableCell(withIdentifier: "details", for: indexPath)as? DailyCell{
            cell.backgroundColor = nil
            cell.conditionImage.image = #imageLiteral(resourceName: "Sun")
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let address = usrInput.text
        let weather = Weather()
        weather.initial(address: address!)
        
        _ = weather.getCoordinate(addressString: address!) { (bool, placemark) in
            if bool{
                self.countryLabel.text = placemark?.country
                self.cityLabel.text = placemark?.locality
                weather.parse(latitude: Double(round(10000*(placemark?.location?.coordinate.latitude)!)/10000), longtitude: Double(round(10000*(placemark?.location?.coordinate.longitude)!)/10000))
                weather.process(uiLable: self.summaryText)
                
                
            }else{
                print("location not found")
            }
        }
        searchBar.resignFirstResponder()
    }
    
    
    

}


class Weather{
    struct forecast: Decodable {
        let latitude: Double?
        let longitude: Double?
        let timezone: String?
        let currently: current?
        let minutely: minute?
        let hourly: hour?
        let daily: day?
        let flags: flag?
        let offset: Int?
        
    }
    
    struct current: Decodable {
        let time: Int?
        let summary: String?
        let icon: String?
        let nearestStormDistance: Int?
        let temperature: Double
        
    }
    struct minute: Decodable {
        
    }
    struct hour: Decodable {
        
    }
    struct day: Decodable {
        
    }
    struct flag: Decodable {
        
    }
    struct data: Decodable{
        
    }
    
    
    private var location: String?
    var info: forecast?
    var place:CLPlacemark?
    var country:String?
    
    
    var conditionSum: String = ""
    
    func initial (address: String) {
        location = address
    }
    
    
    func getCoordinate(addressString : String,
                       completion: @escaping (Bool, CLPlacemark?)->()) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if (placemarks?[0]) != nil {
                    completion(true, placemarks?.first)
                    return
                }
            }
            
            completion(false, placemarks?.first)
        }
    }
    
    
    func parse (latitude: Double, longtitude: Double){
        
        
        let jsonUrlString = "https://api.darksky.net/forecast/apiKey/\(latitude),\(longtitude)"
        
        guard let url = URL(string: jsonUrlString) else{
            return
        }
        
        var information: forecast?
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            //check err
            //check response status 200 ok
            
            guard let data = data else{return}
            
            do{
                let json = try JSONDecoder().decode(forecast.self, from: data)
                print (json)
                self.info = json
                print("information",self.info?.currently)
                
            } catch {
                print("didnt work")
            }
            
            }.resume()
        
        
        }
    func process(uiLable:UILabel) {
          print("\(self.info?.currently?.summary) •\(self.info?.currently?.temperature)")
    }
    
}


