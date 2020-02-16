//
//  FetchMovieServiceTest.swift
//  TickledMediaTMDBTests
//
//  Created by ds-mayur on 2/16/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import XCTest
@testable import TickledMediaTMDB

class FetchMovieServiceTest: XCTestCase{
    
    func testCancelRequest(){
        
        // giving a "previous" session
        FetchMoviesService.shared.fetchMovieList(parameter: ServiceParameters.movieListParams(currentPage: 0)) { (_) in
            //Ignore api call
        }
        
        // Expected to task nil after cancel
        FetchMoviesService.shared.cancelFetchMovieList()
        XCTAssertNil(FetchMoviesService.shared.task, "Expected task nil")
    }
}
