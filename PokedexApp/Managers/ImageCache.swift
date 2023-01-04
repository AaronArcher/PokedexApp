//
//  ImageCache.swift
//  PokedexApp
//
//  Created by Aaron Johncock on 29/12/2022.
//

import UIKit

class ImageCache {
    
    static let shared = ImageCache()
    let cache = NSCache<NSString, UIImage>()
    
    
    private init() {
        
    }
    
    
    func downloadImage(pokemonNumber: String) async -> UIImage? {
        let imageString = "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(pokemonNumber).png"
        
        let cacheKey = NSString(string: imageString)
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: imageString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
        
    }

}
