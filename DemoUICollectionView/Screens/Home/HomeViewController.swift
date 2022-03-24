//
//  HomeViewController.swift
//  DemoUICollectionView
//
//  Created by admin on 22/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeViewModel = HomeViewModel()
    let reachability = Reachability()
    
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
    
    fileprivate let connectStatusView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        checkInternet()
    }
    
    private func checkInternet() {
        if !reachability.isConnectedToNetwork() {
            showAlert(message: textDisconnet)
            showRed()
        } else {
            showGreen()
        }
    }
    
    private func showGreen() {
        connectStatusView.backgroundColor = .green
        perform(#selector(showWhite(_:)), with: connectStatusView, afterDelay: 3)
    }
    
    private func showRed() {
        connectStatusView.backgroundColor = .red
        perform(#selector(showWhite(_:)), with: connectStatusView, afterDelay: 3)
    }
    
    @objc func showWhite(_ view: UIView) {
        connectStatusView.backgroundColor = .white
    }
    
    private func setupView() {
        self.title = homeTitle
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: whiteSpaces, style: .done, target: nil, action: nil)
        
        view.backgroundColor = .white
        
        homeViewModel.delegate = self
        newsSearchBar.delegate = self
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        
        [newsSearchBar, newsCollectionView, connectStatusView].forEach { item in
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // Set constraint
        let layoutGuide = view.safeAreaLayoutGuide
        
        newsSearchBar.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 0).isActive = true
        newsSearchBar.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 10).isActive = true
        newsSearchBar.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -10).isActive = true
        newsSearchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        connectStatusView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        connectStatusView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 0).isActive = true
        connectStatusView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: 0).isActive = true
        connectStatusView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: 0).isActive = true
        
        newsCollectionView.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor, constant: 0).isActive = true
        newsCollectionView.topAnchor.constraint(equalTo: newsSearchBar.bottomAnchor, constant: 0).isActive = true
        newsCollectionView.bottomAnchor.constraint(equalTo: connectStatusView.bottomAnchor, constant: 0).isActive = true
        newsCollectionView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 0).isActive = true
        newsCollectionView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: 0).isActive = true
        
    }
    
    private func showDetailNews(index: Int) {
        let detailViewController = DetailViewController()
        detailViewController.detailViewModel.itemNews = homeViewModel.listNews[index]
        detailViewController.detailViewModel.listNews = homeViewModel.listNews
        detailViewController.detailViewModel.listNews.remove(at: index)
        navigationController?.pushViewController(detailViewController, animated: true)
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
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != whiteSpaces else {
            clearSearchBar()
            return
        }
        
        if reachability.isConnectedToNetwork() {
            homeViewModel.getApi(query: query)
        } else {
            showAlert(message: textDisconnet)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
