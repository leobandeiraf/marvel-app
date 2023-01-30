//
//  CharacterCard.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 30/01/23.
//

import UIKit

final class CharacterCard: UICollectionViewCell {
    // MARK: - Propery(ies).
    static let identifier = "\(CharacterCard.self)"
    
    // MARK: - Initialization(s).
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup(s).
    private func setupLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureView()
    }
}

// MARK: - View Configuration.
private extension CharacterCard {
    private func buildViewHierarchy() {}
    
    private func setupConstraints() {}
    
    private func configureView() {
        contentView.backgroundColor = .red
    }
}
