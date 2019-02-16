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
    private var shouldFetch = true
    private var indicator: ActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupListeners()
        
        showLoading()
        reviewsViewModel?.getMoreReviews()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func setupListeners() {
        reviewsViewModel?.onReviewItemViewModels = { [weak self] items in
            self?.hideLoading()
            self?.tableView.reloadData()
        }
        reviewsViewModel?.onError = { [weak self] error in
            self?.hideLoading()
            self?.showErrorMessage(message: error.localizedDescription)
        }
        reviewsViewModel?.onApplyFilters = { [weak self] in
            self?.showLoading()
        }
    }
    
    func showLoading() {
        tableView.separatorStyle = .none
        indicator = ActivityIndicatorView()
        indicator?.showLoadingOn(view)
    }
    
    func hideLoading() {
        tableView.separatorStyle = .singleLine
        indicator?.removeFromSuperview()
        indicator = nil
    }
    
    func showErrorMessage(message: String) {
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FilterViewController {
            destination.filterViewModel = reviewsViewModel?.filterViewModel
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let offset = 5
        let count = reviewsViewModel?.reviewItemViewModels.count ?? 0
        if count > 0, indexPath.row >= count - offset {
            if shouldFetch {
                shouldFetch = false
                reviewsViewModel?.getMoreReviews()
            }
        } else {
            shouldFetch = true
        }
    }
}
