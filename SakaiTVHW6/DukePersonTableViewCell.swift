//
//  DukePersonTableViewCell.swift
//  ECE564_HOMEWORK
//
//  Created by yuyuanyuan on 9/16/18.
//  Copyright © 2018 ece564. All rights reserved.
//

import UIKit

//this is the cell class for tableview
class DukePersonTableViewCell: UITableViewCell {


    @IBOutlet weak var postBtn: postBtn!
    
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var cellDes: UITextView!
    
    @IBOutlet weak var cellimg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        //self.cellDes.isUserInteractionEnabled = false
        self.cellDes.isEditable = false
        self.cellDes.backgroundColor = LIGHT_GRAY
        self.cellLabel.backgroundColor = APPLE_GREEN
        self.cellLabel.font = UIFont(name: "Chalkduster", size: 15)
        self.cellLabel.textColor = UIColor.white
        self.cellDes.textColor = UIColor.white
        self.cellDes.font = UIFont(name: "Chalkduster", size: 10)
        self.cellimg.layer.cornerRadius = (self.cellimg.frame.size.width) / 2
        self.cellDes.layer.cornerRadius = 10
        self.cellimg.clipsToBounds = true
        self.cellimg.isHidden = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
