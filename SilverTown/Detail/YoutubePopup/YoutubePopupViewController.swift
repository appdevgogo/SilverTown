//
//  YoutubePopupViewController.swift
//  SilverTown
//
//  Created by yyjweber on 2023/01/24.
//

import Foundation
import UIKit
import WebKit


class YoutubePopupViewController: UIViewController{
    
    @IBOutlet weak var youtubeWebView: WKWebView!
    @IBOutlet weak var xmarkButton: UIButton!
    
    var youtubeID: String!
    
    override func viewDidLoad() {
        
        xmarkButton.titleLabel?.text = ""
        playYoutube(id: youtubeID)
            
        super.viewDidLoad()

    }
    
    func playYoutube(id: String){
        guard let url = URL(string: "https://www.youtube.com/embed/\(id)") else { return  }
        youtubeWebView.load(URLRequest(url: url))
    }
            
    @IBAction func xmarkButtonClick(_ sender: Any) {
        
        navigationController?.popViewController(animated: false)
        
    }
}
