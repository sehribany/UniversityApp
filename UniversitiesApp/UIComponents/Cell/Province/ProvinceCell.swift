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
    
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        addView()
        addImageIcon()
        addProvinceLabel()
    }
    
    private func addView(){
        addSubview(cellView)
        cellView.edgesToSuperview()
    }
    
    private func addImageIcon(){
        cellView.addSubview(iconImage)
        //addSubview(iconImage)
        //iconImage.leadingToSuperview().constant = 20
        //iconImage.centerYToSuperview()
    }

    private func addProvinceLabel(){
        cellView.addSubview(provinceLabel)
        //addSubview(provinceLabel)
        //provinceLabel.leadingToTrailing(of: iconImage).constant = 10
        //provinceLabel.centerYToSuperview()
    }
        
    public func set(viewModel: ProvinceCellProtocol){
        self.viewModel = viewModel
        provinceLabel.text = viewModel.province.province
        if viewModel.province.universities.isEmpty{
            iconImage.image = nil
        }else{
            iconImage.image = UIImage(named: "icPlus")
        }
    }
}
