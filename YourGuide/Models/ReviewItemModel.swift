//
//  ReviewItemModel.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 15/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

import Marshal

struct ReviewItemModel: Unmarshaling {
    var id: Int?
    var rating: String?
    var title: String?
    var message: String?
    var author: String?
    var date: String?
    var isAnonymous: Bool?
    var reviewerCountry: String?
}

extension ReviewItemModel {
    init(object: MarshaledObject){
        id = try? object.value(for: "review_id")
        rating = try? object.value(for: "rating")
        title = try? object.value(for: "title")
        message = try? object.value(for: "message")
        title = try? object.value(for: "title")
        author = try? object.value(for: "author")
        date = try? object.value(for: "date")
        isAnonymous = try? object.value(for: "isAnonymous")
        reviewerCountry = try? object.value(for: "reviewerCountry")
    }
}
