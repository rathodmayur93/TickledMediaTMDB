//
//  MoveListModelTest.swift
//  TickledMediaTMDBTests
//
//  Created by ds-mayur on 2/16/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import XCTest
@testable import TickledMediaTMDB

class MovieListModelTest : XCTestCase{
    
    func testEmptyMovieList(){
        
        // giving completion after parsing
        // expected valid converter with valid data
        let _ : ((Result<MovieListModel, ErrorResult>) -> Void) = { result in
            switch result {
            case .success(_):
                XCTAssert(false, "Expected failure when no data")
            default:
                break
            }
        }
    }
    
    func testParseMovieList(){
        
        // giving a sample json file
        guard let data = Utility.readJson(fileName: "movie") else {
            XCTAssert(false, "Can't get data from movie.json")
            return
        }
        
        // giving completion after parsing
        // expected valid contact model with valid data
        let completion : ((Result<MovieListModel, ErrorResult>) -> Void) = { result in
            switch result {
            case .failure(_):
                XCTAssert(false, "Expected valid contact")
            case .success(let converter):
                XCTAssertEqual(converter.results?[0].title ?? "", "Frozen II", "Expected Movie Name")
                XCTAssertEqual(converter.results?[0].voteCount ?? 0, 2272, "Expected Vote Count")
                XCTAssertEqual(converter.results?[0].releaseDate, "2019-11-20", "Expected Movie Release Date")
                XCTAssertEqual(converter.results?[0].adult ?? true, false, "Expected Movie is adult")
                XCTAssertEqual(converter.results?[0].posterPath ?? "", "/pjeMs3yqRmFL3giJy4PMXWZTTPa.jpg", "Expected Profile Pic Url")
                break
            }
        }
        
       // let data = RequestHandler().networkResultData(completion: completion)
        
    }
}
