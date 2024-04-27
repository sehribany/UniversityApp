//
//  DetailCellModel.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 25.04.2024.
//

import Foundation

protocol DetailCellDataSource: AnyObject{
    var detail: [UniversityDetail] { get }
}

protocol DetailCellEventSource: AnyObject{}

protocol DetailCellProtocol: DetailCellDataSource, DetailCellEventSource{}

final class DetailCellModel: DetailCellProtocol{
    var detail: [UniversityDetail]
    
    init(detail: [UniversityDetail]) {
        self.detail = detail
    }
}
