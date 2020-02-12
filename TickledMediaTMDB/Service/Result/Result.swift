//
//  Result.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/12/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

/*
 - While making an api call the result can be either success or failure which can be handled using below enum cases
 - Each case takes an generic argument since each case can have different response
*/
enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
