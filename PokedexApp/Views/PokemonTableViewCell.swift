//
//  PokemonTableViewCell.swift
//  PokedexApp
//
//  Created by Aaron Johncock on 23/12/2022.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    static let identifier = "PokemonTableViewCell"
    
    private let detailStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        return stackView
    }()
    
    private let typeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .leading
        return stackView
    }()
    
    private let pokemonNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let pokemonName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let pokemonTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.text = "Type:"
        return label
    }()
    
    private let pokemonTypes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 15)
        return label
    }()
    
    private let pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.tintColor = .gray.withAlphaComponent(0.5)
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(pokemonImage)
        contentView.addSubview(detailStackview)
        detailStackview.addArrangedSubview(pokemonNumber)
        detailStackview.addArrangedSubview(pokemonName)
        detailStackview.addArrangedSubview(typeStackView)
                
        typeStackView.addArrangedSubview(pokemonTypeLabel)
        typeStackView.addArrangedSubview(pokemonTypes)
        
//        contentView.addSubview(pokemonName)
//        contentView.addSubview(pokemonNumber)
//        contentView.addSubview(pokemonTypeLabel)
//        contentView.addSubview(pokemonTypes)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints() {
        
        let imageConstraints = [
            pokemonImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            pokemonImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            pokemonImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            pokemonImage.widthAnchor.constraint(equalToConstant: 70)
        ]
        
        let stackConstraints = [
            detailStackview.leadingAnchor.constraint(equalTo: pokemonImage.trailingAnchor, constant: 20),
            detailStackview.centerYAnchor.constraint(equalTo: pokemonImage.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(stackConstraints)
    }
    
    func configure(name: String, number: Int) {
        let formattedPokemonNumber = String(format: "%03d", number)
        pokemonName.text = name.capitalizingFirstLetter()
        pokemonNumber.text = "#\(formattedPokemonNumber)"
        
        getImage(number: formattedPokemonNumber)
        getDetails(number: number)
        
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
                pokemonTypes.text = joinedTypes
                
                contentView.backgroundColor = setBackgroundColor(types: joinedTypes)
                
            } catch {
                print(error)
            }
        }
    }
    
    private func setBackgroundColor(types: String) -> UIColor {
        if types.contains("Grass") {
            return .green.withAlphaComponent(0.15)
        } else if types.contains("Fire") {
            return.red.withAlphaComponent(0.15)
        } else if types.contains("Water") {
            return .blue.withAlphaComponent(0.15)
        } else if types.contains("Electric") {
            return .yellow.withAlphaComponent(0.15)
        } else if types.contains("Poison") {
            return .purple.withAlphaComponent(0.15)
        } else if types.contains("Ground") {
            return .brown.withAlphaComponent(0.15)
        } else if types.contains("Psychic") {
            return .cyan.withAlphaComponent(0.15)
        } else if types.contains("Fairy") {
            return .systemPink.withAlphaComponent(0.15)
        } else {
            return .systemBackground
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
