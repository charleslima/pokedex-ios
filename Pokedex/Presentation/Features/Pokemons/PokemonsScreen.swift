//
//  PokemonsScreen.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

import UIKit

final class PokemonsScreen: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.prepareForConstraints()
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        setupViewHierarchy()
        setupViewContraints()
        additionalConfigurations()
    }
    
    private func setupViewHierarchy() {
        self.addSubview(tableView)
    }
    
    private func setupViewContraints() {
        tableView.pinEdgesToSuperview()
    }
    
    private func additionalConfigurations() {
        self.backgroundColor = .white
    }
    
}
