//
//  RequestFactory.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/12/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import Foundation

/*
 - We are making this class as final since we want to prevent this class to be subclassed
 - Marking class as final also tells swift compiler that method should be called directly (static dispatch) instead of the dynamic dispatch.
 - Bcoz of the static dispatch it will reduce the function call overhead and gives you extra performance
*/
final class RequestFactory {
    
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }
    
    //Get request method
    static func request(method: Method, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
