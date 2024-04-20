//
//  Datas.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 12.04.2024.
//

struct Datas: Codable {
    let currentPage, totalPage, total, itemPerPage: Int
    let pageSize: Int
    let data: [University]
}
