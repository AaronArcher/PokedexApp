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
        label.font = UIFont.systemFont(ofSize: 45, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var pokemonNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40, weight: .light)
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
    
    private let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var typeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 50
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var pokemonTypeTitle: UILabel = {
        let label = UILabel()
        label.text = "Type:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var pokemonTypes: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var habitatStackView: UIStackView = {
        let stackView = UIStackView()
//        stackView.spacing = 20
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var pokemonHabitatTitle: UILabel = {
        let label = UILabel()
        label.text = "Habitat:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var pokemonHabitat: UILabel = {
        let label = UILabel()
//        label.text = "Unknown"
        label.font = UIFont.italicSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var regionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var pokemonRegionTitle: UILabel = {
        let label = UILabel()
        label.text = "Region:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var pokemonRegion: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(imageSection)
        imageSection.addSubview(imageBackground)
        imageSection.addSubview(pokemonImage)
        view.addSubview(pokemonNumber)
        
        view.addSubview(detailStackView)
        detailStackView.addArrangedSubview(pokemonName)
        detailStackView.setCustomSpacing(10, after: pokemonName)
        detailStackView.addArrangedSubview(typeStackView)
        detailStackView.addArrangedSubview(habitatStackView)
        detailStackView.addArrangedSubview(regionStackView)
        
        typeStackView.addArrangedSubview(pokemonTypeTitle)
        typeStackView.addArrangedSubview(pokemonTypes)
        
        habitatStackView.addArrangedSubview(pokemonHabitatTitle)
        habitatStackView.addArrangedSubview(pokemonHabitat)
        
        regionStackView.addArrangedSubview(pokemonRegionTitle)
        regionStackView.addArrangedSubview(pokemonRegion)
        
        setConstraints()
        imageBackground.layer.cornerRadius = (view.frame.width - 20) / 2.6
        
        
    }
    
    func configure(name: String, number: Int) {
        let formattedPokemonNumber = String(format: "%03d", number)
        pokemonName.text = name.capitalizingFirstLetter()
        pokemonNumber.text = "#\(formattedPokemonNumber)"
        getImage(pokemonNumber: formattedPokemonNumber)
        getDetails(number: number)
        getHabitat(number: number)
    }
        
    private func setConstraints() {
        
        let imageSectionHeight = view.frame.width - 10
        
        NSLayoutConstraint.activate([
        
            imageSection.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            imageSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            imageSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            imageSection.heightAnchor.constraint(lessThanOrEqualToConstant: imageSectionHeight),
            
            imageBackground.centerXAnchor.constraint(equalTo: imageSection.centerXAnchor),
            imageBackground.centerYAnchor.constraint(equalTo: imageSection.centerYAnchor),
            imageBackground.heightAnchor.constraint(equalToConstant: imageSectionHeight / 1.3),
            imageBackground.widthAnchor.constraint(equalToConstant: imageSectionHeight / 1.3),
            
            pokemonImage.topAnchor.constraint(equalTo: imageSection.topAnchor, constant: 10),
            pokemonImage.leadingAnchor.constraint(equalTo: imageSection.leadingAnchor, constant: 10),
            pokemonImage.trailingAnchor.constraint(equalTo: imageSection.trailingAnchor, constant: -10),
            pokemonImage.bottomAnchor.constraint(equalTo: imageSection.bottomAnchor, constant: -10),
            
            pokemonNumber.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            pokemonNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            detailStackView.topAnchor.constraint(equalTo: imageSection.bottomAnchor, constant: 5),
            detailStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            pokemonHabitat.leadingAnchor.constraint(equalTo: pokemonTypes.leadingAnchor)
            
        ])
    }
    
    func getImage(pokemonNumber number: String) {
        Task {
            let image = await ImageCache.shared.downloadImage(pokemonNumber: number)
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
                pokemonTypes.text = joinedTypes
                
                imageBackground.backgroundColor = UIHelper.setCellBackgroundColor(types: joinedTypes)
                
            } catch {
                print(error)
            }
        }
    }
    
    func getHabitat(number: Int) {
        Task {
            do {
                let habitat = try await NetworkManager.shared.getPokemonHabitat(id: number)
                
                    pokemonHabitat.text = habitat.name.capitalizingFirstLetter()
                                
            } catch {
                pokemonHabitat.text = "Unknown"
            }
        }
    }



}
