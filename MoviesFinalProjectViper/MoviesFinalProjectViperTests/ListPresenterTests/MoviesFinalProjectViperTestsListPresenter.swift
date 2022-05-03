//
//  MoviesFinalProjectViperTests.swift
//  MoviesFinalProjectViperTests
//
//  Created by Hümeyra Şahin on 24.04.2022.
//

import XCTest
@testable import MoviesFinalProjectViper

class MoviesFinalProjectViperTestsListPresenter: XCTestCase {
    
    var presenter: ListPresenter!
    var view: MockListViewController!
    var interactor: MockListInteractor!
    var router: MockListRouter!

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

    func test_ListViewDidLoad_InvokesRequiredViewMethods(){

        XCTAssertFalse(view.isInvokedSetupCollectionView, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        XCTAssertFalse(view.isInvokedSetupPageController, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        presenter.viewDidLoad()
        XCTAssertTrue(view.isInvokedSetupCollectionView, "Değeriniz false, oysa siz true olmasını bekliyorsunuz")
        XCTAssertTrue(view.isInvokedSetupPageController, "Değeriniz false, oysa siz true olmasını bekliyorsunuz")
       
    }

    func test_fetchUpcomingMovies(){
        XCTAssertFalse(view.isInvokedReloadData, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        XCTAssertNil(presenter.movieUpcoming(_:0)?.title, "film dolu geldi gelmemeli")
        XCTAssertEqual(presenter.numberOfItemsUC(), 0)
        presenter.fetchUpcomingMoviesOutput(result: .success(UpcomingResult.response))
        XCTAssertTrue(view.isInvokedReloadData, "Değeriniz false, oysa siz true olmasını bekliyorsunuz")
        XCTAssertEqual(presenter.movieUpcoming(_:0)!.title, "Moonfall")
        XCTAssertEqual(presenter.numberOfItemsUC(), 20)
    }
    
    func test_fetchNowPlayingMovies(){
        XCTAssertFalse(view.isInvokedReloadData, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        XCTAssertNil(presenter.movieNowPlaying(_:0)?.title, "film dolu geldi gelmemeli")
        XCTAssertEqual(presenter.numberOfItemsNP(), 0)
        presenter.fetchNowPlayingMoviesOutput(result: .success(NowPlayingResult.responseNP))
        XCTAssertTrue(view.isInvokedReloadData, "Değeriniz false, oysa siz true olmasını bekliyorsunuz")
        XCTAssertEqual(presenter.movieNowPlaying(_:0)!.title, "Moonfall")
        XCTAssertEqual(presenter.numberOfItemsNP(), 20)
    }
    
    func test_IsRouting(){
        XCTAssertFalse(router.isNavigateToDetailInvoked, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        presenter.router.navigate(.searching)
        XCTAssertTrue(router.isNavigateToDetailInvoked, "Değeriniz false, oysa siz true olmasını bekliyorsunuz")
    }
    
    func test_DidSelectItemAt(){
        XCTAssertFalse(router.isInvokedDidSelectItemAt, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        presenter.didSelectItemAt(index: 0, clicked: ClickedCollectionView.nowplaying)
        presenter.router.navigate(.detail(movieID: 0))
        XCTAssertTrue(router.isInvokedDidSelectItemAt, "Değeriniz false, oysa siz true olmasını bekliyorsunuz")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension UpcomingResult{
    static var response: UpcomingResponse{
        let bundle = Bundle(for: MoviesFinalProjectViperTestsListPresenter.self)
        let path = bundle.path(forResource: "Movies", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(UpcomingResponse.self, from: data)
        return movieResponse
    }
}

extension NowPlayingResult{
    static var responseNP: NowPlayingResponse{
        let bundle = Bundle(for: MoviesFinalProjectViperTestsListPresenter.self)
        let path = bundle.path(forResource: "Movies", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(NowPlayingResponse.self, from: data)
        return movieResponse
    }
}
