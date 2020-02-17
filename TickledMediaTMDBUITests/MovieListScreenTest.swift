//
//  MovieListScreenTest.swift
//  TickledMediaTMDBUITests
//
//  Created by ds-mayur on 2/16/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import XCTest
@testable import TickledMediaTMDB

class MovieListScreenTest : XCTestCase {
    
    func testCollectionViewInteraction() {
        
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Assert that we are displaying the tableview
        let movieCollectionView = app.collectionViews["collection--movieListCollectionView"]
        
        XCTAssertTrue(movieCollectionView.exists, "The movie collectionView exists")
    }
    
    func testTableViewCellInteraction(){
        
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Assert that we are displaying the tableview
        let movieCollectionView = app.collectionViews["collection--movieListCollectionView"]
        
        XCTAssertTrue(movieCollectionView.exists, "The movie collectionView exists")
        
        // Get an array of cells
        let collectionCell = movieCollectionView.cells
        
        if collectionCell.count > 0 {
            let count: Int = (collectionCell.count - 1)
            
            let promise = expectation(description: "Wait for collectionView cells")
            
            //loop throught the each cell
            for i in stride(from: 0, to: count , by: 1) {
                
                // Grab the first cell and verify that it exists and tap it
                let collectionCell = collectionCell.element(boundBy: i)
                XCTAssertTrue(collectionCell.exists, "The \(i) cell is in place on the collectionView")
                
                // this actually take us to the next screen
                collectionCell.tap()
                
                if i == (count - 1) {
                    promise.fulfill()
                }
                
                // Back
                app.swipeDown()
            }
            
            waitForExpectations(timeout: 20, handler: nil)
            XCTAssertTrue(true, "Finished validating the collectionView cells")
            
        } else {
            XCTAssert(false, "Was not able to find any collectionView cells")
        }
    }
}
