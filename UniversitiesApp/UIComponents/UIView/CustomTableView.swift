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
        tableView.backgroundColor = .appWhite
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
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
        tableView.edgesToSuperview()
    }
}
