//
//  DetailPresenterTests.swift
//  MoviesFinalProjectViperTests
//
//  Created by Hümeyra Şahin on 3.05.2022.
//

import XCTest
@testable import MoviesFinalProjectViper


final class DetailPresenterTests: XCTestCase {
    
    var presenter: DetailPresenter!
    var view: MockDetailViewController!
    var interactor: MockDetailInteractor!
    var router: MockDetailRouter!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, router: router, interactor: interactor, movieID: 550)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
        presenter = nil
        interactor = nil
        router = nil
    }
    
    func test_DetailViewDidLoad_InvokesRequiredViewMethods(){
        XCTAssertFalse(view.isInvokedSetupCollectionView, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        presenter.viewDidLoad()
        XCTAssertTrue(view.isInvokedSetupCollectionView, "Değeriniz false, oysa siz true olmasını bekliyorsunuz")
    }
    
    func test_FetchMovieDetails(){
        XCTAssertFalse(view.isInvokedAddTappGestureRecog, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        presenter.fetchDetailOutput(result: .success(DetailResult.response))
        XCTAssertTrue(view.isInvokedAddTappGestureRecog, "Değeriniz false, oysa siz true olmasını bekliyorsunuz")
    }
    
    func test_FetchSimilarMovies(){
        XCTAssertFalse(view.isInvokedReloadData, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        presenter.fetchSimilarMoviesOutput(result: .success(SimilarMoviesResult.response))
        XCTAssertTrue(view.isInvokedReloadData, "Değeriniz false, oysa siz true olmasını bekliyorsunuz")
    }
    
    func test_IsRouting(){
        XCTAssertFalse(router.isNavigateToSimilarDetailsInvoked, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        presenter.router.navigate(.toDetail(movieID: 550))
        XCTAssertTrue(router.isNavigateToSimilarDetailsInvoked, "Değeriniz false, oysa siz true olmasını bekliyorsunuz")
    }
    
    func test_DidSelectItemAt(){
        XCTAssertFalse(router.isInvokedDidSelectItemAt,"Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        presenter.didSelectItemAt(index: 0)
        presenter.router.navigate(.toDetail(movieID: 550))
        XCTAssertTrue(router.isInvokedDidSelectItemAt, "Değeriniz false, oysa siz true olmasını bekliyorsunuz")
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


extension DetailResult{
    static var response: DetailResponse{
        let bundle = Bundle(for: MoviesFinalProjectViperTestsListPresenter.self)
        let path = bundle.path(forResource: "Detail", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(DetailResponse.self, from: data)
        return movieResponse
    }
}

extension SimilarMoviesResult{
    static var response: SimilarMoviesResponse{
        let bundle = Bundle(for: MoviesFinalProjectViperTestsListPresenter.self)
        let path = bundle.path(forResource: "Movies", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(SimilarMoviesResponse.self, from: data)
        return movieResponse
    }
}
