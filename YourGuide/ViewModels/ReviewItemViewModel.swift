//
//  ReviewItemViewModel.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 15/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

protocol ReviewItemViewModelProtocol {
    var title: String? { get set }
    var author: String? { get set }
    var comment: String? { get set }
    var country: String? { get set }
    var rating: Double? { get set }
    var date: String? { get set }
}

class ReviewItemViewModel: ReviewItemViewModelProtocol {
    var title: String?
    var author: String?
    var comment: String?
    var country: String?
    var rating: Double?
    var date: String?
    
    init(title: String?, author: String?, comment: String?, country: String?, rating: Double?, date: String?) {
        self.title = title
        self.author = author
        self.comment = comment
        self.country = country
        self.rating = rating
        self.date = date
    }
}
