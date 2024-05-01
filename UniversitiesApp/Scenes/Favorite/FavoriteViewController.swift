//
//  FavoriteViewController.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 13.04.2024.
//

import UIKit
import WebKit

class FavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appWhite
        addSubViews()
    }
}

// MARK: -UILayout
extension FavoriteViewController{
    private func addSubViews(){
        navigationItem.title = "Favorites"

    }

}
