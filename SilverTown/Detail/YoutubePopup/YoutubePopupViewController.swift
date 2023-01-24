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
    var youtubeID: String!
    
    override func viewDidLoad() {
        
        addBackButton("arrow.backward", .white)
        playYoutube(id: "mbZ_t2-uZvA")
            
        super.viewDidLoad()

    }
    
    func playYoutube(id: String){
        guard let url = URL(string: "https://www.youtube.com/embed/\(id)") else { return  }
        youtubeWebView.load(URLRequest(url: url))
    }
            
}
