//
//  NavigationHeader.swift
//  MyPortfolios
//
//  Created by Alkesh on 06/04/17.
//  Copyright © 2017 Alkesh. All rights reserved.
//

import UIKit


internal enum HeaderButtonTaped {
    case buttonSidemenu
    case buttonMail
}

protocol NavigationHeaderButtonTappedProtocol: class {
    func headerButtonTappedWithType(tapedButton: HeaderButtonTaped)
}


@IBDesignable internal class NavigationHeader: ViewParent {

    // Other Buttons
    @IBOutlet internal var btnSidemenu:UIButton!
    @IBOutlet internal var btnMail:UIButton!

    // Other Lables
    @IBOutlet internal var lblTitle:UILabel!

    
    // Protocol Delegate
    internal weak var delegateButtonTapped: NavigationHeaderButtonTappedProtocol?
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - IBAction Methods
    @IBAction private func onBtnMail(_ sender: Any) {
        delegateButtonTapped?.headerButtonTappedWithType(tapedButton: .buttonMail)
    }
    
    @IBAction private func onBtnSidemenu(_ sender:Any){
        delegateButtonTapped?.headerButtonTappedWithType(tapedButton: .buttonSidemenu)
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
