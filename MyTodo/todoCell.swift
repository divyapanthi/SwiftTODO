//
//  todoCell.swift
//  MyTodo
//
//  Created by Divya Panthi on 16/08/2022.
//

import UIKit

class todoCell: UITableViewCell {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgTitle: UIImageView!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var imgDescription: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
