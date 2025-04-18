//
//  ClaimListView.swift
//  InsuranceClaim
//
//  Created by Lingga Kusuma Sakti on 18/04/25.
//

import SwiftUI

struct ClaimListView: View {
    @StateObject private var viewModel = ClaimViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    List(viewModel.filteredClaims) { claim in
                        NavigationLink(destination: ClaimDetailView(claim: claim)) {
                            VStack(alignment: .leading) {
                                Text(claim.title)
                                    .fontWeight(.bold)
                                Text(claim.body)
                                    .lineLimit(2)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text("Claim ID: \(claim.id), Claimant ID: \(claim.userId)")
                                    .font(.caption)
                            }
                        }
                    }
                    .searchable(text: $viewModel.searchText)
                }
            }
            .navigationTitle("Insurance Claims")
            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .task {
                if viewModel.claims.isEmpty {
                    await viewModel.fetchClaims()
                }
            }
        }
    }
}
