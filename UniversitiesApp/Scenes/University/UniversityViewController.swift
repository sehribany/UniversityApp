//
//  UniversityViewController.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 13.04.2024.
//

import UIKit
import TinyConstraints

class UniversityViewController: UIViewController {
    
    private let iconButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "icexpandcollapse")?.resize(to: .init(width: 40, height: 40))
            .withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(iconButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let customTableView = CustomTableView()
    var viewModel = SplashViewModel()
    
    var expandedProvinceSections  = Set<Int>()
    var expandedUniversityDetails = Set<IndexPath>()
    
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
    
    @objc private func iconButtonTapped() {
        expandedProvinceSections.removeAll()
        expandedUniversityDetails.removeAll()
        customTableView.tableView.reloadData()
    }
}

//MARK: - UILayout and Configure
extension UniversityViewController{
    private func addSubViews(){
        addTableView()
        addButton()
    }
    
    private func addTableView(){
        view.addSubview(customTableView)
        customTableView.edgesToSuperview(excluding: .top)
        customTableView.topToSuperview().constant = 80
    }
    
    private func addButton(){
        view.addSubview(iconButton)
        iconButton.bottomToSuperview().constant = -20
        iconButton.trailingToSuperview().constant = -20
    }
    
    private func configure(){
        view.backgroundColor = . appWhite
        navigationItem.title = "Universities"
        navigationItem.titleView?.tintColor = .appBlack
        let favoriteButton = UIBarButtonItem(image: UIImage(named: "icFavorite"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
        navigationItem.hidesBackButton = true
        customTableView.tableView.dataSource = self
        customTableView.tableView.delegate   = self
        customTableView.tableView.register(ProvinceCell.self, forCellReuseIdentifier: ProvinceCell.identifier)
        customTableView.tableView.register(UniversityCell.self, forCellReuseIdentifier: UniversityCell.identifier)
        customTableView.tableView.register(DetailCell.self, forCellReuseIdentifier: DetailCell.identifier)
    }
    
    @objc private func favoriteButtonTapped() {
        navigationController?.pushViewController(FavoriteViewController(), animated: true)
    }
}
//MARK: -UITableViewDataSource & UITableViewDelegate
extension UniversityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfItemsAt(section: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let baseCount = 1
        if expandedProvinceSections.contains(section) {
            let province = viewModel.cellItemAt(indexPath: IndexPath(row: section, section: 0)).province
            var total = baseCount + province.universities.count
            province.universities.enumerated().forEach { index, _ in
                let detailIndexPath = IndexPath(row: index, section: section)
                if expandedUniversityDetails.contains(detailIndexPath) {
                    total += 1
                }
            }
            return total
        }
        return baseCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProvinceCell.identifier, for: indexPath) as! ProvinceCell
            cell.backgroundColor = .appYellow
            let cellItem = viewModel.cellItemAt(indexPath: IndexPath(row: indexPath.section, section: 0))
            let isSelected = expandedProvinceSections.contains(indexPath.section)
            cell.set(viewModel: cellItem, isSelected: isSelected)
            return cell
        } else {
            let province = viewModel.cellItemAt(indexPath: IndexPath(row: indexPath.section, section: 0)).province
            var universityCount = 0
            for i in 0..<province.universities.count {
                let universityIndexPath = IndexPath(row: i, section: indexPath.section)
                if indexPath.row == 1 + universityCount {
                    let cell = tableView.dequeueReusableCell(withIdentifier: UniversityCell.identifier, for: indexPath) as! UniversityCell
                    cell.backgroundColor = .appYellow.withAlphaComponent(0.9)
                    let universityModel = UniversityCellModel(university: [province.universities[i]])
                    let isSelected = expandedUniversityDetails.contains(universityIndexPath)
                    cell.set(viewModel: universityModel, isSelected: isSelected)
                    return cell
                }
                universityCount += 1
                if expandedUniversityDetails.contains(universityIndexPath) {
                    if indexPath.row == 1 + universityCount {
                        let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath) as! DetailCell
                        cell.backgroundColor = .appWhite
                        cell.delegate = self
                        let detailModel = DetailCellModel(detail: [province.universities[i]])
                        cell.set(viewModel: detailModel)
                        return cell
                    }
                    universityCount += 1
                }
            }
        }
            fatalError("Unexpected IndexPath")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if expandedProvinceSections.contains(indexPath.section) {
                expandedProvinceSections.remove(indexPath.section)
                expandedUniversityDetails = expandedUniversityDetails.filter { $0.section != indexPath.section }
            } else {
                expandedProvinceSections.insert(indexPath.section)
            }
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        }else {
            let province = viewModel.cellItemAt(indexPath: IndexPath(row: indexPath.section, section: 0)).province
            var currentRow = 1
            for i in 0..<province.universities.count {
                if indexPath.row == currentRow {
                    let universityIndexPath = IndexPath(row: i, section: indexPath.section)
                    if expandedUniversityDetails.contains(universityIndexPath) {
                        expandedUniversityDetails.remove(universityIndexPath)
                    } else {
                        expandedUniversityDetails = expandedUniversityDetails.filter { $0.section != indexPath.section }
                        expandedUniversityDetails.insert(universityIndexPath)
                    }
                    
                    if let cell = tableView.cellForRow(at: indexPath) as? UniversityCell, cell.iconImagePlus.image != nil {
                        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
                    }
                    break
                }
                currentRow += 1
                if expandedUniversityDetails.contains(IndexPath(row: i, section: indexPath.section)) {
                    currentRow += 1
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
//MARK: - DetailCellDelegate
extension UniversityViewController: DetailCellDelegate {
    
    func detailCellDidTapPhone(_ cell: DetailCell, phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func detailCellDidTapWebsite(_ cell: DetailCell, webSite websiteURL: String, navTitle: String) {
        let webViewController = WebViewController()
        webViewController.websiteURL = websiteURL
        webViewController.universityName = navTitle
        navigationController?.pushViewController(webViewController, animated: true)
    }
}
