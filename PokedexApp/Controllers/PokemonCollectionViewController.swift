//
//  PokemonCollectionViewController.swift
//  PokedexApp
//
//  Created by Aaron Johncock on 31/12/2022.
//

import UIKit

class PokemonCollectionViewController: UIViewController {

    private var pokemon = [Pokemon]()
    private var page = 1
    private var isLoadingMorePokemon = false
    
    private let pokemonCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonCollectionView.frame = view.bounds
        pokemonCollectionView.delegate = self
        pokemonCollectionView.dataSource = self
        
    }

}

extension PokemonCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as? PokemonCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
        
    }
    
    
}
