//
//  AlamofireRequest.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 15/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestProtocol {
    func request(url: String,
                 method: HTTPMethod,
                 params: [String : String]?,
                 headers: HTTPHeaders?,
                 completion: @escaping (DataResponse<Any>) -> Void)
}

class AlamofireRequest: RequestProtocol {
    func request(url: String,
                 method: HTTPMethod,
                 params: [String : String]?,
                 headers: HTTPHeaders?,
                 completion: @escaping (DataResponse<Any>) -> Void) {
        
        let encoding: ParameterEncoding =  method == .post ? JSONEncoding.default : URLEncoding.default
        Alamofire.request(url,
                          method: method,
                          parameters: params,
                          encoding: encoding,
                          headers: headers)
            .responseJSON { (data) in
                completion(data)
        }
    }
}
