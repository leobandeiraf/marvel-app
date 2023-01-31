//
//  CharacterListCell.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 31/01/23.
//

import SDWebImage
import SkeletonView
import UIKit

fileprivate extension CharacterListCell.Layout {
    enum Size {
        static let itemHeight: CGFloat = 90
    }
    
    enum Spacing {
        static let horizontalInset: CGFloat = 16
        static let verticalInset: CGFloat = 8
    }
}

final class CharacterListCell: UITableViewCell {
    // MARK: - Propery(ies).
    enum Layout {}
    static let identifier = "\(CharacterListCell.self)"
    
    // MARK: - Component(s).
    private lazy var container: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var characterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Initialization(s).
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method(s).
    func configure(with image: Character.CharacterImage) -> Self {
        characterImageView.sd_setImage(with: image.url)
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
private extension CharacterListCell {
    private func buildViewHierarchy() {
        contentView.addSubview(container)
        container.addSubview(characterImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: Layout.Size.itemHeight),
            
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.Spacing.verticalInset),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.Spacing.horizontalInset),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.Spacing.verticalInset),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.Spacing.horizontalInset),
            
            characterImageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            characterImageView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }
    
    private func configureView() {
        isSkeletonable = true
        contentView.backgroundColor = .white
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 8).cgPath
        shadowLayer.fillColor = UIColor.clear.cgColor
        
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowRadius = CGFloat(8)
        shadowLayer.shadowOpacity = Float(0.21)
        shadowLayer.shadowOffset = CGSize(width: 54, height: 54)
        
        contentView.layer.insertSublayer(shadowLayer, at: 0)
        
    }
}
