//
//  File.swift
//  Youtube Sample
//
//  Created by Roman on 10/11/18.
//  Copyright © 2018 SCAND. All rights reserved.
//

import Foundation

protocol VideoSearchPresenterProtocol: AnyObject {
    var view: VideoSearchViewProtocol? {get set}
    func searchVideos(forQuery query: String)
    func showVideo(withIndex index: Int)
}

protocol VideoSearchViewProtocol: AnyObject {
    var presenter: VideoSearchPresenterProtocol? {get set}
    func showVideoData(videoData: [VideoData])
    func showYoutubePlayer(controller: UIViewController)
}
