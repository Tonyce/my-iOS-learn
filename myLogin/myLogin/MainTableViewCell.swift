//
//  MainTableViewCell.swift
//  myLogin
//
//  Created by D_ttang on 15/6/25.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var contentText: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
//    @IBOutlet weak var meImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         timeLabel.layer.cornerRadius = 20
         timeLabel.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - Properties
//    var cellEntry: CellEntry? {
//        didSet {
//            configureCell()
//        }
//    }
//    
//    // MARK: - Utility methods
//    private func configureCell() {
//        timeLabel.text = cellEntry.cityImage
//        contentText.text = cellEntry.name
//    }

}

//        let meImage = UIImage(named: "me")
//
//        let meView = UIImageView(frame: CGRectMake(0, 0, 50, 50))
//        meView.image = meImage
//meImageView.layer.cornerRadius = 20
//meImageView.layer.masksToBounds = true
//        addSubview(meView)