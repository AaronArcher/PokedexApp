//
//  CustomError.swift
//  PokedexApp
//
//  Created by Aaron Johncock on 29/12/2022.
//

import Foundation

enum CustomError: String, Error {
    
    case generalError = "An error has occured, please close the app and try again!"
    case invalidResponse = "Invalid response from the server, please try again."
    case invalidData = "The data received from the server was invalid, please try again"
    
}
