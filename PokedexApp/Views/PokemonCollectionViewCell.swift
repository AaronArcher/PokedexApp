//
//  PokemonCollectionViewCell.swift
//  PokedexApp
//
//  Created by Aaron Johncock on 02/01/2023.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PokemonCollectionViewCell"

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let pokemonNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private let pokemonName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let pokemonTypes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 12)
        return label
    }()
    
    private let pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.tintColor = .gray.withAlphaComponent(0.5)
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(pokemonNumber)
        stackView.addArrangedSubview(pokemonName)
        stackView.addArrangedSubview(pokemonTypes)
        contentView.addSubview(pokemonImage)
        
        applyConstraints()
    }
    
    func configure(name: String, number: Int) {
        let formattedPokemonNumber = String(format: "%03d", number)
        pokemonName.text = name.capitalizingFirstLetter()
        pokemonNumber.text = "#\(formattedPokemonNumber)"
        
        getImage(number: formattedPokemonNumber)
        getDetails(number: number)
    }
    
    private func applyConstraints() {
        
        let stackConstraints = [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: contentView.frame.height / 3.5)
        ]
        
        let imageConstraints = [
            pokemonImage.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            pokemonImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pokemonImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pokemonImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(stackConstraints)
        NSLayoutConstraint.activate(imageConstraints)
        
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
                
                contentView.backgroundColor = UIHelper.setCellBackgroundColor(types: joinedTypes)
                
            } catch {
                print(error)
            }
        }
    }
    
    func getImage(number: String) {        
        Task {
            let image = await ImageCache.shared.downloadImage(pokemonNumber: number)
            pokemonImage.image = image
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImage.image = UIImage(systemName: "photo.fill")
        pokemonNumber.text = nil
        pokemonName.text = nil
        pokemonTypes.text = nil
        contentView.backgroundColor = .systemBackground
    }
    
}
