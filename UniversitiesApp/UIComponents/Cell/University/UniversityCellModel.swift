//
//  UniversityCellModel.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 20.04.2024.
//

import Foundation

protocol UniversityCellDataSource: AnyObject{
    var university: [UniversityDetail] { get }
}

protocol UniversityCellEventSource: AnyObject{}

protocol UniversityCellProtocol: UniversityCellDataSource, UniversityCellEventSource{}

final class UniversityCellModel: UniversityCellProtocol{
    
    var university: [UniversityDetail]
    
    init(university: [UniversityDetail]) {
        self.university = university
    }
}
