//
//  ReviewsViewModel.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 15/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

protocol ReviewsViewModelProtocol {
    var onTotalComments: ((_ total: Int) -> Void)? { get set }
    var onReviewItemViewModels: ((_ items: [ReviewItemViewModelProtocol]) -> Void)? { get set }
    var onError: ((_ error: YourGuideError) -> Void)? { get set }
    var reviewItemViewModels: [ReviewItemViewModelProtocol] { get set }
    var filterViewModel: FilterViewModelProtocol { get set }
    func getMoreReviews()
}

class ReviewsViewModel: ReviewsViewModelProtocol {
    var currentPage = 0
    var count = 20
    var direction = APIParameters.Direction.desc
    var rating: Double? = nil
    var sortBy: APIParameters.SortBy = .date
    
    var totalComments = 0
    var filterViewModel: FilterViewModelProtocol
    var reviewItemViewModels: [ReviewItemViewModelProtocol] {
        didSet {
            onReviewItemViewModels?(reviewItemViewModels)
        }
    }
    
    //Listeners
    var onTotalComments: ((_ total: Int) -> Void)?
    var onReviewItemViewModels: ((_ items: [ReviewItemViewModelProtocol]) -> Void)?
    var onError: ((_ error: YourGuideError) -> Void)?
    
    //Dependencies
    var api: YourGuideAPIProtocol?
    
    init(api: YourGuideAPIProtocol, filterViewModel: FilterViewModelProtocol, reviewItemViewModels: [ReviewItemViewModelProtocol]) {
        self.api = api
        self.filterViewModel = filterViewModel
        self.reviewItemViewModels = reviewItemViewModels
        setupListeners()
    }
    
    func setupListeners() {
        filterViewModel.onFiltersApply = { [weak self] rating, newestFirst, oldestFirst in
            var direction = APIParameters.Direction.desc
            if newestFirst {
                direction = .desc
            } else if oldestFirst {
                direction = .asc
            }
            self?.applyFilters(rating: rating, direction: direction)
        }
    }
    
    func getMoreReviews() {
        let parameters = APIParameters(count: count,
                                       page: currentPage,
                                       rating: rating,
                                       sortBy: sortBy,
                                       direction: direction)
        api?.getReviews(parameters: parameters, completion: { [weak self] (error, responseViewModel) in
            if let error = error {
                self?.onError?(error)
            } else if let response = responseViewModel, let items = response.items {
                items.forEach({ item in
                    let temp = ReviewItemViewModel(title: item.title,
                                                   author: item.author,
                                                   comment: item.message,
                                                   country: item.reviewerCountry,
                                                   rating: item.ratingDouble,
                                                   date: item.date)
                    self?.reviewItemViewModels.append(temp)
                })
            }
        })
        currentPage += 1
    }
    
    func applyFilters(rating: Double?, direction: APIParameters.Direction) {
        self.rating = rating
        self.direction = direction
        resetState()
        getMoreReviews()
    }
    
    func resetState() {
        currentPage = 0
        reviewItemViewModels.removeAll()
    }
}
