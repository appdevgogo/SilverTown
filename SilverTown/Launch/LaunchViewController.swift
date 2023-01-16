//
//  LaunchScreenViewController.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/08.
//

import UIKit


class LaunchViewController: UIViewController {
    
    @IBOutlet weak var launchSlogan: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chageLauchSlogan()
        
    }
    
    func chageLauchSlogan() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.launchSlogan.fadeTransition(0.4)
            self.launchSlogan.text = "실버타운 종합정보앱"
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.showMainView()
            
        }
        
    }
    
    func showMainView() {
        
        
        //let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "Main") as! MainViewController
        let nav = UINavigationController(rootViewController: homeViewController)
        UIApplication.shared.windows.first?.rootViewController = nav

        /*
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "Main") as! MainViewController
        UIApplication.shared.windows.first?.rootViewController = controller
        UIApplication.shared.windows.first?.makeKeyAndVisible()*/
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyBoard.instantiateViewController(withIdentifier: "Main") as? MainViewController else {return}
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}
