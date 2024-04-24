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
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    weak var viewModel : UniversityCellProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
extension UniversityCell{
    private func addSubViews(){
        addImageIcons()
        addProvinceLabel()
        addImageIcon()
    }
    
    private func addImageIcons(){
        addSubview(iconImagePlus)
        iconImagePlus.leadingToSuperview().constant = 20
        iconImagePlus.centerYToSuperview()
    }

    private func addProvinceLabel(){
        addSubview(universityLabel)
        universityLabel.leadingToSuperview().constant = 50
        universityLabel.trailingToSuperview().constant = -80
        universityLabel.centerYToSuperview()
    }
    
    private func addImageIcon(){
        addSubview(iconImage)
        iconImage.trailingToSuperview().constant = -23
        iconImage.centerYToSuperview()
    }
    
    public func set(viewModel: UniversityCellProtocol){
        self.viewModel = viewModel
        let university = viewModel.university
        universityLabel.text =  university.map({ $0.name}).joined()

        let additionalInfoExists = university.map({ $0.adress}).contains("-") && university.map({ $0.email}).contains("-") && university.map({ $0.fax}).contains("-") && university.map({ $0.phone}).contains("-") && university.map({ $0.rector}).contains("-") && university.map({ $0.website}).contains("-")
            
        iconImage.image = UIImage(named: "icFavorite")
        
        if !additionalInfoExists {
            iconImagePlus.image = UIImage(named: "icPlus")
        } else {
            iconImagePlus.image = nil
        }
    }
}
