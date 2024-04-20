//
//  ProvinceCell.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 14.04.2024.
//

import UIKit
import TinyConstraints

class ProvinceCell: UITableViewCell {

    static let identifier = "ProvinceCell"
    
    private let iconBook: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icBook")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let provinceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appBlack
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    weak var viewModel : ProvinceCellProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -UILayout and Set
extension ProvinceCell{
    private func addSubViews(){
        addIcon()
        addProvinceLabel()
        addImageIcon()
    }
    
    private func addIcon(){
        addSubview(iconBook)
        iconBook.leadingToSuperview().constant = 20
        iconBook.centerYToSuperview()
    }
    private func addProvinceLabel(){
        addSubview(provinceLabel)
        provinceLabel.leadingToSuperview().constant = 52
        provinceLabel.centerYToSuperview()
    }
    
    private func addImageIcon(){
        addSubview(iconImage)
        iconImage.trailingToSuperview().constant = -23
        iconImage.centerYToSuperview()
    }
    
    public func set(viewModel: ProvinceCellProtocol){
        self.viewModel = viewModel
        provinceLabel.text = viewModel.province.province
        if !viewModel.province.universities.isEmpty{
            iconImage.image = UIImage(named: "icPlus")
        }else{
            iconImage.image = UIImage()
        }
    }
}
