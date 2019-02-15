//
//  ReviewsViewController.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 15/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {
    
    var reviewsViewModel: ReviewsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup
        let provider = AlamofireRequest()
        let api = YourGuideAPI(provider: provider)
        reviewsViewModel = ReviewsViewModel(api: api)
        
        setupListeners()
        reviewsViewModel?.getMoreReviews()
    }
    
    func setupListeners() {
        reviewsViewModel?.onReviewItemViewModels = { items in
            print(items)
        }
    }
}

