//
//  myMoviesViewController.swift
//  MyMovieExam
//
//  Created by Alkesh on 21/08/17.
//  Copyright © 2017 Alkesh. All rights reserved.
//

import UIKit

class myMoviesViewController: ParentViewController {

    var header:UIView!
    var arydata = [Result]()
    var page:Int = 0
    var count:Int!
    // MARK: - Variables | Properties
    fileprivate lazy var theCurrentView: myMoviesView = {
        [unowned self] in
        return self.view as! myMoviesView
        }()
    
    private lazy var theCurrentManager: myMoviesManager = {
        return myMoviesManager(theController: self, theModel: self.theCurrentModel)
    }()
    
    private lazy var theCurrentModel: myMoviesModel = {
        return myMoviesModel(theController:self)
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
        theCurrentView.setTheDelegates(theDelegate: theCurrentManager)
        let theWorkItem: DispatchWorkItem = DispatchWorkItem {
            // self.reloadCollectionViewWithAnimation()
        }
        header = theCurrentView.viewHeader
        addDispatchWorkItem(workItem: theWorkItem, after: 10)
        
        theCurrentModel.CallMovieList(page: String(page))

    }
    
    private func setupLayout() {
        theCurrentView.setupLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ReloadTable() -> Void {
        theCurrentView.tblview.reloadData()
    }

    
    //MARK: - segue handler
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueMovieDetailPush"){
            let destination = segue.destination as! movieDetailViewController
                destination.shareobj = sender as! Result!
        }
    }
    
    
    //MARK: handle spinner
    func startSpinner() -> Void {
        theCurrentView.spinner.startAnimating()
    }

    func stopSpinner() -> Void {
        theCurrentView.spinner.stopAnimating()
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
