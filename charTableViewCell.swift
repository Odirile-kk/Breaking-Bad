//
//  charTableViewCell.swift
//  BB API
//
//  Created by IACD-Air-6 on 2021/07/05.
//

import UIKit

class charTableViewCell: UITableViewCell {

   
    @IBOutlet weak var bdayLbl: UILabel!
    @IBOutlet weak var nickLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var charImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
