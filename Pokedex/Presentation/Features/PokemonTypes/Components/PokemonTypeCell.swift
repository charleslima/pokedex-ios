//
//  PokemonTypeCell.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

import UIKit

final class PokemonTypeCell: UITableViewCell {
    
    private let pokemonType: PokemonType
    private var needsSetupBackgroundCardView: Bool = true
    
    private lazy var backgroundCardView: UIView = {
        let backgroundCardView = UIView()
        backgroundCardView.prepareForConstraints()
        backgroundCardView.layer.cornerRadius = 12
        return backgroundCardView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.prepareForConstraints()
        titleLabel.text = pokemonType.name.capitalized
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "ArialRoundedMTBold", size: 17)
        return titleLabel
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
    
    init(pokemonType: PokemonType) {
        self.pokemonType = pokemonType
        super.init(style: .default, reuseIdentifier: PokemonTypeCell.className)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupBackgroundCardView()
    }
    
    private func setupViewHierarchy() {
        self.addSubview(backgroundCardView)
        
        self.backgroundCardView.addSubview(watterMarkImageView)
        self.backgroundCardView.addSubview(titleLabel)
    }
    
    private func setupViewContraints() {
        self.backgroundCardView.pinTop(12)
        self.backgroundCardView.pinBottom(12)
        self.backgroundCardView.pinRight(24)
        self.backgroundCardView.pinLeft(24)
        
        self.watterMarkImageView.pinTop()
        self.watterMarkImageView.pinBottom()
        self.watterMarkImageView.pinRight()
        self.watterMarkImageView.constraintWidth(toAnchor: self.watterMarkImageView.heightAnchor, multiplier: 1.3)

        self.titleLabel.pinTop(24)
        self.titleLabel.pinLeft(16)
        
    }
    
    private func setupBackgroundCardView() {
        if self.needsSetupBackgroundCardView {
            self.backgroundCardView.setGradientBackground(topColor: #colorLiteral(red: 0.9529411765, green: 0.6117647059, blue: 0.07058823529, alpha: 1),
                                                          bottomColor: #colorLiteral(red: 0.9764166474, green: 0.3435883522, blue: 0, alpha: 1))
            self.backgroundCardView.setShadow(#colorLiteral(red: 0.9764166474, green: 0.3435883522, blue: 0, alpha: 1), opacity: 0.4,
                                              offset: CGSize(width: 4, height: 4), radius: 8)
            self.needsSetupBackgroundCardView = false
        }
    }
    
    private func additionalConfigurations() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
}
