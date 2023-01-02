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
    
    private var pokemonCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        getPokemon(page: page)
    }
    
    private func configureCollectionView() {
        pokemonCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(pokemonCollectionView)
        pokemonCollectionView.delegate = self
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.backgroundColor = .systemBackground
        pokemonCollectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
    }
    
    private func getPokemon(page: Int) {
        
        isLoadingMorePokemon = true
        
        Task {
            do {
                let pokemonResponse = try await NetworkManager.shared.getPokemon(page: page)
                pokemon.append(contentsOf: pokemonResponse.results)
                pokemonCollectionView.reloadData()
                isLoadingMorePokemon = false
            } catch {
                print(error)
            }
        }
    }

}

extension PokemonCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as? PokemonCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(name: pokemon[indexPath.row].name, number: indexPath.row + 1)
        cell.layer.cornerRadius = 15
        cell.layer.cornerCurve = .continuous
        cell.clipsToBounds = true
        return cell
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            page += 1
            getPokemon(page: page)
        }
    }
    
}
