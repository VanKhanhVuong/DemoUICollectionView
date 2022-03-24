//
//  RelatedNewsCell.swift
//  DemoUICollectionView
//
//  Created by admin on 24/03/2022.
//

import UIKit

class RelatedNewsCell: UICollectionViewCell {
    fileprivate let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [newsImageView, titleLabel].forEach { item in
            contentView.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.black.cgColor
        
        // Set constraints
        newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(new: Articles) {
        newsImageView.setImageWithUrl(url: new.urlToImage ?? whiteSpaces)
        titleLabel.text = new.title
    }
}
