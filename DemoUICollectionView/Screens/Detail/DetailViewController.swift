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
    
    fileprivate let relatedNewsCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(cellType: RelatedNewsCell.self)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = detailTilte
        view.backgroundColor = .white
        
        detailViewModel.delegate = self
        relatedNewsCollectionView.delegate = self
        relatedNewsCollectionView.dataSource = self
        detailViewModel.getData()
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        [newsImageView, titleLabel, descriptionLabel, sourceLabel, authorLabel, relatedNewsCollectionView].forEach { item in
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
        sourceLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        relatedNewsCollectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        relatedNewsCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 0).isActive = true
        relatedNewsCollectionView.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 5).isActive = true
        relatedNewsCollectionView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10).isActive = true
        relatedNewsCollectionView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10).isActive = true
        relatedNewsCollectionView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    private func showNews(index: Int) {
        detailViewModel.clearData()
        detailViewModel.itemNews = detailViewModel.listNews[index]
        detailViewModel.listNews.remove(at: index)
        detailViewModel.getData()
        detailViewModel.refreshList()
    }
}

extension DetailViewController: DetailViewModelEvents {
    func refreshData() {
        DispatchQueue.main.async {
            self.relatedNewsCollectionView.reloadData()
        }
    }
    
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
            
            if !self.detailViewModel.listNews.isEmpty {
                self.sourceLabel.text = "Source:\n" + source + "\n\nRelated News:"
            } else {
                self.sourceLabel.text = "Source:\n" + source
            }
        }
    }
}

extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showNews(index: indexPath.item)
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: relatedNewsCollectionView.frame.width, height: relatedNewsCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailViewModel.listNews.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(with: RelatedNewsCell.self, for: indexPath)
        itemCell.configCell(new: detailViewModel.listNews[indexPath.item])
        return itemCell
    }
}

