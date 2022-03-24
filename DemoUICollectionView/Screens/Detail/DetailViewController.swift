//
//  DetailViewController.swift
//  DemoUICollectionView
//
//  Created by admin on 22/03/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    let detailViewModel = DetailViewModel()
    
    fileprivate let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    fileprivate let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    fileprivate let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let sourceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = detailTilte
        view.backgroundColor = .white
        
        detailViewModel.delegate = self
        detailViewModel.getData()
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        [newsImageView, titleLabel, descriptionLabel, sourceLabel, authorLabel].forEach { item in
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
        
        newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        newsImageView.heightAnchor.constraint(equalTo: layoutGuide.heightAnchor, multiplier: 1/3).isActive = true
        newsImageView.widthAnchor.constraint(equalTo: newsImageView.heightAnchor, constant: 0).isActive = true
        newsImageView.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor, constant: 0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 22).isActive = true
        
        authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10).isActive = true
        authorLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        sourceLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5).isActive = true
        sourceLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10).isActive = true
        sourceLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10).isActive = true
        sourceLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10).isActive = true
        sourceLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
    }
}

extension DetailViewController: DetailViewModelEvents {
    func gotData() {
        DispatchQueue.main.async {
            let image = self.detailViewModel.itemNews.urlToImage ?? whiteSpaces
            let title = self.detailViewModel.itemNews.title ?? whiteSpaces
            let description = self.detailViewModel.itemNews.description ?? whiteSpaces
            let author = self.detailViewModel.itemNews.author ?? whiteSpaces
            let source = self.detailViewModel.itemNews.source?.name ?? whiteSpaces
            
            self.newsImageView.setImageWithUrl(url: image)
            self.titleLabel.text = "Title:\n" + title + "\n"
            self.descriptionLabel.text = "Description:\n" + description + "\n"
            self.authorLabel.text = "Author:\n" + author + "\n"
            self.sourceLabel.text = "Source:\n" + source
        }
    }
}
