//
//  DrinkHorizontalCell.swift
//  FeatureExplorer
//
//  Created by Rodrigo Vieira on 11/04/22.
//

import UIKit

class DrinkHorizontalCell: UICollectionViewCell {
    var drinkImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    var drinkNameLabel: UILabel = {
        var label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    var drinkSubtitleLabel: UILabel = {
        var label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    lazy var containerView: UIView = {
        var view = UIView(frame: contentView.frame)
        
        return view
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        containerView.backgroundColor = Colors.mainRedColor.withAlphaComponent(0.3)
        containerView.layer.cornerRadius = 15
        layer.cornerRadius = 15
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            containerView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            containerView.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            containerView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            )
        ])
        
        setImageLayout()
        addLabelsLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setImageLayout() {
        drinkImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(drinkImageView)
        
        NSLayoutConstraint.activate([
            drinkImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            drinkImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            drinkImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            drinkImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setPageContent(drink: DrinkModel) {
        DispatchQueue.global(qos: .background).async {
            let drinkImage = self.fetchDrinkImageOf(url: drink.strDrinkThumb!)
            
            DispatchQueue.main.async {
                self.drinkImageView.image = drinkImage
                self.drinkNameLabel.text = drink.strDrink!
                self.drinkSubtitleLabel.text = drink.strCategory!
            }
        }
    }
    
    func fetchDrinkImageOf(url: String) -> UIImage? {
        let url = URL(string: url)
        
        if let safeUrl = url {
            do {
                let data = try Data(contentsOf: safeUrl)
                
                return UIImage(data: data)
            } catch {
                print(error)
            }
        }
        
        return nil
    }
    
    func addLabelsLayout() {
        drinkNameLabel.translatesAutoresizingMaskIntoConstraints = false
        drinkSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(drinkNameLabel)
        containerView.addSubview(drinkSubtitleLabel)
        
        NSLayoutConstraint.activate([
            drinkNameLabel.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor, constant: 20
            ),
            drinkNameLabel.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor, constant: -20
            ),
            drinkNameLabel.topAnchor.constraint(
                equalTo: drinkImageView.bottomAnchor, constant: 15
            ),
            drinkSubtitleLabel.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor, constant: 20
            ),
            drinkSubtitleLabel.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor, constant: -20
            ),
            drinkSubtitleLabel.topAnchor.constraint(
                equalTo: drinkNameLabel.bottomAnchor, constant: 10
            )
        ])
    }
}

