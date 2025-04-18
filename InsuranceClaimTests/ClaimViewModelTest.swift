//
//  ClaimViewModelTest.swift
//  InsuranceClaim
//
//  Created by Lingga Kusuma Sakti on 18/04/25.
//

import XCTest
@testable import InsuranceClaim

final class ClaimViewModelTest: XCTestCase {
    
    // MARK: - Mock Services
    
    class MockSuccessService: ClaimServiceProtocol {
        func fetchClaims() async throws -> [Claim] {
            return [
                Claim(userId: 1, id: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderi", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"),
                Claim(userId: 2, id: 2, title: "qui est esse", body: "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla")
            ]
        }
    }
    
    class MockFailureService: ClaimServiceProtocol {
        struct DummyError: Error {}
        func fetchClaims() async throws -> [Claim] {
            throw DummyError()
        }
    }
    
    // MARK: - Tests
    
    @MainActor func testFetchClaimsSuccess() async {
        let viewModel = ClaimViewModel(service: MockSuccessService())
        
        await viewModel.fetchClaims()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.claims.count, 2)
        XCTAssertFalse(viewModel.showErrorAlert)
    }
    
    @MainActor func testFetchClaimsFailure() async {
        let viewModel = ClaimViewModel(service: MockFailureService())
        
        await viewModel.fetchClaims()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertFalse(viewModel.errorMessage.isEmpty)
        XCTAssertEqual(viewModel.claims.count, 0)
    }
    
    @MainActor func testFilteredClaims() {
        let viewModel = ClaimViewModel(service: MockSuccessService())
        viewModel.claims = [
            Claim(userId: 1, id: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderi", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"),
            Claim(userId: 2, id: 2, title: "qui est esse", body: "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla")
        ]
        
        viewModel.searchText = "sunt"
        XCTAssertEqual(viewModel.filteredClaims.count, 1)
        XCTAssertEqual(viewModel.filteredClaims.first?.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderi")
        
        viewModel.searchText = "qui"
        XCTAssertEqual(viewModel.filteredClaims.count, 1)
        XCTAssertEqual(viewModel.filteredClaims.first?.title, "qui est esse")
        
        viewModel.searchText = ""
        XCTAssertEqual(viewModel.filteredClaims.count, 2)
    }
}
