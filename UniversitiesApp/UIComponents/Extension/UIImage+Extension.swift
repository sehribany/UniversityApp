//
//  UIImage+Extension.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 14.04.2024.
//

import Kingfisher
import UIKit

extension UIImage {
    func  resize(to size: CGSize, for contentMode: UIView.ContentMode? = nil) -> UIImage {
        switch contentMode {
        case .scaleAspectFit:
            return kf.resize(to: size, for: .aspectFit)
        case .scaleToFill:
            return kf.resize(to: size, for: .aspectFill)
        default:
            return kf.resize(to: size)
        }
    }
}
