//
//  PokemonTypesScreen.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 03/06/21.
//

import UIKit

final class PokemonTypesScreen: UIView {
    
    lazy var headerView: BaseHeaderView = {
        return BaseHeaderView()
    }()
    
    private lazy var watterMarkImageView: UIImageView = {
        let watterMarkImageView = UIImageView()
        watterMarkImageView.prepareForConstraints()
        watterMarkImageView.image = UIImage(named: "dw-pokeball")
        watterMarkImageView.contentMode = .scaleAspectFill
        watterMarkImageView.clipsToBounds = false
        watterMarkImageView.alpha = 0.05
        return watterMarkImageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.prepareForConstraints()
        tableView.separatorStyle = .none
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
        self.tableView.backgroundView = UIView()
        self.tableView.backgroundView?.addSubview(watterMarkImageView)
    }
    
    private func setupViewContraints() {
        watterMarkImageView.pinTop()
        watterMarkImageView.pinLeft()
        watterMarkImageView.pinRight()
        watterMarkImageView.constraintHeight(100)
        
        tableView.pinEdgesToSuperview()
    }
    
    private func additionalConfigurations() {
        self.backgroundColor = .white
    }
    
}
