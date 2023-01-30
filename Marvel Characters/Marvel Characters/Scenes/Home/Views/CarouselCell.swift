//
//  CarouselCell.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 30/01/23.
//

import UIKit

fileprivate extension CarouselCell.Layout {
    enum Size {
        static let itemSize: CGSize = CGSize(width: 134, height: 176)
    }
    
    enum Spacing {
        static let minimumLineSpacing: CGFloat = 16
    }
}

final class CarouselCell: UITableViewCell {
    // MARK: - Propery(ies).
    enum Layout {}
    static let identifier = "\(CarouselCell.self)"
    
    // MARK: - Component(s).
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.dataSource = self
        collectionView.register(CharacterCard.self, forCellWithReuseIdentifier: CharacterCard.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Layout.Size.itemSize
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: Layout.Spacing.minimumLineSpacing,
            bottom: 0,
            right: Layout.Spacing.minimumLineSpacing
        )
        layout.minimumLineSpacing = Layout.Spacing.minimumLineSpacing
        layout.minimumInteritemSpacing = 0
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        return collectionView
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
    
    // MARK: - Setup(s).
    private func setupLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureView()
    }
}

// MARK: - View Configuration.
private extension CarouselCell {
    private func buildViewHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func configureView() {
        contentView.backgroundColor = .white
        selectionStyle = .none
    }
}

// MARK: - CollectionView Data Source.
extension CarouselCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCard.identifier, for: indexPath)
    }
}
