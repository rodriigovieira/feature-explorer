//
//  RecentDrinksCollectionView.swift
//  FeatureExplorer
//
//  Created by Rodrigo Vieira on 11/04/22.
//

import UIKit
import Combine

private let reuseIdentifier = "drink_cell"

class RecentDrinksCollectionView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var observers: [AnyCancellable] = []
    var drinks: [DrinkModel] = []
    
    let networkService = NetworkService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.layer.cornerRadius = 15
        self.collectionView.showsHorizontalScrollIndicator = false

        self.collectionView!.register(
            DrinkHorizontalCell.self,
            forCellWithReuseIdentifier: reuseIdentifier
        )

        networkService.fetchLatestCocktails()
            .receive(on: DispatchQueue.main)
            .sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
            case .finished:
                print("finished")
            }
        } receiveValue: { [weak self] drinks in
            self?.drinks = drinks
            self?.collectionView.reloadData()
        }.store(in: &self.observers)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 270, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier, for: indexPath
        ) as! DrinkHorizontalCell
        cell.setPageContent(drink: drinks[indexPath.item])
        
        return cell
    }
}
