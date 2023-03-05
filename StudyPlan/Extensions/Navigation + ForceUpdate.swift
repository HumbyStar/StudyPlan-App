//
//  Navigation + ForceUpdate.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 01/03/23.
//

import UIKit

extension UINavigationController {
    func forceUpdateNavBar() {
        DispatchQueue.main.async {
            self.navigationBar.sizeToFit()
        }
    }
}
