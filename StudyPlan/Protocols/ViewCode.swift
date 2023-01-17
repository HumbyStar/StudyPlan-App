//
//  Protocol.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 16/01/23.
//

import Foundation

protocol ViewCode {
    func viewHierarquic()
    func setContrains()
    func extraFeatures()
}

extension ViewCode {
    func setupViewCode(){
        viewHierarquic()
        setContrains()
        extraFeatures()
    }
}
