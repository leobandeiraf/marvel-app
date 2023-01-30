//
//  HomeViewController.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 30/01/23.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Override(s).
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    // MARK: - Setup(s).
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
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
        
    }
    
    private func setupConstraints() {
        
    }
    
    private func configureView() {
        title = "Characters"
    }
}
