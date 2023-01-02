//
//  TabBarController.swift
//  PokedexApp
//
//  Created by Aaron Johncock on 31/12/2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = PokemonTableViewController()
        let vc2 = PokemonCollectionViewController()
        
        vc1.title = "List"
        vc2.title = "Grid"

        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        nav1.tabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "list.star"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Grid", image: UIImage(systemName: "square.grid.2x2"), tag: 2)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2], animated: true)
        
    }

}
