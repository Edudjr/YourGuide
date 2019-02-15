//
//  ReviewItemCell.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 15/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//
import UIKit

class ReviewItemCell: UITableViewCell {
    @IBOutlet weak var commentLabel: UILabel!
    
    var reviewItemViewModel: ReviewItemViewModel?
    
    func configureWith(_ model: ReviewItemViewModel) {
        commentLabel.text = model.comment ?? " "
    }
}
