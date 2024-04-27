//
//  DetailCell.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 25.04.2024.
//

import UIKit

protocol DetailCellDelegate: AnyObject {
    func detailCellDidTapPhone(_ cell: DetailCell, phoneNumber: String)
    func detailCellDidTapWebsite(_ cell: DetailCell, webSite: String, navTitle: String)
}

class DetailCell: UITableViewCell {
    
    static let identifier = "DetailCell"
    
    var title: String = ""
    
    weak var delegate: DetailCellDelegate?
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func addDetailButton(withText text: String, isTappable: Bool = false, action: Selector?) {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        if isTappable, let action = action {
            button.addTarget(self, action: action, for: .touchUpInside)
        }
        stackView.addArrangedSubview(button)
    }
    
    weak var viewModel : DetailCellProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: - UILayout and Set
extension DetailCell{
    private func addSubViews(){
        addStackView()
    }

    private func addStackView(){
        contentView.addSubview(stackView)
        stackView.leadingToSuperview().constant = 25
        stackView.trailingToSuperview().constant = -20
        stackView.topToSuperview().constant = 10
        stackView.bottomToSuperview().constant = -10
    }

    public func set(viewModel: DetailCellProtocol){
        self.viewModel = viewModel
        let university = viewModel.detail
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        university.forEach { details in
            addDetailButton(withText: "Phone: \(details.phone)", isTappable: true, action: #selector(phoneTapped))
            addDetailButton(withText: "Fax: \(details.fax)",isTappable: false, action: nil)
            addDetailButton(withText: "Website: \(details.website)", isTappable: true, action: #selector(websiteTapped))
            addDetailButton(withText: "Address: \(details.adress)",isTappable: false, action: nil)
            addDetailButton(withText: "Rector: \(details.rector)", isTappable: false, action: nil)
            title = details.name
        }
    }
}

//MARK: -ACTION
extension DetailCell{
    @objc func phoneTapped(_ sender: UIButton) {
        if let phone = sender.title(for: .normal)?.split(separator: ":").map(String.init).last?.trimmingCharacters(in: .whitespaces) {
            print(phone)
            delegate?.detailCellDidTapPhone(self, phoneNumber: phone)
        }
    }
        
    @objc func websiteTapped(_ sender: UIButton) {
        if let website = sender.title(for: .normal)?.split(separator: " ").last?.trimmingCharacters(in: .whitespaces),
           !website.isEmpty {
            delegate?.detailCellDidTapWebsite(self, webSite: website, navTitle: title )
        }
    }
}
