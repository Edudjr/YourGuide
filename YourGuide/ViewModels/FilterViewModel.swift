//
//  FilterViewModel.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 16/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

protocol FilterViewModelProtocol {
    var onRatingChanged: ((_ rating: Double) -> Void)? { get set }
    var onUpdateRadioButtons: ((_ isNewestSelected: Bool, _ isOldestSelected: Bool) -> Void)? { get set }
    var onFiltersApply: ((_ rating: Double, _ newestFirst: Bool, _ oldestFirst: Bool) -> Void)? { get set }
    var rating: Double { get set }
    var newestFirstSelected: Bool { get set }
    var oldestFirstSelected: Bool { get set }
    func removeFilters()
    func applyFilters()
}

class FilterViewModel: FilterViewModelProtocol {
    var rating: Double = 0 {
        didSet {
            onRatingChanged?(rating)
        }
    }
    var newestFirstSelected: Bool {
        get {
            return _newestFirstSelected
        }
        set {
            _newestFirstSelected = newValue
            _oldestFirstSelected = !newValue
            onUpdateRadioButtons?(_newestFirstSelected, _oldestFirstSelected)
        }
    }
    var oldestFirstSelected: Bool {
        get {
            return _oldestFirstSelected
        }
        set {
            _oldestFirstSelected = newValue
            _newestFirstSelected = !newValue
            onUpdateRadioButtons?(_newestFirstSelected, _oldestFirstSelected)
        }
    }
    var _newestFirstSelected: Bool = false
    var _oldestFirstSelected: Bool = false
    
    var onUpdateRadioButtons: ((_ isNewestSelected: Bool, _ isOldestSelected: Bool) -> Void)?
    
    //Listeners
    var onRatingChanged: ((_ rating: Double) -> Void)?
    var onFiltersApply: ((_ rating: Double, _ newestFirst: Bool, _ oldestFirst: Bool) -> Void)?
    
    func removeFilters() {
        rating = 0
        _newestFirstSelected = false
        _oldestFirstSelected = false
        onUpdateRadioButtons?(_newestFirstSelected, _oldestFirstSelected)
    }
    
    func applyFilters() {
        onFiltersApply?(rating, _newestFirstSelected, _oldestFirstSelected)
    }
}
