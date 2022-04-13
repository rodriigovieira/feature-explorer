//
//  PageCell.swift
//  FeatureExplorer
//
//  Created by Rodrigo Vieira on 04/04/22.
//

import UIKit

class PageCell: UICollectionViewCell {
    private var onboardingImageView: UIImageView = {
        let imageView = UIImageView(image: OnboardingImages.onboardingImage1)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var welcomeText: UILabel = {
        let label = UILabel()
        
        label.text = "Welcome to the Feature Explorer!"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        
        return label
    }()
    
    private var instructionsText: UILabel = {
        let label = UILabel()
        
        label.text = "Please swipe left to see all the features that this project has to offer."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .gray
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setImageConstraints()
        setLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setPageContent(page: PageModel) {
        onboardingImageView.image = page.image
        welcomeText.text = page.headlineText
        instructionsText.text = page.subtitleText
    }
    
    func addSubviews() {
        addSubview(welcomeText)
        addSubview(instructionsText)
    }
    
    func setImageConstraints() {
        let holderContainer = UIView()
        addSubview(holderContainer)
        
        onboardingImageView.translatesAutoresizingMaskIntoConstraints = false
        holderContainer.translatesAutoresizingMaskIntoConstraints = false
        
        holderContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        holderContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        holderContainer.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        holderContainer.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        holderContainer.addSubview(onboardingImageView)
        
        onboardingImageView.heightAnchor.constraint(equalTo: holderContainer.heightAnchor, multiplier: 0.5).isActive = true
        onboardingImageView.centerYAnchor.constraint(equalTo: holderContainer.centerYAnchor).isActive = true
        onboardingImageView.centerXAnchor.constraint(equalTo: holderContainer.centerXAnchor).isActive = true
    }
    
    func setLabelConstraints() {
        welcomeText.translatesAutoresizingMaskIntoConstraints = false
        instructionsText.translatesAutoresizingMaskIntoConstraints = false
        
        welcomeText.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        welcomeText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        welcomeText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        instructionsText.topAnchor.constraint(equalTo: welcomeText.centerYAnchor, constant: 20).isActive = true
        instructionsText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        instructionsText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
}
