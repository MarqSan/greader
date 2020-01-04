//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

class HomeViewController: UIViewController {

    // MARK: OUTLETS
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet weak var articlesTableHeight: NSLayoutConstraint!
    @IBOutlet weak var articlesLoading: UIActivityIndicatorView!
    
    // MARK: VARIABLES
    var presenter: HomeViewToPresenterProtocol?
    private var favoritesPresenter: FavoritesPresenter!
    private var categories: [Category] = Category.getCategories()
    private var articles: [Article] = []
}

// MARK: LIFECYCLE
extension HomeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setupLogoAsNavigationItem()
        
        favoritesPresenter = FavoritesPresenter()
        
        categoriesCollectionView.backgroundColor = .none
        
        presenter?.getArticles()
        addArticlesObserver()
    }
}

// MARK: SEGUES
extension HomeViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segues.homeToCategories:
            if let categoriesVC = segue.destination as? CategoriesViewController {
                guard let category = sender as? Category else { return }
                
                categoriesVC.articles = articles.filter { $0.categoryName == category.name }
                categoriesVC.category = category
            }
            
        case Segues.homeToArticleDetails:
            if let articleDetailsVC = segue.destination as? ArticleDetailsViewController {
                guard let article = sender as? Article else { return }
                
                articleDetailsVC.article = article
            }
            
        default:
            return
        }
    }
}

// MARK: PRESENTER
extension HomeViewController: HomePresenterToViewProtocol {
    
    func showArticles(articles: [Article]) {
        self.articles = articles
        
        articlesTableView.setContentSize(rows: articles.count, heightForRow: ArticleCell.height.toInt())
        articlesTableHeight.constant = articlesTableView.contentSize.height
        
        articlesTableView.reloadData()
        articlesLoading.stopAnimating()
    }
    
    func showArticlesError(error: ServiceError) {
        articlesLoading.stopAnimating()
        print(error.localizedDescription)
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
        
        performSegue(withIdentifier: Segues.homeToArticleDetails, sender: article)
    }
}

// MARK: CELL DELEGATE
extension HomeViewController: ArticleCellDelegate {
    
    func tappedFavoriteButton(id: Int32) {
        Article.updateArticleOnList(id: id, &articles)
    }
}

// MARK: METHODS
extension HomeViewController {
    
    private func addArticlesObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateArticles), name: .articlesUpdate, object: nil)
    }
    
    @objc func updateArticles(_ notification: Notification) {
        guard let id = notification.object as? Int32 else { return }
        
        Article.updateArticleOnList(id: id, &articles)
        articlesTableView.reloadData()
    }
}
