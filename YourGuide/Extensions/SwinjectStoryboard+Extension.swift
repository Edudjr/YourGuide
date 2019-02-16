//
//  SwinjectStoryboard+Extension.swift
//  YourGuide
//
//  Created by Eduardo Domene Junior on 16/02/19.
//  Copyright © 2019 Eduardo Domene Junior. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc class func setup() {
        setupProduction(defaultContainer)
    }
    
    class func setupProduction(_ defaultContainer: Container) {
        defaultContainer.register(RequestProtocol.self) { _ in
            AlamofireRequest()
        }
        defaultContainer.register(YourGuideAPIProtocol.self) { r in
            YourGuideAPI(provider: r.resolve(RequestProtocol.self)!)
        }
        defaultContainer.register(FilterViewModelProtocol.self) { _ in
            FilterViewModel()
        }
        defaultContainer.register(ReviewsViewModelProtocol.self) { r in
            ReviewsViewModel(api: r.resolve(YourGuideAPIProtocol.self)!,
                             filterViewModel: r.resolve(FilterViewModelProtocol.self)!,
                             reviewItemViewModels: [ReviewItemViewModelProtocol]())
        }
        defaultContainer.storyboardInitCompleted(ReviewsViewController.self) { resolver, controller in
            controller.reviewsViewModel = resolver.resolve(ReviewsViewModelProtocol.self)
        }
    }
}
