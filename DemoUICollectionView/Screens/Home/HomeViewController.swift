//
//  HomeViewController.swift
//  DemoUICollectionView
//
//  Created by admin on 22/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeViewModel = HomeViewModel()
    
    fileprivate let newsSearchBar: UISearchBar = {
        let searchbar = UISearchBar()
        return searchbar
    }()
    
    fileprivate let newsCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(cellType: NewsCell.self)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.title = "Home"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        
        view.backgroundColor = .white
        
        homeViewModel.delegate = self
        newsSearchBar.delegate = self
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        
        [newsSearchBar, newsCollectionView].forEach { item in
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // Set constraint
        let layoutGuide = view.safeAreaLayoutGuide
        
        newsSearchBar.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 0).isActive = true
        newsSearchBar.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10).isActive = true
        newsSearchBar.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10).isActive = true
        newsSearchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        newsCollectionView.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor, constant: 0).isActive = true
        newsCollectionView.topAnchor.constraint(equalTo: newsSearchBar.bottomAnchor, constant: 0).isActive = true
        newsCollectionView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: 0).isActive = true
        newsCollectionView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 0).isActive = true
        newsCollectionView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: 0).isActive = true
    }
    
    private func showDetailNews(index: Int) {
        let detailViewControllertail = DetailViewController()
        detailViewControllertail.detailViewModel.itemNews = homeViewModel.listNews[index]
        navigationController?.pushViewController(detailViewControllertail, animated: true)
    }
    
    private func clearSearchBar() {
        homeViewModel.listNews.removeAll()
        newsCollectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetailNews(index: indexPath.item)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (newsCollectionView.frame.width - 45) / 2, height: (newsCollectionView.frame.height - 30) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.listNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(with: NewsCell.self, for: indexPath)
        itemCell.configCell(new: homeViewModel.listNews[indexPath.item])
        return itemCell
    }
}

extension HomeViewController: HomeViewModelEvents {
    func gotDataNews() {
        DispatchQueue.main.async {
            self.newsCollectionView.reloadData()
        }
    }
    
    func gotError() { }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 1)
    }

    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            clearSearchBar()
            return
        }
        homeViewModel.getApi(query: query)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
