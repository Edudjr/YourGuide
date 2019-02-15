//
//  ReviewsViewController.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 15/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var reviewsViewModel: ReviewsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup
        let provider = AlamofireRequest()
        let api = YourGuideAPI(provider: provider)
        reviewsViewModel = ReviewsViewModel(api: api)
        
        setupListeners()
        reviewsViewModel?.getMoreReviews()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func setupListeners() {
        reviewsViewModel?.onReviewItemViewModels = { [weak self] items in
            self?.tableView.reloadData()
        }
    }
}

extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewsViewModel?.reviewItemViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewItemCell
        if let model = reviewsViewModel?.reviewItemViewModels[indexPath.row] {
            cell.configureWith(model)
        }
        return cell
    }
}
