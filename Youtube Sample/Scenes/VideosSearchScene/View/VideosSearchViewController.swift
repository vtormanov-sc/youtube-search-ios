//
//  VideosSearhViewController.swift
//  Youtube Sample
//
//  Created by Roman on 10/11/18.
//  Copyright © 2018 SCAND. All rights reserved.
//

import UIKit

struct VideoData {
    var title = ""
    var thumbnail: UIImage
    var duration = ""
}

class VideosSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, VideoSearchViewProtocol {
    
    var presenter: VideoSearchPresenterProtocol?
    var videoDataList: [VideoData] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - VideoSearchViewProtocol
    
    func showVideoData(videoData: [VideoData]) {
        videoDataList = videoData
        tableView.reloadData()
    }
    
    func showYoutubePlayer(controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoDataCell", for: indexPath)
        
        let videoData = videoDataList[indexPath.row]
        cell.imageView?.image = videoData.thumbnail
        cell.textLabel?.text = videoData.title
        cell.detailTextLabel?.text = "Video duration - \(videoData.duration)"
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showVideo(withIndex: indexPath.row)
    }

    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            presenter?.searchVideos(forQuery: searchText)
        }
        
        searchBar.resignFirstResponder()
    }

}
