//
//  CustomTableView.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 20.04.2024.
//

import UIKit

class CustomTableView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.rowHeight = 70
        
        tableView.separatorColor = UIColor.appWhite
        //tableView.separatorInset = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 11)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubView(){
        addSubview(tableView)
        tableView.topToSuperview()
        tableView.bottomToSuperview()
        tableView.leadingToSuperview().constant = 10
        tableView.trailingToSuperview().constant = -15
    }
}
