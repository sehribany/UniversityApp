//
//  MainTabBarController.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 13.04.2024.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureNav()
        changeRadiusOfTabBar()
    }
    
    private func configureTabBar(){
        delegate = self

        let universityViewController = UniversityViewController()
        let favoriteViewController = FavoriteViewController()
            
        universityViewController.tabBarItem = UITabBarItem(title: "Universities", image: UIImage(named: "icUniversity"), selectedImage: nil)
        favoriteViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "icFavorite"), selectedImage: nil)
                
        viewControllers = [universityViewController, favoriteViewController].map {
            UINavigationController(rootViewController: $0)
        }
    }
    
    private func configureNav(){
        navigationItem.hidesBackButton = true
        if let selectedViewController = selectedViewController {
            navigationItem.title = selectedViewController.tabBarItem.title
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        navigationItem.title = viewController.tabBarItem.title
    }
}

//MARK: -Custom Tab Bar
extension MainTabBarController{
    private func changeRadiusOfTabBar(){
        tabBar.tintColor       = .appBlack
        tabBar.backgroundColor = .appYellow
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = true
        tabBar.layer.cornerRadius  = 30
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.appGray.cgColor
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
