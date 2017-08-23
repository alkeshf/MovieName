//
//  movieDetailManager.swift
//  MyMovieExam
//
//  Created by Alkesh on 21/08/17.
//  Copyright © 2017 Alkesh. All rights reserved.
//

import UIKit

class movieDetailManager: NSObject {

    fileprivate unowned var theController: movieDetailViewController
    fileprivate var theModel: movieDetailModel
    
    init(theController: movieDetailViewController, theModel: movieDetailModel) {
        self.theController = theController
        self.theModel = theModel
    }
    
   
}
