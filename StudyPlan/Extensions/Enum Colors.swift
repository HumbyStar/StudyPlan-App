//
//  Enum Colors.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 17/02/23.
//

import UIKit

extension Colors {
    var value: UIColor {
        get {
            switch self {
            case .black:
                return .black
            case .green:
                return .green
            case .red:
                return .red
            case .yellow:
                return .yellow
            case .purple:
                return .purple
            case .orange:
                return .orange
            }
        }
    }
}
