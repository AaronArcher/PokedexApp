//
//  NetworkManager.swift
//  PokedexApp
//
//  Created by Aaron Johncock on 29/12/2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    
    func getPokemon(page: Int) async throws -> PokemonResponse {
        
        var urlString = ""
        
        if page == 1 {
            urlString = "https://pokeapi.co/api/v2/pokemon/?limit=40"
        } else {
            urlString = "https://pokeapi.co/api/v2/pokemon/?limit=40&offset=\(40 * (page - 1))"

        }
        
        guard let url = URL(string: urlString) else {
            throw CustomError.generalError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(PokemonResponse.self, from: data)
        } catch {
            throw CustomError.invalidData
        }
        
    }
    

    func getPokemonDetails(id: Int) async throws -> PokemonDetailResponse {

        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)") else {
            throw CustomError.generalError
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }

        do {
            return try JSONDecoder().decode(PokemonDetailResponse.self, from: data)
        } catch {
            throw CustomError.invalidData
        }

    }
    
    func getPokemonHabitat(id: Int) async throws -> PokemonHabitatResponse {

        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon-habitat/\(id)") else {
            throw CustomError.generalError
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }

        do {
            return try JSONDecoder().decode(PokemonHabitatResponse.self, from: data)
        } catch {
            throw CustomError.invalidData
        }

    }
    
    
}
