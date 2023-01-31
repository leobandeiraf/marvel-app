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
    
    // MARK: - Component(s).
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Initialization(s).
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method(s).
    func configure(with image: Character.CharacterImage) -> Self {
        imageView.sd_setImage(with: image.url)
        return self
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
    private func buildViewHierarchy() {
        contentView.addSubview(imageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func configureView() {
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        
        let shadowLayer = CAShapeLayer.init()
        shadowLayer.path = UIBezierPath.init(roundedRect: bounds, cornerRadius: 8).cgPath
        shadowLayer.fillColor = UIColor.clear.cgColor
        
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowRadius = CGFloat(4.0)
        shadowLayer.shadowOpacity = Float(0.2)
        shadowLayer.shadowOffset = CGSize(width: 6, height: 12.0)
        
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
}
