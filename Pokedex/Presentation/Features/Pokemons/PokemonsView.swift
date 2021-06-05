//
//  PokemonsView.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

import UIKit

class PokemonsView: UIViewController {
    
    private let screen: PokemonsScreen
    private let viewModel: PokemonsViewModel
    private let typeID: Int
    
    init(screen: PokemonsScreen,
         viewModel: PokemonsViewModel,
         typeID: Int) {
        self.screen = screen
        self.viewModel = viewModel
        self.typeID = typeID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = screen
        self.setupBindings()
        self.viewModel.getPokemonsBy(typeID: typeID)
    }
    
    private func setupBindings() {
        self.screen.tableView.delegate = self
        self.screen.tableView.dataSource = self
        
        self.viewModel.didGetPokemons = {
            self.screen.tableView.reloadData()
        }
    }

}

extension PokemonsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.viewModel.pokemons[indexPath.row].name
        return cell
    }
    
}

