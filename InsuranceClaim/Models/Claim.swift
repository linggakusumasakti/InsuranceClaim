//
//  Claim.swift
//  InsuranceClaim
//
//  Created by Lingga Kusuma Sakti on 18/04/25.
//

struct Claim: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
