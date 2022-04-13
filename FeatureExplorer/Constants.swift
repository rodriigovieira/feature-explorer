//
//  Constants.swift
//  FeatureExplorer
//
//  Created by Rodrigo Vieira on 04/04/22.
//

import Foundation
import UIKit

private let kAPIBaseURL = "https://www.thecocktaildb.com/api/json/v2/9973533"

enum ApiURLs {
    static var recentDrinks: String = "\(kAPIBaseURL)/recent.php"
    static var popularDrinks: String = "\(kAPIBaseURL)/popular.php"
}

enum CellsIdentifier {
    static var popularDrinksCell = "popular_drink_cell"
    static var recentDrinksCell = "recent_drink_cell"
    static var onboardingCell = "onboarding_cell"
}

enum Colors {
    static var mainRedColor: UIColor = UIColor(
        red: 0.96, green: 0.54, blue: 0.54, alpha: 1.00
    )
    static var lightYellow: UIColor = UIColor(
        red: 0.96, green: 0.91, blue: 0.85, alpha: 1.00
    )
}

enum UserDefaultsKeys {
    static var onboardingScreenWasShown: String = "@onboarding_screen_was_shown"
}

enum HomePageImages {
    static var profileIconImage: UIImage? {
        return UIImage(named: "profile")
    }
}

enum OnboardingImages {
    static var mainOnboardingImage: UIImage {
        return UIImage(named: "onboarding_cocktails")!
    }
    
    static var onboardingImage1: UIImage {
        return UIImage(named: "onboarding")!
    }
    
    static var onboardingImage2: UIImage {
        return UIImage(named: "onboarding_2")!
    }
    
    static var onboardingImage3: UIImage {
        return UIImage(named: "onboarding_3")!
    }
}
