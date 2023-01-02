//
//  ViewController.swift
//  PokedexApp
//
//  Created by Aaron Johncock on 23/12/2022.
//

import UIKit

class PokemonTableViewController: UIViewController {
    
    private var pokemon = [Pokemon]()
    private var page = 1
    private var isLoadingMorePokemon = false

    
    private let pokemonTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pokemonTableView)
        pokemonTableView.frame = view.bounds
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        
        getPokemon(page: page)

    }
    
    private func getPokemon(page: Int) {
        
        isLoadingMorePokemon = true
        
        Task {
            do {
                let pokemonResponse = try await NetworkManager.shared.getPokemon(page: page)
                pokemon.append(contentsOf: pokemonResponse.results)
                pokemonTableView.reloadData()
                isLoadingMorePokemon = false
            } catch {
                print(error)
            }
        }
        
        
    }
    

}

extension PokemonTableViewController: UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier) as? PokemonTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .systemBackground
        cell.configure(name: pokemon[indexPath.row].name, number: indexPath.row + 1)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
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
