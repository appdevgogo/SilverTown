//
//  ImagePopupViewController.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/23.
//

import Foundation
import UIKit


class ImagePopupViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageOrigin: UIImageView!
    @IBOutlet weak var xmarkButton: UIButton!
    
    
    override func viewDidLoad() {
            
        super.viewDidLoad()
    
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 8.0
    
        xmarkButton.titleLabel?.text = ""

    }
            
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
       
        return imageOrigin
    }
    
    @IBAction func xmarkButtonClick(_ sender: Any) {
        
        navigationController?.popViewController(animated: false)
        
    }
}
