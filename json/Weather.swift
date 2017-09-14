//
//  File.swift
//  json
//
//  Created by Parsa Alamzadeh on 2017-09-12.
//  Copyright © 2017 Parsa Alamzadeh. All rights reserved.
//

import Foundation
import MapKit

class Weather{
    
    init(address: String, API: String) {
        location = address
        Api = API
    }
    private var location: String
    private var Api: String
    
    
    func geocode (address: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            if error == nil{
                if let _ = placemarks?.first?.location{
                    
                }
            }
            else {
                print ("no location found")
            }
        }
        return
    }
}
