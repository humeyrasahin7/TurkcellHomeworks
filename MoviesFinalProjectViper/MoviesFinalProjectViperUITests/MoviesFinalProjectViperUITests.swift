
//
//  MoviesFinalProjectViperUITests.swift
//  MoviesFinalProjectViperUITests
//
//  Created by Hümeyra Şahin on 24.04.2022.
//

import XCTest

class MoviesFinalProjectViperUITests: XCTestCase {
    
    
    let app = XCUIApplication()

    func test_GoToDetail(){
        app.launch()
        app/*@START_MENU_TOKEN@*/.collectionViews.containing(.other, identifier:"Vertical scroll bar, 8 pages")/*[[".collectionViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\")",".collectionViews.containing(.other, identifier:\"Vertical scroll bar, 8 pages\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        app.navigationBars["The Outfit"].buttons["Movies"].tap()
        
    }

    func test_SearchBar(){
        
        app.launch()
        let moviesNavigationBar = app.navigationBars["Movies"]
        let cancelButton = moviesNavigationBar.buttons["Cancel"]
        let searchAMovieSearchField = moviesNavigationBar.searchFields["Search a Movie"]
        
        searchAMovieSearchField.tap()
        
        let tKey = app/*@START_MENU_TOKEN@*/.keys["T"]/*[[".keyboards.keys[\"T\"]",".keys[\"T\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        
        let hKey = app/*@START_MENU_TOKEN@*/.keys["h"]/*[[".keyboards.keys[\"h\"]",".keys[\"h\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()

        searchAMovieSearchField.buttons["Clear text"].tap()
    
        searchAMovieSearchField.tap()
        
        tKey.tap()
        hKey.tap()
        eKey.tap()
        
        app/*@START_MENU_TOKEN@*/.tables["Search results"]/*[[".otherElements[\"Double-tap to dismiss\"].tables[\"Search results\"]",".tables[\"Search results\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"The Batman (2022)").element.tap()
        app.navigationBars["The Batman"].buttons["Movies"].tap()
        cancelButton.tap()
    }

    func test_FavButton(){
        app.launch()
        app/*@START_MENU_TOKEN@*/.collectionViews.containing(.other, identifier:"Vertical scroll bar, 8 pages")/*[[".collectionViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\")",".collectionViews.containing(.other, identifier:\"Vertical scroll bar, 8 pages\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        let loveButton = app.buttons["love"]
        loveButton.tap()
        app.waitForExistence(timeout: 1)
        loveButton.tap()
        app.navigationBars["The Outfit"].buttons["Movies"].tap()
        
                   
    }

}
