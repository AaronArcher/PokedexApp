//
//  Extensions.swift
//  PokedexApp
//
//  Created by Aaron Johncock on 29/12/2022.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
}
