//
//  ViewControllerFactory.swift
//  Youtube Sample
//
//  Created by Roman on 10/11/18.
//  Copyright © 2018 SCAND. All rights reserved.
//

import Foundation

class ViewControllerFactory {
    
    static func createVideosSearchViewController() -> UIViewController {
        let controller = VideosSearchViewController.storyboardInstance()
        let presenter = VideoSearchPresenter()
        presenter.view = controller
        controller?.presenter = presenter
        
        return controller!
    }
    
    static func createYouTubePlayerViewController(videoID: String) -> UIViewController {
        let controller = YouTubePlayerViewController.storyboardInstance()
        controller?.videoID = videoID
        
        return controller!
    }
}
