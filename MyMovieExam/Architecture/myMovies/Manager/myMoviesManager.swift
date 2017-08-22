//
//  myMoviesManager.swift
//  MyMovieExam
//
//  Created by Alkesh on 21/08/17.
//  Copyright © 2017 Alkesh. All rights reserved.
//

import UIKit

class myMoviesManager: NSObject {

    fileprivate unowned var theController: myMoviesViewController
    fileprivate var theModel: myMoviesModel
    
    init(theController: myMoviesViewController, theModel: myMoviesModel) {
        self.theController = theController
        self.theModel = theModel
    }
    
   
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let endScrolling: Float = Float(scrollView.contentOffset.y + scrollView.frame.size.height)
        if endScrolling >= Float(scrollView.contentSize.height) {
            print("Scroll End Called")
            // fetchMoreEntries()
            if(theController.arydata.count < theController.count){
                theModel.CallMovieList(page: String(describing: theController.arydata.count))
            }
        }
        
    }
    
    /*
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let endScrolling: Float = Float(scrollView.contentOffset.y + scrollView.frame.size.height)
        if endScrolling >= Float(scrollView.contentSize.height) {
            print("Scroll End Called")
           // fetchMoreEntries()
            if(theController.arydata.count < theController.count){
                theModel.CallMovieList(page: String(describing: theController.arydata.count))
            }
        }
    }*/

    
    
}


extension myMoviesManager:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           return theController.header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theController.arydata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:myMoviesCell = tableView.dequeueReusableCell(withIdentifier: "myMoviesCell") as! myMoviesCell
        let shareobj:Result = theController.arydata[indexPath.row]
            cell.loadData(shareobj: shareobj)
        return cell
    }
    
}

extension myMoviesManager:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let shareobj:Result = theController.arydata[indexPath.row]
          theController.performSegue(withIdentifier: "segueMovieDetailPush", sender: shareobj)
        }
}
