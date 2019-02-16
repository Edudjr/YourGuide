//
//  FilterViewController.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 16/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

import UIKit
import Cosmos

class FilterViewController: UIViewController {
    @IBOutlet weak var cosmos: CosmosView!
    @IBOutlet weak var newestFirstButton: RadioButton!
    @IBOutlet weak var newestFirstLabel: UILabel!
    @IBOutlet weak var oldestFirstButton: RadioButton!
    @IBOutlet weak var oldestFirstLabel: UILabel!
    @IBOutlet weak var applyButton: UIButton!
    
    var filterViewModel: FilterViewModelProtocol?
    var shadowedView: UIView?
    
    override func viewDidLoad() {
        if let parent = self.presentingViewController {
            shadowedView = UIView(frame: parent.view.frame)
            shadowedView!.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            parent.view.addSubview(shadowedView!)
        }
        cosmos.didFinishTouchingCosmos = { [weak self] rating in
            self?.filterViewModel?.rating = rating
        }
        setupListeners()
        setupView()
    }
    
    func setupView() {
        cosmos.rating = filterViewModel?.rating ?? 0.0
        newestFirstButton.isSelected = filterViewModel?.newestFirstSelected ?? false
        oldestFirstButton.isSelected = filterViewModel?.oldestFirstSelected ?? false
    }
    
    func setupListeners() {
        filterViewModel?.onRatingChanged = { [weak self] rating in
            self?.cosmos.rating = rating
        }
        filterViewModel?.onUpdateRadioButtons = { [weak self] isNewestSelected, isOldestSelected in
            self?.newestFirstButton.isSelected = isNewestSelected
            self?.oldestFirstButton.isSelected = isOldestSelected
        }
    }
    
    @IBAction func applyButtonTap(_ sender: Any) {
        filterViewModel?.applyFilters()
        shadowedView?.removeFromSuperview()
        dismiss(animated: true)
    }
    
    @IBAction func removeFiltersTap(_ sender: Any) {
        filterViewModel?.removeFilters()
    }
    
    @IBAction func newestFirstTap(_ sender: Any) {
        filterViewModel?.newestFirstSelected = newestFirstButton.isSelected
    }
    @IBAction func oldestFirstTap(_ sender: Any) {
        filterViewModel?.oldestFirstSelected = oldestFirstButton.isSelected
    }
    
}
