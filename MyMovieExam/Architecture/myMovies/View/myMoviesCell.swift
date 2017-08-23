//
//  myMoviesCell.swift
//  MyMovieExam
//
//  Created by Alkesh on 21/08/17.
//  Copyright © 2017 Alkesh. All rights reserved.
//

import UIKit

class myMoviesCell: UITableViewCell {

    @IBOutlet var imgChannel:UIImageView!
    @IBOutlet var imgRating:UIImageView!
    @IBOutlet var lblMovieName:UILabel!
    @IBOutlet var lblMovieTime:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadData(shareobj:Result) -> Void {
        lblMovieName.text = shareobj.name!
        lblMovieTime.text = "\(shareobj.start_time!) - \(shareobj.end_time!)"
        imgRating.image   = UIImage(named: shareobj.rating!)
        imgChannel.image  = UIImage(named: shareobj.channel!)
    }
}
