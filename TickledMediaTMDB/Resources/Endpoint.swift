//
//  Endpoint.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/14/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import Foundation

//API URL Enedpoints
enum Endpoint {
    
    case movieList
    case movieDetail(movieId : Int)
    
    //Path of the API Url
    var path: String {
        
        switch self {
        case .movieList: return Constants.baseUrl + "/trending/movie/week"
        case .movieDetail(let movieId): return Constants.baseUrl + "/movie/\(movieId)"
        }
    }
}
