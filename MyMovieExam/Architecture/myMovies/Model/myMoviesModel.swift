//
//  myMoviesModel.swift
//  MyMovieExam
//
//  Created by Alkesh on 21/08/17.
//  Copyright © 2017 Alkesh. All rights reserved.
//

import UIKit


class myMoviesModel: NSObject {
    
    fileprivate unowned var theController: myMoviesViewController
    init(theController: myMoviesViewController) {
        self.theController = theController
    }
    
    func CallMovieList(page:String) -> Void {
        theController.startSpinner()
        var param = [String:String]()
        param["start"] = page
        APIManager.Get(Global.APIURL.guide, params: param, loader: false) { (error:Error?, basicmodel:BasicModel?) in
//            self.theController.arydata = (basicmodel?.results)!
            self.theController.stopSpinner()
            if(error != nil){
                StaticClass.sharedInstance.shownotifications(message: (error?.localizedDescription)!)
                return
            }
            if(basicmodel!.results != nil){
                self.theController.arydata += basicmodel!.results
                self.theController.count = basicmodel?.count
                self.theController.ReloadTable()
            }
        }
        
    }
}

