//
//  ProductCell.swift
//  DemoUICollectionView
//
//  Created by admin on 22/03/2022.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    let utils = Utils()
    fileprivate let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    fileprivate let productNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    fileprivate let detailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    fileprivate let rateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [productImageView, productNameLabel, detailLabel, rateLabel].forEach { item in
            contentView.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.black.cgColor
        
        // Set constraints
        productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        productImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
        productImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor, constant: 0).isActive = true
        
        productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 5).isActive = true
        productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        productNameLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        detailLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 0).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        
        rateLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 0).isActive = true
        rateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        rateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        rateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(product: Product) {
        productImageView.setImageWithUrl(url: product.image)
        productNameLabel.text = product.name
        detailLabel.text = "$ \(product.price)"
        rateLabel.attributedText = utils.changeColorText(number: product.rate, color: .orange)
    }
}
