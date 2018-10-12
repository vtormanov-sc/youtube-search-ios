//
//  VideoSearchPresenter.swift
//  Youtube Sample
//
//  Created by Roman on 10/11/18.
//  Copyright © 2018 SCAND. All rights reserved.
//

import Foundation
import Moya

class VideoSearchPresenter: VideoSearchPresenterProtocol {
    
    var videoList: [Video] = []
    var view: VideoSearchViewProtocol?
    
    // MARK: - VideoSearchPresenterProtocol
    
    func searchVideos(forQuery query: String) {
        videoList.removeAll()
        view?.showVideoData(videoData: [])
        
        let provider = MoyaProvider<YoutubeService>()
        provider.request(.search(forQuery: query)) { (result) in
            switch result {
            case let .success(moyaResponse):
                let decoder = JSONDecoder()
                if let searchResponse = try? decoder.decode(VideoSearchResponse.self, from: moyaResponse.data) {
                    self.parseVideos(fromResponse: searchResponse)
                }

            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func showVideo(withIndex index: Int) {
        let videoID = videoList[index].id
        let controller = ViewControllerFactory.createYouTubePlayerViewController(videoID: videoID)
        
        view?.showYoutubePlayer(controller: controller)
    }
    
    // MARK: - Private methods
    
    private func parseVideos(fromResponse response: VideoSearchResponse) {
        let provider = MoyaProvider<YoutubeService>()
        
        let videosParsingGroup = DispatchGroup()

        for item in response.items {
            videosParsingGroup.enter()
            provider.request(.duration(forVideo: item.id.videoId)) { (result) in
                switch result {
                case let .success(moyaResponse):
                    let decoder = JSONDecoder()
                    if let videoDetails = try? decoder.decode(VideoDetailsResponse.self, from: moyaResponse.data) {
                        if let duration = videoDetails.items.first?.contentDetails.duration {
                            let video = Video()
                            video.title = item.snippet.title
                            video.id = item.id.videoId
                            video.duration = duration
                            video.thumbnailURL = item.snippet.thumbnails["default"]?.url ?? ""
                            
                            self.videoList.append(video)
                        }
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
                videosParsingGroup.leave()
            }
        }
        
        videosParsingGroup.notify(queue: DispatchQueue.main) {
            self.showVideoData()
        }
    }
    
    private func showVideoData() {
        var videoDataList: [VideoData] = []
        for video in videoList {
            guard let url = URL(string: video.thumbnailURL),
                let imageData = try? Data(contentsOf: url),
                let image = UIImage(data: imageData) else {
                continue
            }
            
            let duration = video.duration.replacingOccurrences(of: "PT", with: "")
                .replacingOccurrences(of: "M", with: ":")
                .replacingOccurrences(of: "S", with: "")
    
            let videoData = VideoData(title: video.title,
                                      thumbnail: image,
                                      duration: duration)
            videoDataList.append(videoData)
        }
        
        view?.showVideoData(videoData: videoDataList)
    }
}
