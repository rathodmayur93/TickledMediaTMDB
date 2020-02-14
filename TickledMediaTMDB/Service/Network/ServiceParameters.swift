//
//  ServiceParameters.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/15/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import Foundation

final class ServiceParameters{
    
    static func movieListParams(currentPage : Int) -> [String : String]{
        return ["api_key" : Constants.apiKey, "page" : "\(currentPage)"]
    }
    
    static func movieDetailParams() -> [String : String]{
        return ["api_key" : Constants.apiKey]
    }
}
