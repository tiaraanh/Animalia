//
//  UIView+Extension.swift
//  Animalia
//
//  Created by Tiara H on 30/06/24.
//

import Foundation
import UIKit

extension UIView {
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
