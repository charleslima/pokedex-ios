//
//  BaseHeaderView.swift
//  Pokedex
//
//  Created by Charles de Jesus Lima on 05/06/21.
//

import UIKit

class BaseHeaderView: UIView {
    
    private let title: String
    
    lazy var headerLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.prepareForConstraints()
        titleLabel.text = self.title
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont(name: "ArialRoundedMTBold", size: 24)
        return titleLabel
    }()
    
    init(title: String = "Pokédex") {
        self.title = title.capitalized
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        setupViewHierarchy()
        setupViewContraints()
    }
    
    private func setupViewHierarchy() {
        self.addSubview(headerLabel)
    }
    
    private func setupViewContraints() {
        headerLabel.pinTop()
        headerLabel.pinBottom()
        headerLabel.pinLeft(24)
        headerLabel.pinRight(24)
    }
}
