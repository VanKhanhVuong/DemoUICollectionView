//
//  DetailViewController.swift
//  DemoUICollectionView
//
//  Created by admin on 22/03/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    let detailViewModel = DetailViewModel()
    let utils = Utils()
    
    fileprivate let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    fileprivate let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    fileprivate let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    fileprivate let rateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    fileprivate let productNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let productDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = "Detail"
        view.backgroundColor = .white
        
        detailViewModel.delegate = self
        detailViewModel.getData()
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        [rateLabel, productImageView, productNameLabel, productDetailLabel, priceLabel].forEach { item in
            contentView.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // Set constraints
        let layoutGuide = view.safeAreaLayoutGuide
        scrollView.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: 0).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        
        productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        productImageView.heightAnchor.constraint(equalTo: layoutGuide.heightAnchor, multiplier: 1/3).isActive = true
        productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor, constant: 0).isActive = true
        productImageView.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor, constant: 0).isActive = true
        
        rateLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 30).isActive = true
        rateLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10).isActive = true
        rateLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10).isActive = true
        
        productNameLabel.topAnchor.constraint(equalTo: rateLabel.bottomAnchor, constant: 20).isActive = true
        productNameLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10).isActive = true
        productNameLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10).isActive = true
        productNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        
        productDetailLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 5).isActive = true
        productDetailLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10).isActive = true
        productDetailLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10).isActive = true
        productDetailLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 22).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: productDetailLabel.bottomAnchor, constant: 5).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10).isActive = true
        priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10).isActive = true
        priceLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
    }
}

extension DetailViewController: DetailViewModelEvents {
    func gotData() {
        DispatchQueue.main.async {
            self.productImageView.setImageWithUrl(url: self.detailViewModel.itemProduct.image)
            self.rateLabel.attributedText = self.utils.changeColorText(number: self.detailViewModel.itemProduct.rate, color: .orange)
            self.productNameLabel.text = "Product name:\n" + self.detailViewModel.itemProduct.name
            self.productDetailLabel.text = "Detail:\n" + self.detailViewModel.itemProduct.detail
            self.priceLabel.text = "Price:\n$ \(self.detailViewModel.itemProduct.price)"
        }
    }
}
