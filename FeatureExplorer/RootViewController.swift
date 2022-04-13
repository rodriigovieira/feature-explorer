//
//  RootViewController.swift
//  FeatureExplorer
//
//  Created by Rodrigo Vieira on 04/04/22.
//

import UIKit

class RootViewController: UIViewController {
    var boldedLabel: UILabel = {
        var label = UILabel()

        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Welcome to the Feature Explorer!"

        return label
    }()

    var instructionsLabel: UILabel = {
        var label = UILabel()

        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "Please swipe left to see all the features that this project has to offer."
        label.numberOfLines = 2
        label.textAlignment = .center

        return label
    }()

    var onboardingImageView: UIView = {
        var imageView = UIImageView(image: Images.onboardingImage1)
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    var previousButton: UIButton = {
        var button = UIButton(type: .system)

        button.setTitle("Prev", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.green, for: .normal)

        return button
    }()

    var nextButton: UIButton = {
        var button = UIButton(type: .system)

        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.red, for: .normal)

        return button
    }()

    var pageController: UIPageControl = {
        var pc = UIPageControl()

        pc.numberOfPages = 4
        pc.pageIndicatorTintColor = .red
        pc.tintColor = .systemPink

        return pc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        configureSubViews()
        setLabelsConstraints()
        setImageLayoutConstraints()
        addControlsStackView()
    }

    func configureSubViews() {
        view.addSubview(boldedLabel)
        view.addSubview(instructionsLabel)
        view.addSubview(onboardingImageView)
    }

    func addControlsStackView() {
        let controlsStackView = UIStackView(arrangedSubviews: [previousButton, pageController, nextButton])
        controlsStackView.distribution = .fillEqually

        view.addSubview(controlsStackView)

        controlsStackView.translatesAutoresizingMaskIntoConstraints = false

        controlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        controlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        controlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        controlsStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    func setImageLayoutConstraints() {
        // A container that's half of the view's height
        // will hold the image - the image will be placed
        // in its middle, so that when the screen rotates,
        // it'll be positioned proportionally to the view's height
        
        let holderContainer = UIView()
        
        view.addSubview(holderContainer)
        
        holderContainer.translatesAutoresizingMaskIntoConstraints = false
        
        holderContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        holderContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        holderContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
               
        onboardingImageView.translatesAutoresizingMaskIntoConstraints = false
        
        onboardingImageView.centerXAnchor.constraint(equalTo: holderContainer.centerXAnchor).isActive = true
        onboardingImageView.centerYAnchor.constraint(equalTo: holderContainer.centerYAnchor).isActive = true
        onboardingImageView.heightAnchor.constraint(equalTo: holderContainer.heightAnchor, multiplier: 0.5).isActive = true
    }

    func setLabelsConstraints() {
        boldedLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false

        boldedLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        boldedLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true

        instructionsLabel.topAnchor.constraint(equalTo: boldedLabel.bottomAnchor, constant: 20).isActive = true
        instructionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        instructionsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        instructionsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
}
