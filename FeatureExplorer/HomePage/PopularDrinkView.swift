//
//  PopularDrinkView.swift
//  FeatureExplorer
//
//  Created by Rodrigo Vieira on 13/04/22.
//

import UIKit

class PopularDrinkView: UIView {
    lazy var drinkImageView: UIImageView = {
        let div = UIImageView(image: HomePageImages.profileIconImage)
        div.contentMode = .scaleAspectFit
        div.layer.cornerRadius = 8
        
        div.translatesAutoresizingMaskIntoConstraints = false
        
        return div
    }()
    
    lazy var drinkNameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.text = "aeeijk"
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var drinkSubtitleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addDrinkImageLayout()
        addTitleLayout()
        addSubtitleLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addContentToView(drink: DrinkModel) {
//        DispatchQueue.global(qos: .background).async {
//            do {
//                let data = try Data(contentsOf: URL(string: drink.strDrinkThumb!)!)
//                let image = UIImage(data: data)
//
//                DispatchQueue.main.async {
//                    self.drinkImageView.image = image
//                    self.drinkNameLabel.text = drink.strDrink
//                    self.drinkSubtitleLabel.text = drink.strCategory
//                }
//            } catch {
//                print(error)
//            }
//        }
    }
    
    func addDrinkImageLayout() {
        addSubview(drinkImageView)
        
        NSLayoutConstraint.activate([
            drinkImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            drinkImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            drinkImageView.topAnchor.constraint(equalTo: topAnchor),
            drinkImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func addTitleLayout() {
        addSubview(drinkNameLabel)
        
        NSLayoutConstraint.activate([
            drinkNameLabel.leadingAnchor.constraint(equalTo: drinkImageView.trailingAnchor, constant: 20),
            drinkNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            drinkNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func addSubtitleLayout() {
        addSubview(drinkSubtitleLabel)
        
        NSLayoutConstraint.activate([
            drinkSubtitleLabel.leadingAnchor.constraint(equalTo: drinkImageView.trailingAnchor, constant: 20),
            drinkSubtitleLabel.topAnchor.constraint(equalTo: drinkNameLabel.bottomAnchor, constant: 10),
            drinkSubtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

