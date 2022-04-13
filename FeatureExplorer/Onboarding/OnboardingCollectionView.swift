//
//  SwipingController.swift
//  FeatureExplorer
//
//  Created by Rodrigo Vieira on 04/04/22.
//

import UIKit

let reusableIdentifier = "cellId"

protocol OnboardingDelegate {
    func setCollectionViewVisible()
}

class OnboardingCollectionView: UICollectionViewController, OnboardingDelegate {
    let pages: [PageModel] = [
        PageModel(
            image: OnboardingImages.onboardingImage1,
            headlineText: "Welcome to the Feature Explorer",
            subtitleText: "Please swipe left to see all the features that this project has to offer."
        ),
        PageModel(
            image: OnboardingImages.onboardingImage2,
            headlineText: "Play with the elements!",
            subtitleText: "On this project, you are able to play with the interactive elements by dragging them. Find out the right spot to uncover more secret features."
        ),
        PageModel(
            image: OnboardingImages.onboardingImage3,
            headlineText: "Scroll as much as you want",
            subtitleText: "Feel free to scroll as much as you want, until you get tired."
        ),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(onboardingView)
        collectionView.alpha = 0
        layoutOnboardingView()
        
        collectionView.register(
            PageCell.self,
            forCellWithReuseIdentifier: reusableIdentifier
        )
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { [unowned self] _ in
            self.collectionViewLayout.invalidateLayout()
            let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
            
            self.collectionView.scrollToItem(
                at: indexPath,
                at: .centeredHorizontally,
                animated: true
            )
        } completion: { _ in
            
        }
    }
    
    // MARK: - UIKit Elements
    
    lazy private var onboardingView: OnboardingView = {
        var view = OnboardingView(frame: view.frame)
        view.bottomControlsDelegate = self
        
        return view
    }()
    
    private var previousButton: UIButton = {
        var button = UIButton(type: .system)
        
        button.setTitleColor(.systemPink, for: .normal)
        button.setTitleColor(.systemPink.withAlphaComponent(0.2), for: .disabled)
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        button.isEnabled = false
        
        return button
    }()
    
    private var nextButton: UIButton = {
        var button = UIButton(type: .system)
        
        button.setTitleColor(.red, for: .normal)
        button.setTitleColor(.red.withAlphaComponent(0.2), for: .disabled)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        var pc = UIPageControl()
        
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.pageIndicatorTintColor = .red.withAlphaComponent(0.3)
        pc.currentPageIndicatorTintColor = .red
        
        return pc
    }()
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        
        let page = Int(x / view.frame.width)
        
        pageControl.currentPage = page
        
        changeButtonTitleIfNecessary()
    }
    
    func changeButtonTitleIfNecessary() {
        if (pageControl.currentPage == pages.count - 1) {
            nextButton.setTitle("START", for: .normal)
        } else {
            nextButton.setTitle("NEXT", for: .normal)
        }
        
        if (pageControl.currentPage == 0) {
            previousButton.isEnabled = false
        } else {
            previousButton.isEnabled = true
        }
    }
    
    // MARK: - Buttons' functions
    
    @objc func handleNext() {
        let isLastPage = pageControl.currentPage == pages.count - 1
        
        if (isLastPage) {
            let homeVC = HomeViewController()
            homeVC.modalPresentationStyle = .fullScreen
            
            UserDefaults.standard.set(
                true, forKey: UserDefaultsKeys.onboardingScreenWasShown
            )
            
            return present(homeVC, animated: true)
        }
        
        let nextIndex = pageControl.currentPage + 1
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        
        collectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )
        
        changeButtonTitleIfNecessary()
    }
    
    @objc func handlePrevious() {
        let previousIndex = pageControl.currentPage - 1
        let indexPath = IndexPath(item: previousIndex, section: 0)
        pageControl.currentPage = previousIndex
        
        collectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )
        
        changeButtonTitleIfNecessary()
    }
    
    // MARK: - Layout Functions
    
    func setCollectionViewVisible() {
        self.collectionView.alpha = 1
        
        UIView.animate(withDuration: 1.5) {
            self.onboardingView.alpha = 0
        } completion: { [weak self] _ in
            self?.configureBottomControls()
        }
    }
    
    func configureBottomControls() {
        let bottomControlsStackView = UIStackView(
            arrangedSubviews: [previousButton, pageControl, nextButton]
        )
        bottomControlsStackView.distribution = .fillEqually
        
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate(
            [
                bottomControlsStackView.leadingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: 20
                ),
                bottomControlsStackView.trailingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -20
                ),
                bottomControlsStackView.bottomAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                    constant: -20
                ),
                bottomControlsStackView.heightAnchor.constraint(
                    equalToConstant: 50
                )
            ]
        )
    }
    
    func layoutOnboardingView() {
        onboardingView.translatesAutoresizingMaskIntoConstraints = false
        onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        onboardingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        onboardingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
