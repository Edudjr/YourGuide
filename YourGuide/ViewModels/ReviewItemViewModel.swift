//
//  ReviewItemViewModel.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 15/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

class ReviewItemViewModel {
    var author: String?
    var comment: String?
    var country: String?
    
    init(author: String?, comment: String?, country: String?) {
        self.author = author
        self.comment = comment
        self.country = country
    }
}
