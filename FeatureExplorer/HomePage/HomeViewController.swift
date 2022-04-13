//
//  HomeViewController.swift
//  FeatureExplorer
//
//  Created by Rodrigo Vieira on 10/04/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    var networkService = NetworkService.shared
    var observers = [AnyCancellable]()
    
    var rootScrollView: UIScrollView = {
        var sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    var rootStackView: UIStackView = {
        var rc = UIStackView()
        rc.translatesAutoresizingMaskIntoConstraints = false
        
        return rc
    }()
    
    var welcomeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Welcome!"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView(image: HomePageImages.profileIconImage!)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    var searchBar: UITextField = {
        let textField = UITextField()
        
        var leftPaddingView = UIView(
            frame: CGRect(x: 0, y: 0, width: 10, height: 0)
        )
        
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        
        textField.layer.cornerRadius = 12
        textField.backgroundColor = .white
        textField.placeholder = "Search cocktails"
        
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = .init(width: 1, height: 1)
        textField.layer.shadowRadius = 8
        textField.layer.shadowOpacity = 0.2
        
        return textField
    }()
    
    var screenContentContainerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowRadius = 12
        
        return view
    }()
    
    var latestDrinksLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Last cocktails published"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    var recentDrinksCollectionView: RecentDrinksCollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        
        let collectionView = RecentDrinksCollectionView(
            collectionViewLayout: collectionViewLayout
        )
        
        return collectionView
    }()
    
    var popularCocktailsLabel: UILabel = {
        var label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Popular drinks"
        
        return label
    }()
    
    override func viewDidLayoutSubviews() {
        
        addScrollViewLayout()
        addRootStackViewLayout()
        addWelcomeLabelLayout()
        addSearchBarLayout()
        addScreenContentViewLayout()
        addLatestLabelLayout()
        addRecentDrinksCollectionLayout()
        addPopularLabelLayout()
        addPopularDrinksTableViewLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAndDisplayPopularCocktails()

        view.backgroundColor = Colors.mainRedColor
    }
    
    func addScrollViewLayout() {
        view.addSubview(rootScrollView)
        
        NSLayoutConstraint.activate([
            rootScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            rootScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func addRootStackViewLayout() {
        rootScrollView.addSubview(rootStackView)
        
        NSLayoutConstraint.activate([
            rootStackView.leadingAnchor.constraint(
                equalTo: rootScrollView.contentLayoutGuide.leadingAnchor
            ),
            rootStackView.trailingAnchor.constraint(
                equalTo: rootScrollView.contentLayoutGuide.trailingAnchor
            ),
            rootStackView.topAnchor.constraint(
                equalTo: rootScrollView.contentLayoutGuide.topAnchor
            ),
            rootStackView.bottomAnchor.constraint(
                equalTo: rootScrollView.contentLayoutGuide.bottomAnchor
            ),
            rootStackView.widthAnchor.constraint(
                equalTo: rootScrollView.frameLayoutGuide.widthAnchor
            )
        ])
    }
    
    func addWelcomeLabelLayout() {
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
    
        rootStackView.addSubview(profileImageView)
        rootStackView.addSubview(welcomeLabel)
        
        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(
                equalTo: rootStackView.leadingAnchor,
                constant: 20
            ),
            welcomeLabel.trailingAnchor.constraint(
                equalTo: rootStackView.trailingAnchor,
                constant: -20
            ),
            welcomeLabel.topAnchor.constraint(
                equalTo: rootStackView.topAnchor,
                constant: 20
            ),
            profileImageView.topAnchor.constraint(
                equalTo: rootStackView.topAnchor, constant: 20
            ),
            profileImageView.centerXAnchor.constraint(
                equalTo: rootStackView.trailingAnchor,
                constant: -50
            ),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),
            welcomeLabel.centerYAnchor.constraint(
                equalTo: profileImageView.centerYAnchor
            ),
        ])
    }
    
    func addSearchBarLayout() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        rootStackView.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(
                equalTo: rootStackView.leadingAnchor, constant: 20
            ),
            searchBar.trailingAnchor.constraint(
                equalTo: rootStackView.trailingAnchor, constant: -20
            ),
            searchBar.topAnchor.constraint(
                equalTo: profileImageView.bottomAnchor, constant: 20
            ),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func addScreenContentViewLayout() {
        screenContentContainerView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.addSubview(screenContentContainerView)
        
        NSLayoutConstraint.activate([
            screenContentContainerView.leadingAnchor.constraint(
                equalTo: rootStackView.leadingAnchor
            ),
            screenContentContainerView.trailingAnchor.constraint(
                equalTo: rootStackView.trailingAnchor
            ),
            screenContentContainerView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            screenContentContainerView.topAnchor.constraint(
                equalTo: searchBar.bottomAnchor, constant: 25
            )
        ])
    }
    
    func addLatestLabelLayout() {
        latestDrinksLabel.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.addSubview(latestDrinksLabel)
        
        NSLayoutConstraint.activate([
            latestDrinksLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 20
            ),
            latestDrinksLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -20
            ),
            latestDrinksLabel.topAnchor.constraint(
                equalTo: screenContentContainerView.topAnchor, constant: 30
            )
        ])
    }
    
    func addRecentDrinksCollectionLayout() {
        addChild(recentDrinksCollectionView)
        
        recentDrinksCollectionView
            .view
            .translatesAutoresizingMaskIntoConstraints = false
        
        screenContentContainerView.addSubview(recentDrinksCollectionView.view)
        
        NSLayoutConstraint.activate([
            recentDrinksCollectionView.view.topAnchor.constraint(
                equalTo: latestDrinksLabel.bottomAnchor,
                constant: 20
            ),
            recentDrinksCollectionView.view.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            recentDrinksCollectionView.view.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            recentDrinksCollectionView.view.heightAnchor.constraint(
                equalToConstant: 280
            )
        ])
    }
    
    func addPopularLabelLayout() {
        popularCocktailsLabel.translatesAutoresizingMaskIntoConstraints = false
        screenContentContainerView.addSubview(popularCocktailsLabel)
        
        NSLayoutConstraint.activate([
            popularCocktailsLabel.topAnchor.constraint(
                equalTo: recentDrinksCollectionView.view.bottomAnchor,
                constant: 20
            ),
            popularCocktailsLabel.leadingAnchor.constraint(
                equalTo: rootStackView.leadingAnchor,
                constant: 20
            ),
            popularCocktailsLabel.trailingAnchor.constraint(
                equalTo: rootStackView.trailingAnchor,
                constant: -20
            ),
        ])
    }
    
    func addPopularDrinksTableViewLayout() {
        
    }
    
    func displayTwoFirstPopularDrinks(drinks: [DrinkModel]) {
        let firstPopularDrinkView = PopularDrinkView()
        rootStackView.addSubview(firstPopularDrinkView)
        
        NSLayoutConstraint.activate([
            firstPopularDrinkView.topAnchor.constraint(
                equalTo: popularCocktailsLabel.bottomAnchor,
                constant: 50
            ),
            firstPopularDrinkView.leadingAnchor.constraint(
                equalTo: rootStackView.leadingAnchor,
                constant: 20
            ),
            firstPopularDrinkView.trailingAnchor.constraint(
                equalTo: rootStackView.trailingAnchor,
                constant: -20
            ),
            firstPopularDrinkView.heightAnchor.constraint(
                equalToConstant: 300
            ),
            firstPopularDrinkView.bottomAnchor.constraint(
                equalTo: rootStackView.bottomAnchor
            )
        ])
        
//        firstPopularDrinkView.addContentToView(drink: drinks.first!)
    }
    
    func fetchAndDisplayPopularCocktails() {
        networkService
            .fetchPopularCocktails()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: { [weak self] value in
                self?.displayTwoFirstPopularDrinks(drinks: value)
            }
            .store(in: &observers)
    }
}
