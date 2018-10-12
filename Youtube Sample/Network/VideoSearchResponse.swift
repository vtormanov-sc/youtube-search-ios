//
//  Video.swift
//  Youtube Sample
//
//  Created by Roman on 10/11/18.
//  Copyright © 2018 SCAND. All rights reserved.
//

import Foundation

struct VideoSearchResponse: Decodable {
    var items: [VideoSearchResultItem]
}

struct VideoSearchResultItem: Decodable {
    var id: RawID
    var snippet: ItemSnippet
}

struct RawID: Decodable {
    var videoId: String
}

struct ItemSnippet: Decodable {
    var thumbnails: [String: Thumbnail]
    var title: String
}

struct Thumbnail: Decodable {
    var url: String
    var width: Int
    var height: Int
}
