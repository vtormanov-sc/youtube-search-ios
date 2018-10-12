//
//  YoutubeService.swift
//  Youtube Sample
//
//  Created by Roman on 10/11/18.
//  Copyright © 2018 SCAND. All rights reserved.
//

import Foundation
import Moya

enum YoutubeService {
    case search(forQuery: String)
    case duration(forVideo: String)
    
    private var keyAPI: String {
        return "AIzaSyBqUu1ZaO01dQqb3Z9acmE8rV_2bNQcQsA"
    }
}

extension YoutubeService: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.googleapis.com/youtube/v3")!
    }
    
    var path: String {
        switch self {
        case .search(forQuery: _):
            return "search"
        case .duration(forVideo: _):
            return "videos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search(forQuery: _), .duration(forVideo: _):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .search(let query):
            return .requestParameters(parameters: ["key": keyAPI,
                                                   "type": "video",
                                                   "maxResults": 10,
                                                   "part": "snippet",
                                                   "q": query],
                                      encoding: URLEncoding.default)
        case .duration(let videoID):
            return .requestParameters(parameters: ["key": keyAPI,
                                                   "id": videoID,
                                                   "part": "contentDetails"],
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
