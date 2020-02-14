//
//  ErrorResult.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/12/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

/*
    - Whenever we face any issues while making an api call or in api response one of the following enum cases will be return as an error
*/
enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
