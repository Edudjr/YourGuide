//
//  ReviewResponseModel.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 15/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

import Marshal

struct ReviewResponseModel: Unmarshaling {
    var status: Bool?
    var totalComments: Int?
    var items: [ReviewItemModel]?
}

extension ReviewResponseModel {
    init(object: MarshaledObject){
        status = try? object.value(for: "status")
        totalComments = try? object.value(for: "total_reviews_comments")
        items = try? object.value(for: "data")
    }
}
