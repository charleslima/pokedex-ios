//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

import UIKit
import Kingfisher
import Culore

final class PokemonCell: UITableViewCell {
    
    private let pokemon: Pokemon
    private var needsSetupBackgroundCardView: Bool = true
    
    private lazy var backgroundCardView: UIView = {
        let backgroundCardView = UIView()
        backgroundCardView.prepareForConstraints()
        backgroundCardView.layer.cornerRadius = 8
        backgroundCardView.backgroundColor = UIColor.lightGray
        backgroundCardView.setShadow(UIColor.lightGray, opacity: 0.4,
                                     offset: CGSize(width: 4, height: 4), radius: 8)
        return backgroundCardView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.prepareForConstraints()
        titleLabel.text = pokemon.name.capitalized
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "ArialRoundedMTBold", size: 17)
        return titleLabel
    }()
    
    private lazy var abilitiesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.prepareForConstraints()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var watterMarkImageView: UIImageView = {
        let watterMarkImageView = UIImageView()
        watterMarkImageView.prepareForConstraints()
        watterMarkImageView.image = UIImage(named: "dw-pokeball")
        watterMarkImageView.contentMode = .scaleAspectFill
        watterMarkImageView.clipsToBounds = true
        watterMarkImageView.alpha = 0.05
        return watterMarkImageView
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let pokemonImageView = UIImageView()
        pokemonImageView.prepareForConstraints()
        pokemonImageView.contentMode = .scaleToFill
        if let imageURL = try? pokemon.imageURL.asURL() {
            pokemonImageView.kf.setImage(with: imageURL)
        }
        return pokemonImageView
    }()
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(style: .default, reuseIdentifier: PokemonTypeCell.className)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupBackgroundCardView()
    }
    
    private func configureView() {
        setupViewHierarchy()
        setupViewContraints()
        additionalConfigurations()
    }
    
    private func setupViewHierarchy() {
        self.addSubview(backgroundCardView)
        self.addSubview(pokemonImageView)
        self.backgroundCardView.addSubview(watterMarkImageView)
        self.backgroundCardView.addSubview(titleLabel)
        self.backgroundCardView.addSubview(abilitiesStackView)
        
        self.pokemon.abilities.prefix(2).forEach({ ability in
            let abilityLabel = UILabel()
            abilityLabel.prepareForConstraints()
            abilityLabel.font = UIFont(name: "ArialRoundedMTBold", size: 12)
            abilityLabel.textColor = .white
            abilityLabel.text = "  \(ability.capitalized)  "
            abilityLabel.backgroundColor = UIColor.culore(self.pokemon.colorName)?.darker(by: 20) ?? .black
            abilityLabel.layer.cornerRadius = 4
            abilityLabel.layer.masksToBounds = true
            
            self.abilitiesStackView.addArrangedSubview(abilityLabel)
        })
    }
    
    private func setupViewContraints() {
        self.backgroundCardView.pinTop(24)
        self.backgroundCardView.pinBottom(8)
        self.backgroundCardView.pinRight(24)
        self.backgroundCardView.pinLeft(24)
        
        self.pokemonImageView.pinTop()
        self.pokemonImageView.pinRightInRelation(to: self.backgroundCardView.rightAnchor)
        self.pokemonImageView.pinBottomInRelation(to: self.backgroundCardView.bottomAnchor  )
        self.pokemonImageView.constraintWidth(toAnchor: self.pokemonImageView.heightAnchor)
        
        self.watterMarkImageView.pinTop()
        self.watterMarkImageView.pinBottom()
        self.watterMarkImageView.pinRight()
        self.watterMarkImageView.constraintWidth(toAnchor: self.watterMarkImageView.heightAnchor, multiplier: 1.3)

        self.titleLabel.pinTop(16)
        self.titleLabel.pinLeft(16)
        
        self.abilitiesStackView.pinLeft(16)
        self.abilitiesStackView.pinTopInRelation(to: self.titleLabel.bottomAnchor, 8)
        self.abilitiesStackView.constraintHeight(24)
        
    }
    
    private func setupBackgroundCardView() {
        if self.needsSetupBackgroundCardView {
            let topColor = UIColor.culore(pokemon.colorName) ?? .orange
            let bottomColor = topColor.darker(by: 10) ?? .orange
            self.backgroundCardView.setGradientBackground(topColor: topColor,
                                                          bottomColor: bottomColor)
            self.backgroundCardView.setShadow(bottomColor, opacity: 0.4,
                                              offset: CGSize(width: 4, height: 4), radius: 8)
            self.needsSetupBackgroundCardView = false
        }
    }
    
    private func additionalConfigurations() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
}
