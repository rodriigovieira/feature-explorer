//
//  PopularDrinkCell.swift
//  FeatureExplorer
//
//  Created by Rodrigo Vieira on 11/04/22.
//

import UIKit

class PopularDrinkCell: UITableViewCell {
    var drinkNameLabel: UILabel = {
        var label = UILabel()
        
        label.text = "Margarita"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reusableIdentifier)
        
        setDrinkNameLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setDrinkNameLayout() {
        drinkNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(drinkNameLabel)
        
        NSLayoutConstraint.activate([
            drinkNameLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 20
            ),
            drinkNameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            drinkNameLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            )
        ])
    }
}
