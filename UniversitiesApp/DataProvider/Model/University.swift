//
//  University.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 12.04.2024.
//

struct University: Codable {
    let id: Int
    let province: String
    let universities: [UniversityDetail]
}
