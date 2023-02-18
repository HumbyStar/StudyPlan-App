//
//  ImagesCell.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 17/02/23.
//

import UIKit

final class ImagesCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var onUpdate:(ImagesLG) -> Void = {_ in}
    
    var choosedImage: ImagesLG? = nil  {
        didSet {
            bannerImage.image = UIImage(named: choosedImage?.rawValue ?? "")
        }
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.systemGroupedBackground : .clear
        }
    }
    
    lazy var bannerImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var btSendImage: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(nil, for: .normal)
        button.addTarget(StudyPlanViewController(), action: #selector(sendImage), for: .touchUpInside)
        return button
    }()
    
    @objc func sendImage() {
        if let image = choosedImage {
            onUpdate(image)
        }
    }
    
}

extension ImagesCollectionCell: ViewCode {
    func buildHierarchy() {
        addSubview(bannerImage)
        addSubview(btSendImage)
    }
    func setupConstrains() {
        NSLayoutConstraint.activate([
            bannerImage.topAnchor.constraint(equalTo: topAnchor),
            bannerImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            bannerImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            bannerImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            btSendImage.topAnchor.constraint(equalTo: topAnchor),
            btSendImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            btSendImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            btSendImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    func extrasFeatures() {
        backgroundColor = .clear
    }
}
