//
//  APIParameters.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 15/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

struct APIParameters {
    enum Direction: String {
        case asc, desc
    }
    
    enum SortBy: String {
        case date = "date_of_review"
    }
    
    var count: Int?
    var page: Int?
    var rating: Double?
    var sortBy: SortBy?
    var direction: Direction?
}
