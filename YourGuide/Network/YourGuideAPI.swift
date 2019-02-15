//
//  YourGuideAPI.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 15/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

import Foundation

typealias CompletionWithUserReviews = (_ error: YourGuideError?, _ reviews: ReviewResponseModel?) -> Void

protocol YourGuideAPIProtocol {
    func getReviews(parameters: APIParameters, completion: @escaping CompletionWithUserReviews)
}

class YourGuideAPI: YourGuideAPIProtocol {
    let baseURL = "https://www.getyourguide.com/berlin-l17/tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776"
    let provider: RequestProtocol?
    
    enum Endpoint: String {
        case reviews = "/reviews.json"
    }
    
    init(provider: RequestProtocol) {
        self.provider = provider
    }
    
    func getReviews(parameters: APIParameters, completion: @escaping CompletionWithUserReviews) {
        let parsedParams = parseParameters(parameters)
        let url = baseURL + Endpoint.reviews.rawValue
        
        provider?.request(url: url, method: .get, params: parsedParams, headers: nil, completion: { response in
            switch response.result {
            case .success:
                if response.response?.statusCode == 200, let json = response.result.value as? [String: Any] {
                    let review = ReviewResponseModel(object: json)
                    completion(nil, review)
                } else {
                    completion(YourGuideError.parsingError, nil)
                }
            case .failure:
                completion(YourGuideError.serverError, nil)
            }
        })
    }
    
    func parseParameters(_ parameters: APIParameters) -> [String: String] {
        var dict = [String: String]()
        if let count = parameters.count {
            dict["count"] = "\(count)"
        }
        if let page = parameters.page {
            dict["page"] = "\(page)"
        }
        if let rating = parameters.rating {
            dict["rating"] = "\(rating)"
        }
        if let direction = parameters.direction {
            dict["direction"] = direction.rawValue.uppercased()
        }
        if let sortBy = parameters.sortBy {
            dict["sortBy"] = sortBy.rawValue
        }
        return dict
    }
}
