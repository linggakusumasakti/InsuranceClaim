//
//  ClaimServiceTest.swift
//  InsuranceClaim
//
//  Created by Lingga Kusuma Sakti on 18/04/25.
//
import XCTest
@testable import InsuranceClaim

final class ClaimServiceTest: XCTestCase {
    func testFetchClaimsReturnsData() async throws {
        let service = ClaimService()
        let claims = try await service.fetchClaims()
        XCTAssertFalse(claims.isEmpty, "Claims should not be empty")
    }
}
