//
//  movieDetailViewController.swift
//  MyMovieExam
//
//  Created by Alkesh on 21/08/17.
//  Copyright © 2017 Alkesh. All rights reserved.
//

import UIKit

class movieDetailViewController: ParentViewController {

    internal var shareobj:Result!
    
    // MARK: - Variables | Properties
    fileprivate lazy var theCurrentView: movieDetailView = {
        [unowned self] in
        return self.view as! movieDetailView
        }()
    
    private lazy var theCurrentManager: movieDetailManager = {
        return movieDetailManager(theController: self, theModel: self.theCurrentModel)
    }()
    
    private lazy var theCurrentModel: movieDetailModel = {
        return movieDetailModel()
    }()
 
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupManager()
        // Do any additional setup after loading the view.
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }


    private func setupManager() {
        setupLayout()
      //  theCurrentView.setTheDelegates(theDelegate: theCurrentManager)
        self.title = shareobj.name
        theCurrentView.loadData(shareobj: shareobj)
        let theWorkItem: DispatchWorkItem = DispatchWorkItem {
            // self.reloadCollectionViewWithAnimation()
        }
        
        addDispatchWorkItem(workItem: theWorkItem, after: 10)
    }
    
    private func setupLayout() {
        theCurrentView.setupLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
