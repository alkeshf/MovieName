//
//  ParentViewController.swift
//  ViewChecking
//
//  Created by Bharat Nakum on 2/16/17.
//  Copyright © 2017 Bharat Nakum. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {

    // MARK: - Properties
    private lazy var arrTasks: [DispatchWorkItem] = {
        return []
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.view.backgroundColor = Global.appBGColor
        // Do any additional setup after loading the view.
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle  = .lightContent
    }


    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        for theTask: DispatchWorkItem in arrTasks {
            if !theTask.isCancelled {
                theTask.cancel()
            }
        }
        
        arrTasks.removeAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("\(self) DEALLOCATED")
    }
    
    // MARK: - Status Bar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Other Methods
    func addDispatchWorkItem(workItem: DispatchWorkItem, after: Double) {
        DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + after), execute: workItem)
        arrTasks.append(workItem)
    }
    
    final func removeDispatchWorkItem(workItem: DispatchWorkItem) {
        if !workItem.isCancelled {
            workItem.cancel()
        }
        
        let isContaining = arrTasks.contains(where: { $0 === workItem })
        
        if isContaining {
            let theIndex = arrTasks.index(where: { $0 === workItem })
            arrTasks.remove(at: theIndex!)
        }
    }
}

extension UIViewController {
    func showOKAlert(strMessage: String) {
        let actionOK = UIAlertAction(title: LanguageManager.sharedInstance.getTranslationForKey("OK", value: "OK"), style: .default) { (theAction) in
        
        }
        
        let theAlertController = UIAlertController(title: "", message: strMessage, preferredStyle: .alert)
        theAlertController.addAction(actionOK)
        
        self.present(theAlertController, animated: true, completion: nil)
    }
}
