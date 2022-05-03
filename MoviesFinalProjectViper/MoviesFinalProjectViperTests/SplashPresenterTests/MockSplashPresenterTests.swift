//
//  MockSplashPresenterTests.swift
//  MoviesFinalProjectViperTests
//
//  Created by Hümeyra Şahin on 3.05.2022.
//

import XCTest
@testable import MoviesFinalProjectViper

final class MockSplashPresenterTests: XCTestCase {

    var presenter: SplashPresenter!
    var view: MockSplashViewController!
    var interactor: MockSplashInteractor!
    var router: MockSplashRouter!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, router: router, interactor: interactor)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
        presenter = nil
        interactor = nil
        router = nil
    }

    func test_ViewDidAppear(){
        XCTAssertFalse(interactor.invokedInternetStatus,"Değeriniz true, oysa siz false olmasını bekliyorsunuz" )
        presenter.viewDidAppear()
        XCTAssertTrue(interactor.invokedInternetStatus,"Değeriniz false, oysa siz true olmasını bekliyorsunuz")
    }
    
    func test_CheckInternetConnection(){
        XCTAssertFalse(view.isNoInternetInvoked, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        view.noInternetConnection()
        XCTAssertTrue(view.isNoInternetInvoked,"Değeriniz false, oysa siz true olmasını bekliyorsunuz")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
