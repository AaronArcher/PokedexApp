//
//  PokemonDetailResponse.swift
//  PokedexApp
//
//  Created by Aaron Johncock on 30/12/2022.
//

import Foundation

struct PokemonDetailResponse: Codable {
    let id: Int
    let name: String
    let types: [PokemonTypeResponse]
}

struct PokemonTypeResponse: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
    let url: String
}


