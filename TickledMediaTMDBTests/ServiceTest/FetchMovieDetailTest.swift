//
//  FetchMovieDetailTest.swift
//  TickledMediaTMDBTests
//
//  Created by ds-mayur on 2/16/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import XCTest
@testable import TickledMediaTMDB

class FetchMovieDetailTest : XCTestCase{
    
    func testMovieDetailService(){
        // giving a "previous" session
        FetchMovieDetailService.shared.fethcMovieDetail(movieId: 1, parameter: ServiceParameters.movieDetailParams()) { (_) in
            //Ignore api call
        }
        
        // Expected to task nil after cancel
        FetchMovieDetailService.shared.cancelFetchMovieDetail()
        XCTAssertNil(FetchMovieDetailService.shared.task, "Expected task nil")
    }
}
