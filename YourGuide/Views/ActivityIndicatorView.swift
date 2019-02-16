//
//  ActivityIndicatorView.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 16/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {
    private var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinited")
    }
    
    func showLoadingOn(_ aView: UIView) {
        self.frame = aView.frame
        aView.addSubview(self)
        showLoading()
    }
    
    private func showLoading() {
        addSubview(activityIndicator)
        activityIndicator.frame = bounds
        activityIndicator.startAnimating()
    }
}
