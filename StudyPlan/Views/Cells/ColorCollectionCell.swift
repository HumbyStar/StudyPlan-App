//
//  MyCollectionCell.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 17/02/23.
//

import UIKit

final class ColorCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            configureViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var onUpdate: (Colors) -> Void = {_ in }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.systemGroupedBackground : .clear
        }
    }
    
    lazy var color: Colors = .black {
        didSet {
            btChoosedColor.backgroundColor = color.value
        }
    }
    
    lazy var btChoosedColor: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(nil, for: .normal)
        button.addTarget(StudyPlanViewController(), action: #selector(showColor), for: .touchUpInside)
        return button
    }()
    
    @objc func showColor() {
        onUpdate(color)
    }
    
}

extension ColorCollectionCell: ViewCode {
    
    func buildHierarchy() {
        addSubview(btChoosedColor)
    }
    func setupConstrains() {
        NSLayoutConstraint.activate([
            btChoosedColor.topAnchor.constraint(equalTo: self.topAnchor),
            btChoosedColor.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            btChoosedColor.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            btChoosedColor.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
}
