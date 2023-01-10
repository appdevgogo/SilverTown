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
        
        let Storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let VC = Storyboard.instantiateViewController(identifier: "Main") as? MainViewController else { return }
        VC.modalPresentationStyle = .fullScreen // 풀스크린으로 설정
        self.present(VC, animated: false, completion: nil)
        // 뷰가 등장하는 애니메이션 효과인 animated는 false로 설정
        
    }
    
}
