//
//  YouTubePlayerViewController.swift
//  Youtube Sample
//
//  Created by Roman on 10/11/18.
//  Copyright © 2018 SCAND. All rights reserved.
//

import UIKit

class YouTubePlayerViewController: UIViewController {

    @IBOutlet weak var playerView: YTPlayerView!
    var videoID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playerView.load(withVideoId: videoID)
    }

}
