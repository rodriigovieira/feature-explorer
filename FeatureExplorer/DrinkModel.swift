//
//  DrinkModel.swift
//  FeatureExplorer
//
//  Created by Rodrigo Vieira on 11/04/22.
//

import Foundation

struct Response: Codable {
    var drinks: [DrinkModel]?
}

struct DrinkModel: Codable {
    var idDrink: String?
    var strDrink: String?
    var strCategory: String?
    var strInstructions: String?
    var strDrinkThumb: String?
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
}
