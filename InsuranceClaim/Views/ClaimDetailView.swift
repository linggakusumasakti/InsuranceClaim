//
//  ClaimDetailView.swift
//  InsuranceClaim
//
//  Created by Lingga Kusuma Sakti on 18/04/25.
//

import SwiftUI

struct ClaimDetailView: View {
    let claim: Claim

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(claim.title)
                .font(.title2)
                .bold()
            Text(claim.body)
                .font(.body)
            Spacer()
        }
        .padding()
        .navigationTitle("Claim Details")
    }
}
