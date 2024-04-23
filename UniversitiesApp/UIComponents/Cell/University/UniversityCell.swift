//
//  UniversityCell.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 20.04.2024.
//

import UIKit

class UniversityCell: UITableViewCell {
    static let identifier = "UniversityCell"
    
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
        addProvinceLabel()
        addImageIcon()
    }

    private func addProvinceLabel(){
        addSubview(universityLabel)
        universityLabel.leadingToSuperview().constant = 52
        universityLabel.centerYToSuperview()
    }
    
    private func addImageIcon(){
        addSubview(iconImage)
        iconImage.trailingToSuperview().constant = -23
        iconImage.centerYToSuperview()
    }
    
    public func set(viewModel: UniversityCellProtocol){
        guard let viewModel = viewModel.university.first else{ return}
        universityLabel.text = viewModel.name
        iconImage.image = UIImage(named: "icFavorite")
    }
}
