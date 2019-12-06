//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

class HomeViewController: UIViewController {

    // MARK: OUTLETS
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet weak var articlesTableHeight: NSLayoutConstraint!
    @IBOutlet weak var articlesLoading: UIActivityIndicatorView!
    
    // MARK: VARIABLES
    private var presenter: HomePresenter!
    private var favoritesPresenter: FavoritesPresenter!
    private var categories: [Category] = Category.getCategories()
    private var articles: [Article] = []
}

// MARK: LIFECYCLE
extension HomeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setupLogoAsNavigationItem()
        
        presenter = HomePresenter()
        favoritesPresenter = FavoritesPresenter()
        
        categoriesCollectionView.backgroundColor = .none
        
        getArticles()
    }
}

// MARK: SEGUES
extension HomeViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let categoriesVC = segue.destination as? CategoriesViewController {
            guard let category = sender as? Category else { return }
            
            categoriesVC.articles = articles.filter { $0.categoryName == category.name }
            categoriesVC.category = category
        }
    }
}

// MARK: DELEGATES
extension HomeViewController: ArticleCellDelegate {
    
    func tappedFavoriteButton(id: Int32) {
        print(id)
    }
}

// MARK: PRESENTER
extension HomeViewController {
    
    private func getArticles() {
        articlesLoading.startAnimating()
        
        presenter.getArticles { [weak self] (response, error) in
            if let err = error {
                self?.articlesLoading.stopAnimating()
                print(err.localizedDescription)
                return
            }
            
            self?.favoritesPresenter.getFavorites { (favorites) in
                if let articles = response {
                    self?.articles = articles
                    
                    if !favorites.isEmpty {
                        self?.markArticleAsFavorite(favorites)
                    }
                    
                    self?.articlesTableView.setContentSize(rows: articles.count, heightForRow: ArticleCell.height.toInt())
                    self?.articlesTableHeight.constant = self?.articlesTableView.contentSize.height ?? 0
                    
                    self?.articlesTableView.reloadData()
                }
                
                self?.articlesLoading.stopAnimating()
            }
        }
    }
}

// MARK: COLLECTION VIEW
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return categories[indexPath.row].instantiateCell(collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        
        performSegue(withIdentifier: Segues.homeToCategories, sender: category)
    }
}

// MARK: TABLE VIEW
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ArticleCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articles[indexPath.row].instantiateCell(tableView, indexPath: indexPath)

        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        
        print(article)
    }
}

// MARK: METHODS
extension HomeViewController {
    
    private func markArticleAsFavorite(_ favorites: [Favorite]) {
        let favoriteIds = favorites.map { $0.id }
        
        for (idx, article) in articles.enumerated() {
            if favoriteIds.contains(article.id) {
                articles[idx].isFavorite = true
            }
        }
    }
}
