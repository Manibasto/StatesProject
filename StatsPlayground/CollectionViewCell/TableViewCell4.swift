//
//  TableViewCell4.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 12/12/18.
//  Copyright © 2018 AIT. All rights reserved.
//

import UIKit

class TableViewCell4: UITableViewCell {
    @IBOutlet weak var playoff: UILabel!
    @IBOutlet weak var winoff: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
