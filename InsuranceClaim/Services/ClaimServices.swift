//
//  ClaimServices.swift
//  InsuranceClaim
//
//  Created by Lingga Kusuma Sakti on 18/04/25.
//

import Foundation
import Alamofire

protocol ClaimServiceProtocol {
    func fetchClaims() async throws -> [Claim]
}

class ClaimService: ClaimServiceProtocol {
    func fetchClaims() async throws -> [Claim] {
        let url = "https://jsonplaceholder.typicode.com/posts"

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url)
                .validate()
                .responseDecodable(of: [Claim].self) { response in
                    switch response.result {
                    case .success(let claims):
                        continuation.resume(returning: claims)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
