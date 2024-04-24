//
//  UniversityViewController.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 13.04.2024.
//

import UIKit
import TinyConstraints

class UniversityViewController: UIViewController {
    let customTableView = CustomTableView()
    var viewModel = SplashViewModel()
    var expandedSections = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubViews()
        viewModel.fetchData()
        subscribeViewModelEvents()
    }
    
    private func subscribeViewModelEvents() {
        viewModel.didSuccessFetchProvince = { [weak self] in
            self?.customTableView.tableView.reloadData()
        }
    }
}

//MARK: - UILayout and Configure
extension UniversityViewController{
    private func addSubViews(){
        addTableView()
    }
    
    private func addTableView(){
        view.addSubview(customTableView)
        customTableView.edgesToSuperview()
    }
    
    private func configure(){
        view.backgroundColor = .appWhite
        customTableView.tableView.dataSource = self
        customTableView.tableView.delegate   = self
        
        customTableView.tableView.register(ProvinceCell.self, forCellReuseIdentifier: ProvinceCell.identifier)
        customTableView.tableView.register(UniversityCell.self, forCellReuseIdentifier: UniversityCell.identifier)
    }
}
//MARK: -UITableViewDataSource & UITableViewDelegate
extension UniversityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfItemsAt(section: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if expandedSections.contains(section) {
            return 1 + viewModel.cellItemAt(indexPath: IndexPath(row: section, section: 0)).province.universities.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProvinceCell.identifier, for: indexPath) as! ProvinceCell
            cell.backgroundColor = .appYellow.withAlphaComponent(0.9)
            let cellItem = viewModel.cellItemAt(indexPath: IndexPath(row: indexPath.section, section: 0))
            cell.set(viewModel: cellItem)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: UniversityCell.identifier, for: indexPath) as! UniversityCell
            let provinceItem = viewModel.cellItemAt(indexPath: IndexPath(row: indexPath.section, section: 0))
            let universityItem = provinceItem.province.universities[indexPath.row - 1]
            let universityModel = UniversityCellModel(university: [universityItem])
            cell.set(viewModel: universityModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if expandedSections.contains(indexPath.section) {
                expandedSections.remove(indexPath.section)
            } else {
                expandedSections.insert(indexPath.section)
            }
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
            if let cell = tableView.cellForRow(at: indexPath) as? ProvinceCell {
                if expandedSections.contains(indexPath.section) {
                    cell.iconImage.image = UIImage(named: "icMinus")
                } else {
                    cell.iconImage.image = UIImage(named: "icPlus")
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > customTableView.tableView.contentSize.height - 100 - scrollView.frame.size.height && viewModel.isPagingEnabled && viewModel.isRequestEnabled{
            viewModel.fetchData()
        }
    }
}
