//
//  ViewParent.swift
//  DailyDoc
//
//  Created by Bharat Nakum on 2/24/17.
//  Copyright © 2017 Bharat Nakum. All rights reserved.
//

import UIKit

class ViewParent: UIView {
    
    // MARK: - IBOutlets
    var contentView : UIView?
    
    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupXIB()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupXIB()
    }
    
    private func setupXIB() {
        contentView = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        contentView!.frame = bounds
        
        // Make the view stretch with containing view
        contentView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView!)
    }
    
    private func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    deinit {
        print("\(self) DEALLOCATED")
    }
    
    override func addSubview(_ view: UIView) {
        if view.isDescendant(of: self) {
            return
        }
        
        super.addSubview(view)
    }
}
