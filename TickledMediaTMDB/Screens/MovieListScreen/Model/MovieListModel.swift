//
//  MovieListModel.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/14/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import Foundation

// MARK: - MovieList
//Generated this model class using the https://app.quicktype.io/
struct MovieListModel: Codable {
    let page: Int? = 0
    var results: [MovieResult]? = [MovieResult]()
    let totalPages : Int? = 0
    let totalResults: Int? = 0

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
