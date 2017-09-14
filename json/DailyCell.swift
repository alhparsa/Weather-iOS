//
//  DailyCell.swift
//  json
//
//  Created by Parsa Alamzadeh on 2017-09-12.
//  Copyright © 2017 Parsa Alamzadeh. All rights reserved.
//

import UIKit

class DailyCell: UITableViewCell {

    @IBOutlet weak var detailsCell: DailyCell!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var dayofWeek: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var conditionDescription: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var humidityVal: UILabel!
    @IBOutlet weak var precipitationVal: UILabel!
    @IBOutlet weak var windVal: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    

}
