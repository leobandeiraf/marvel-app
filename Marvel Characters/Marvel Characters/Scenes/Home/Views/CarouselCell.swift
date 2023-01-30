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
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = Layout.Size.itemSize
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = Layout.Spacing.minimumLineSpacing
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: Layout.Spacing.minimumLineSpacing,
            bottom: 0,
            right: Layout.Spacing.minimumLineSpacing
        )
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.dataSource = self
        collectionView.register(CharacterCard.self, forCellWithReuseIdentifier: CharacterCard.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: Layout.Size.itemSize.height)
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
