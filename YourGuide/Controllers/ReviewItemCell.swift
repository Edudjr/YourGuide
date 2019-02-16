//
//  ReviewItemCell.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 15/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//
import UIKit
import Cosmos

class ReviewItemCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var cosmos: CosmosView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var reviewItemViewModel: ReviewItemViewModel?
    
    func configureWith(_ model: ReviewItemViewModelProtocol) {
        commentLabel.text = model.comment ?? " "
        cosmos.rating = model.rating ?? 0
        titleLabel.text = model.title
        authorLabel.text = model.author
        dateLabel.text = model.date
    }
}
