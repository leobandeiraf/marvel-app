//
//  HomeViewController.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 30/01/23.
//

import SkeletonView
import UIKit

protocol HomeDisplaying: AnyObject {
    func displayCharacters(with model: [SectionModel])
    func displayLoading(_ bool: Bool)
}

final class HomeViewController: UIViewController {
    // MARK: - Property(ies).
    private let viewModel: HomeViewModeling
    
    private var sections = [SectionModel]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - Component(s).
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.isSkeletonable = true
        tableView.register(CarouselCell.self, forCellReuseIdentifier: CarouselCell.identifier)
        tableView.register(CharacterListCell.self, forCellReuseIdentifier: CharacterListCell.identifier)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Initialization(s).
    init(viewModel: HomeViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override(s).
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCharacters()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    // MARK: - Setup(s).
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func setupLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureView()
    }
}

// MARK: - View Configuration.
private extension HomeViewController {
    private func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureView() {
        title = "Characters"
        view.backgroundColor = .white
    }
}

// MARK: - Displaying Method(s).
extension HomeViewController: HomeDisplaying {
    func displayCharacters(with model: [SectionModel]) {
        sections = model
    }
    
    func displayLoading(_ bool: Bool) {
        bool ? tableView.showAnimatedGradientSkeleton() : tableView.hideSkeleton()
    }
}

// MARK: - TableView DataSource.
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section].section {
        case .carousel:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CarouselCell.identifier,
                for: indexPath
            ) as? CarouselCell,
                  let characters = sections[indexPath.section].characters else { return UITableViewCell() }
            return cell.configure(with: characters)
        case .list:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CharacterListCell.identifier,
                for: indexPath
            ) as? CharacterListCell,
                  let character = sections[indexPath.section].characters?[indexPath.row] else { return UITableViewCell() }
            return cell.configure(with: character)
        }
    }
}

// MARK: - SkeletonView DataSource.
extension HomeViewController: SkeletonTableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        2
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 5
        default:
            return 0
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch indexPath.section {
        case 0:
            return CarouselCell.identifier
        case 1:
            return CharacterListCell.identifier
        default:
            return CharacterListCell.identifier
        }
    }
}
