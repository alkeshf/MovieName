//
//  GlobalStoryboards.swift
//  DemoLiveTracking
//
//  Created by Bharat Nakum on 2/3/17.
//  Copyright © 2017 Bharat Nakum. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryBoardString: String {
    case Main
    case Home
    case Settings
    case Driver
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiateFromAppStoryboard(appStoryboard: AppStoryBoardString) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
