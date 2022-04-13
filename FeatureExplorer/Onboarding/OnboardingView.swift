//
//  OnboardingView.swift
//  FeatureExplorer
//
//  Created by Rodrigo Vieira on 10/04/22.
//

import UIKit

class OnboardingView: UIView {
    var bottomControlsDelegate: OnboardingDelegate?
    
    var onboardingImageView: UIImageView = {
        var imageView = UIImageView(image: OnboardingImages.mainOnboardingImage)
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    
    private var onboardingHeadlineLabel: UILabel = {
        var label = UILabel()
        
        label.text = "Drinkee"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.alpha = 0
        
        return label
    }()
    
    private var onboardingSubheadlineLabel: UILabel = {
        var label = UILabel()
        
        label.text = "Where you'll take your bartender skills to the next level."
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .white.withAlphaComponent(0.8)
        label.font = UIFont.systemFont(ofSize: 20)
        label.alpha = 0
        
        return label
    }()
    
    private lazy var initialOnboardingUIView: UIView = {
        var uiView = UIView(frame: frame)
        uiView.backgroundColor = .black
        
        return uiView
    }()
    
    private lazy var dismissOnboardingScreenButton: UIView = {
        var button = UIButton(type: .custom)
        
        button.alpha = 0
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.backgroundColor = .black
        button.setTitle("TAKE ME FOR A TOUR", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 5
        
        button.addTarget(
            self,
            action: #selector(dismissOnboardingView),
            for: .touchUpInside
        )
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        displayonboardingImageView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func dismissOnboardingView() {
        self.bottomControlsDelegate?.setCollectionViewVisible()
    }
    
    func displayonboardingImageView() {
        initialOnboardingUIView.frame = frame
        addSubview(initialOnboardingUIView)
        initialOnboardingUIView.addSubview(onboardingImageView)
        
        addTextAndButtonToOnboardingScreen()
        addDismissButton()
        addConstraintsToOnboardingImage()
        
        UIView.animate(withDuration: 1.5, delay: 2, options: .curveEaseIn) {
            self.onboardingImageView.alpha = 0.4
            self.onboardingHeadlineLabel.alpha = 1
            self.onboardingSubheadlineLabel.alpha = 1
            self.dismissOnboardingScreenButton.alpha = 1
        }
    }
    
    func addConstraintsToOnboardingImage() {
        onboardingImageView.translatesAutoresizingMaskIntoConstraints = false
        
        onboardingImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        onboardingImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        onboardingImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        onboardingImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func addTextAndButtonToOnboardingScreen() {
        let holderContainer = UIView()
        
        holderContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(holderContainer)
        
        NSLayoutConstraint.activate([
            holderContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            holderContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            holderContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            holderContainer.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        onboardingHeadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        onboardingSubheadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        
        initialOnboardingUIView.addSubview(onboardingHeadlineLabel)
        initialOnboardingUIView.addSubview(onboardingSubheadlineLabel)
        
        onboardingHeadlineLabel.centerYAnchor.constraint(equalTo: onboardingImageView.centerYAnchor, constant: -20).isActive = true
        onboardingHeadlineLabel.leadingAnchor.constraint(equalTo: onboardingImageView.leadingAnchor, constant: 20).isActive = true
        onboardingHeadlineLabel.trailingAnchor.constraint(equalTo: onboardingImageView.trailingAnchor, constant: -20).isActive = true
        onboardingSubheadlineLabel.topAnchor.constraint(equalTo: onboardingHeadlineLabel.bottomAnchor, constant: 20).isActive = true
        onboardingSubheadlineLabel.leadingAnchor.constraint(equalTo: onboardingImageView.leadingAnchor, constant: 20).isActive = true
        onboardingSubheadlineLabel.trailingAnchor.constraint(equalTo: onboardingImageView.trailingAnchor, constant: -20).isActive = true
    }
    
    func addDismissButton() {
        dismissOnboardingScreenButton.translatesAutoresizingMaskIntoConstraints = false
        
        initialOnboardingUIView.addSubview(dismissOnboardingScreenButton)
        
        dismissOnboardingScreenButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        dismissOnboardingScreenButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        dismissOnboardingScreenButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        dismissOnboardingScreenButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}
