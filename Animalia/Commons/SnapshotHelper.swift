//
//  SnapshotHelper.swift
//  Animalia
//
//  Created by Tiara H on 30/06/24.
//

import Foundation
import UIKit
import SwiftUI

class SnapshotHelper: NSObject {
    
    func share(image: UIImage, from viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        viewController.present(activityViewController, animated: true, completion: nil)
    }
}
