//
//  PokemonsView.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

import UIKit

class PokemonsView: BaseViewController {
    
    private let screen: PokemonsScreen
    private let viewModel: PokemonsViewModel
    private let type: PokemonType
    
    init(screen: PokemonsScreen,
         viewModel: PokemonsViewModel,
         type: PokemonType) {
        self.screen = screen
        self.viewModel = viewModel
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = screen
        self.setupBindings()
        self.viewModel.getPokemonsBy(typeID: type.id)
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
        let cell = PokemonCell(pokemon: self.viewModel.pokemons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return screen.headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
}

