//
//  PokemonDetailViewController.swift
//  PokedexApp
//
//  Created by Aaron Johncock on 03/01/2023.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    
    
    private var pokemonName: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var pokemonNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var pokemonTypeTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var pokemonTypes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var imageSection: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var pokemonImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var imageBackground: UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.backgroundColor = .systemPink.withAlphaComponent(0.5)
        return circle
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(imageSection)
        imageSection.addSubview(imageBackground)
        imageSection.addSubview(pokemonImage)
        
        
        setConstraints()
        imageBackground.layer.cornerRadius = (view.frame.width - 20) / 2.6
        
        
    }
    
    func configure(name: String, number: Int) {
        let formattedPokemonNumber = String(format: "%03d", number)
        getImage(number: formattedPokemonNumber)
        getDetails(number: number)
    }
        
    private func setConstraints() {
        
        let imageSectionHeight = view.frame.width - 20
        
        NSLayoutConstraint.activate([
        
            imageSection.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            imageSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageSection.heightAnchor.constraint(lessThanOrEqualToConstant: imageSectionHeight),
            
            imageBackground.centerXAnchor.constraint(equalTo: imageSection.centerXAnchor),
            imageBackground.centerYAnchor.constraint(equalTo: imageSection.centerYAnchor),
            imageBackground.heightAnchor.constraint(equalToConstant: imageSectionHeight / 1.3),
            imageBackground.widthAnchor.constraint(equalToConstant: imageSectionHeight / 1.3),
            
            pokemonImage.topAnchor.constraint(equalTo: imageSection.topAnchor, constant: 10),
            pokemonImage.leadingAnchor.constraint(equalTo: imageSection.leadingAnchor, constant: 10),
            pokemonImage.trailingAnchor.constraint(equalTo: imageSection.trailingAnchor, constant: -10),
            pokemonImage.bottomAnchor.constraint(equalTo: imageSection.bottomAnchor, constant: -10),
            
            
        ])
    }
    
    func getImage(number: String) {
        let imageString = "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(number).png"
        
        Task {
            let image = await ImageCache.shared.downloadImage(from: imageString)
            pokemonImage.image = image
        }
    }
    
    func getDetails(number: Int) {
        Task {
            do {
                let details = try await NetworkManager.shared.getPokemonDetails(id: number)
                
                var types: [String] = []
                
                for type in details.types {
                    types.append(type.type.name.capitalizingFirstLetter())
                }
                let joinedTypes = types.joined(separator: ", ")
//                pokemonTypes.text = joinedTypes
                
                imageBackground.backgroundColor = UIHelper.setCellBackgroundColor(types: joinedTypes)
                
            } catch {
                print(error)
            }
        }
    }



}
