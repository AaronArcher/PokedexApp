//
//  PokemonResponse.swift
//  PokedexApp
//
//  Created by Aaron Johncock on 23/12/2022.
//

import Foundation
 
struct PokemonResponse: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
}
