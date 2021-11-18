//
//  TableViewCell.swift
//  week_7_coreData
//
//  Created by Ahmed Alenazi on 13/04/1443 AH.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var TitelOutLet: UILabel!
    @IBOutlet weak var DetailOutLet: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
