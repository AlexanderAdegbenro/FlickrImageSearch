//
//  ImageSearchViewModelTests.swift
//  Flickr_CVSTests
//
//  Created by Alexander Adegbenro on 7/3/24.
//

import XCTest
import Combine
@testable import Flickr_CVS

class ImageSearchViewModelTests: XCTestCase {
    var viewModel: ImageSearchViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = ImageSearchViewModel(apiService: MockFlickrAPIService.self)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertTrue(viewModel.images.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.searchText, "")
    }

    func testSearchImagesSuccess() {
        // Given
        let imagesExpectation = XCTestExpectation(description: "Fetch images successfully")
        let loadingExpectation = XCTestExpectation(description: "Loading state updated correctly")
        MockFlickrAPIService.mockImages = [
            ImageModel(title: "Sample Image 1", description: "Description 1", author: "Author 1", published: Date(), imageURL: URL(string: "https://via.placeholder.com/150")!),
            ImageModel(title: "Sample Image 2", description: "Description 2", author: "Author 2", published: Date(), imageURL: URL(string: "https://via.placeholder.com/150")!)
        ]
        MockFlickrAPIService.shouldReturnError = false

        // When
        viewModel.$images
            .dropFirst()
            .sink { images in
                XCTAssertEqual(images.count, 2)
                imagesExpectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.$isLoading
            .dropFirst(2) // Expecting the first change and then the final change
            .sink { isLoading in
                XCTAssertFalse(isLoading)
                loadingExpectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.searchText = "sample"

        wait(for: [imagesExpectation, loadingExpectation], timeout: 1.0)
    }

    func testSearchImagesFailure() {
        // Given
        let loadingExpectation = XCTestExpectation(description: "Fetch images with error")
        MockFlickrAPIService.shouldReturnError = true

        // When
        viewModel.$isLoading
            .dropFirst(2) // Expecting the first change and then the final change
            .sink { isLoading in
                XCTAssertFalse(isLoading)
                loadingExpectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.searchText = "sample"

        wait(for: [loadingExpectation], timeout: 1.0)
    }

    func testEmptySearchTextDoesNotFetchImages() {
        // Given
        let expectation = XCTestExpectation(description: "No fetch for empty search text")
        expectation.isInverted = true // This expectation should not be fulfilled

        MockFlickrAPIService.mockImages = []
        MockFlickrAPIService.shouldReturnError = false

        viewModel.$images
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // When
        viewModel.searchText = ""

        // Then
        wait(for: [expectation], timeout: 1.0)
    }
}
