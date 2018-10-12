//
//  ContentDetails.swift
//  Youtube Sample
//
//  Created by Roman on 10/11/18.
//  Copyright © 2018 SCAND. All rights reserved.
//

import Foundation

struct VideoDetailsResponse: Decodable {
    var kind: String
    var items: [VideoDetailsResultItem]
}

struct VideoDetailsResultItem: Decodable {
    var contentDetails: VideoDetails
}

struct VideoDetails: Decodable {
    var duration: String
}
