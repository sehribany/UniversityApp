//
//  localizableExtensions.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 29.03.2024.
//
import Foundation

func localizedString(_ key: String) -> String {
    return NSLocalizedString(key, tableName: "Localizable", bundle: .main, value: "", comment: "")
}
