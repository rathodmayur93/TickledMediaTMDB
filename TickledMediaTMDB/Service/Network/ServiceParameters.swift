//
//  ServiceParameters.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/15/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import Foundation

final class ServiceParameters{
    
    //Request paramters while fetching the movie list
    static func movieListParams(currentPage : Int) -> [String : String]{
        return ["api_key" : Constants.apiKey, "page" : "\(currentPage)"]
    }
    
    //Request parameters while fetching the movie detail
    static func movieDetailParams() -> [String : String]{
        return ["api_key" : Constants.apiKey]
    }
}
