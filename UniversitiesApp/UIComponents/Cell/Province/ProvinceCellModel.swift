//
//  ProvinceCellModel.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 14.04.2024.
//

import Foundation

protocol ProvinceCellDataSource: AnyObject{
    var province: University { get }
}

protocol ProvinceCellEventSource: AnyObject{}

protocol ProvinceCellProtocol: ProvinceCellDataSource, ProvinceCellEventSource{}

final class ProvinceCellModel: ProvinceCellProtocol{
    var province: University
    
    init(province: University) {
        self.province = province
    }
}
