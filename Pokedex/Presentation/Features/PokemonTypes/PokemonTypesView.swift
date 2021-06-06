//
//  ViewController.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

import UIKit

protocol PokemonTypesViewDelegate: AnyObject {
    func userDidTapPokemonType(type: PokemonType)
}

class PokemonTypesView: BaseViewController {
    
    private let screen: PokemonTypesScreen
    private let viewModel: PokemonTypesViewModel
    weak var delegate: PokemonTypesViewDelegate?
    
    init(screen: PokemonTypesScreen,
         viewModel: PokemonTypesViewModel) {
        self.screen = screen
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = screen
        self.setupBindings()
        self.viewModel.getPokemonTypes()
    }
    
    private func setupBindings() {
        self.screen.tableView.delegate = self
        self.screen.tableView.dataSource = self
        
        self.viewModel.didGetPokemonTypes = {
            self.screen.tableView.reloadData()
        }
    }

}

extension PokemonTypesView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.pokemonTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PokemonTypeCell(pokemonType: self.viewModel.pokemonTypes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemonType = self.viewModel.pokemonTypes[indexPath.row]
        self.delegate?.userDidTapPokemonType(type: pokemonType)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return screen.headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

