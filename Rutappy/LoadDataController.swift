//
//  LoadDataController.swift
//  Rutappy
//
//  Created by Miguel Roncallo on 4/10/17.
//  Copyright © 2017 Novus. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class LoadDataController: UIViewController {

    let screenSize: CGRect = UIScreen.main.bounds

    override func viewDidLoad() {
        super.viewDidLoad()

        DataService.sharedInstance.loadData { (error) in
            if let e = error{
                print(e)
            }else{
                //Present map view controller
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Map Controller") as! MapController
//                self.dismiss(animated: false, completion: nil)
//                self.present(vc, animated: true, completion: nil)
                self.dismiss(animated: false, completion: nil)
                self.createMenuView()
            }
        }
        
    }
    
    //Supporting functions
    
    func createMenuView() {
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "Map Controller") as! MapController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "Left Menu VC") as! LeftMenuController
        
        
        let nvc = UINavigationController(rootViewController: mainViewController)
        
        
        SlideMenuOptions.leftViewWidth = screenSize.width*0.75
        
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.delegate = mainViewController
        AppDelegate.getDelegate().window?.rootViewController = slideMenuController
        AppDelegate.getDelegate().window?.makeKeyAndVisible()
    }

}
