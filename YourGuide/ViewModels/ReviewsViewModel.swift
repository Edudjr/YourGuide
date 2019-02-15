//
//  ReviewsViewModel.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 15/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

protocol ReviewsViewModelProtocol {
    var onTotalComments: ((_ total: Int) -> Void)? { get set }
    var onReviewItemViewModels: ((_ items: [ReviewItemViewModel]) -> Void)? { get set }
    var onError: ((_ error: YourGuideError) -> Void)? { get set }
    var reviewItemViewModels: [ReviewItemViewModel] { get set }
    func getMoreReviews()
    func applyFilters(direction: APIParameters.Direction)
}

class ReviewsViewModel: ReviewsViewModelProtocol {
    var currentPage = 0
    var count = 20
    var direction = APIParameters.Direction.desc
    
    var totalComments = 0
    var reviewItemViewModels = [ReviewItemViewModel]() {
        didSet {
            onReviewItemViewModels?(reviewItemViewModels)
        }
    }
    
    //Listeners
    var onTotalComments: ((_ total: Int) -> Void)?
    var onReviewItemViewModels: ((_ items: [ReviewItemViewModel]) -> Void)?
    var onError: ((_ error: YourGuideError) -> Void)?
    
    //Dependencies
    var api: YourGuideAPIProtocol?
    
    init(api: YourGuideAPIProtocol) {
        self.api = api
    }
    
    func getMoreReviews() {
        let parameters = APIParameters(count: count,
                                       page: currentPage,
                                       rating: nil,
                                       sortBy: nil,
                                       direction: direction)
        api?.getReviews(parameters: parameters, completion: { [weak self] (error, responseViewModel) in
            if let error = error {
                self?.onError?(error)
            } else if let response = responseViewModel, let items = response.items {
                items.forEach({ item in
                    let temp = ReviewItemViewModel(author: item.author, comment: item.message, country: item.reviewerCountry)
                    self?.reviewItemViewModels.append(temp)
                })
            }
        })
        currentPage += 1
    }
    
    func applyFilters(direction: APIParameters.Direction) {
        self.direction = direction
        resetState()
        getMoreReviews()
    }
    
    func resetState() {
        currentPage = 0
        reviewItemViewModels.removeAll()
    }
}
