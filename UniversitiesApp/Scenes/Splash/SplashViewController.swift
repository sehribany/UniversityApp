//
//  SplashViewController.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 13.04.2024.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    private let animationView: LottieAnimationView = {
        var animation = LottieAnimationView()
        animation = .init(name: "e")
        animation.loopMode = .autoReverse
        animation.animationSpeed = 0.7
        animation.contentMode = .scaleAspectFit
        return animation
    }()
    
    private let buttonanimationView: LottieAnimationView = {
        var animation = LottieAnimationView()
        animation = .init(name: "animationButton")
        animation.loopMode = .loop
        animation.contentMode = .scaleAspectFit
        return animation
    }()
    
    let viewModel = SplashViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appWhite
        addSubView()
        viewModel.fetchData()
        subscribeViewModelEvents()
    }
    
    private func subscribeViewModelEvents() {
        viewModel.didSuccessFetchProvince = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                self.buttonanimationView.stop()
                self.buttonanimationView.isUserInteractionEnabled = true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleAnimationTap))
                buttonanimationView.addGestureRecognizer(tapGesture)
            }
        }
        
        viewModel.didFailFetchProvince = { [weak self] error in
            guard let self = self else { return }
            self.buttonanimationView.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
}

//MARK: -UILayout
extension SplashViewController{
    private func addSubView(){
        addAnimation()
        addButton()
    }
    
    private func addAnimation(){
        view.addSubview(animationView)
        animationView.edgesToSuperview(excluding: .bottom)
        animationView.bottomToSuperview().constant = -150
        animationView.play()
    }

    private func addButton(){
        view.addSubview(buttonanimationView)
        buttonanimationView.edgesToSuperview(excluding: .top)
        buttonanimationView.topToBottom(of: animationView)
        buttonanimationView.play()
    }
}

// MARK: -Actions
extension SplashViewController {
    @objc func handleAnimationTap() {
        let nextViewController = UniversityViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
