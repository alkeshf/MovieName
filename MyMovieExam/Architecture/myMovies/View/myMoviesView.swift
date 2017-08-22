//
//  myMoviesView.swift
//  MyMovieExam
//
//  Created by Alkesh on 21/08/17.
//  Copyright © 2017 Alkesh. All rights reserved.
//

import UIKit

class myMoviesView: ViewParentWithoutXIB {

    @IBOutlet var tblview:UITableView!
    @IBOutlet var viewHeader:UIView!
    var spinner = UIActivityIndicatorView()
    
    // MARK: - Register Cells | Delegates
    internal func setupLayout() {
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.stopAnimating()
        spinner.hidesWhenStopped = true
        spinner.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 35)
        tblview.tableFooterView = spinner
        
    }

    internal func setTheDelegates(theDelegate: myMoviesManager) {
        tblview.delegate   = theDelegate
        tblview.dataSource = theDelegate
        //viewNavigationHeader.delegateButtonTapped = (self.next) as! DashboardVC
    }
    
    
    
}
