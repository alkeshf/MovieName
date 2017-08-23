//
//  ViewParentWithoutXIB.swift
//  DailyDoc
//
//  Created by Bharat Nakum on 2/25/17.
//  Copyright © 2017 Bharat Nakum. All rights reserved.
//

import UIKit

class ViewParentWithoutXIB: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - View Lifecycle
    deinit {
        print("\(self) DEALLOCATED")
    }
    
    override func addSubview(_ view: UIView) {
        if view.isDescendant(of: self) {
            return
        }
        
        super.addSubview(view)
    }
    
    // MARK: - UI Methods
    func toggleAnyView<T: UIView>(duration: Double, anyView: [T], isHidden: Bool) {
        UIView.animate(withDuration: TimeInterval(duration)) { 
            for theView in anyView {
                theView.isHidden = isHidden
            }
        }
    }
}
