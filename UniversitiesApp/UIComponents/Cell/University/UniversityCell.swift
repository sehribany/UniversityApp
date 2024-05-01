//
//  UniversityCell.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 20.04.2024.
//

import UIKit

class UniversityCell: UITableViewCell {
    static let identifier = "UniversityCell"
    
    let iconImagePlus: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let universityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appBlack
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(named:"icFavorite"), for: .normal)
        button.height(40)
        button.width(40)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var isFavorite: Bool = false {
        didSet {
            let imageName = isFavorite ? "icFavoriteFill" : "icFavorite"
            favoriteButton.setImage(UIImage(named: imageName), for: .normal)
        }
    }
    
    weak var viewModel : UniversityCellProtocol?
    weak var viewController: UIViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc private func favoriteButtonTapped() {
        isFavorite.toggle()
        let imageName = isFavorite ? "icFavoriteFill" : "icFavorite"
        favoriteButton.setImage(UIImage(named: imageName), for: .normal)
    }
}

//MARK: - UILayout and Set
extension UniversityCell{
    private func addSubViews(){
        addImageIcons()
        addProvinceLabel()
        addFavoriteButton()
    }
    
    private func addImageIcons(){
        contentView.addSubview(iconImagePlus)
        iconImagePlus.leadingToSuperview().constant = 20
        iconImagePlus.centerYToSuperview()
    }

    private func addProvinceLabel(){
        contentView.addSubview(universityLabel)
        universityLabel.leadingToSuperview().constant = 50
        universityLabel.trailingToSuperview().constant = -80
        universityLabel.centerYToSuperview()
    }
    
    private func addFavoriteButton(){
        contentView.addSubview(favoriteButton)
        favoriteButton.trailingToSuperview().constant = -23
        favoriteButton.centerYToSuperview()
    }
    
    public func set(viewModel: UniversityCellProtocol, isSelected: Bool){
        self.viewModel = viewModel
        let university = viewModel.university
        universityLabel.text =  university.map({$0.name}).joined()

        let additionalInfoExists = university.map({ $0.adress}).contains("-") && university.map({ $0.email}).contains("-") && university.map({ $0.fax}).contains("-") && university.map({ $0.phone}).contains("-") && university.map({ $0.rector}).contains("-") && university.map({ $0.website}).contains("-")
            
        if !additionalInfoExists {
            iconImagePlus.image = isSelected ? UIImage(named: "icMinus") : UIImage(named: "icPlus")
        } else {
            iconImagePlus.image = nil
        }
    }
}
