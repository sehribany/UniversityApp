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
    
    private let provinceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appBlack
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    weak var viewModel: ProvinceCellProtocol?
    
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
extension ProvinceCell{
    private func addSubViews(){
        addImageIcon()
        addProvinceLabel()
    }
    
    private func addImageIcon(){
        addSubview(iconImage)
        iconImage.leadingToSuperview().constant = 20
        iconImage.centerYToSuperview()
    }

    private func addProvinceLabel(){
        addSubview(provinceLabel)
        provinceLabel.leadingToSuperview().constant = 55
        provinceLabel.centerYToSuperview()
    }
        
    public func set(viewModel: ProvinceCellProtocol, isSelected: Bool){
        self.viewModel = viewModel
        provinceLabel.text = viewModel.province.province
        if viewModel.province.universities.isEmpty{
            iconImage.image = nil
        }else{
            iconImage.image = isSelected ? UIImage(named: "icMinus") : UIImage(named: "icPlus")
        }
    }
}
