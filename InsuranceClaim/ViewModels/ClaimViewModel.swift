//
//  ClaimViewModel.swift
//  InsuranceClaim
//
//  Created by Lingga Kusuma Sakti on 18/04/25.
//

import Foundation

@MainActor
class ClaimViewModel: ObservableObject {
    @Published var claims: [Claim] = []
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""

    private let service: ClaimServiceProtocol

    var filteredClaims: [Claim] {
        if searchText.isEmpty {
            return claims
        } else {
            return claims.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }

    init(service: ClaimServiceProtocol = ClaimService()) {
        self.service = service
    }

    func fetchClaims() async {
        isLoading = true
        do {
            claims = try await service.fetchClaims()
        } catch {
            self.errorMessage = error.localizedDescription
            self.showErrorAlert = true
        }
        isLoading = false
    }
}
