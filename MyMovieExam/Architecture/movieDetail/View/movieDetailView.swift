//
//  movieDetailView.swift
//  MyMovieExam
//
//  Created by Alkesh on 21/08/17.
//  Copyright © 2017 Alkesh. All rights reserved.
//

import UIKit

class movieDetailView: ViewParentWithoutXIB {

    @IBOutlet var imgRating:UIImageView!
    @IBOutlet var lblMovieName:UILabel!
    @IBOutlet var lblMovieTime:UILabel!
    
    // MARK: - Register Cells | Delegates
    internal func setupLayout() {
       
    }

    func loadData(shareobj:Result) -> Void {
        lblMovieName.text = shareobj.name!
        lblMovieTime.text = "\(shareobj.start_time!) - \(shareobj.end_time!)"
        imgRating.image   = UIImage(named: shareobj.rating!)

    }
}
