//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

class HomeViewController: UIViewController {

    // MARK: OUTLETS
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet weak var articlesTableHeight: NSLayoutConstraint!
    
    // MARK: VARIABLES
    private var categories: [Category] = Category.getCategories()
    private var articles: [Article] = Article.getArticles()
    
}

// MARK: LIFECYCLE
extension HomeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setupLogoAsNavigationItem()
        
        categoriesCollectionView.backgroundColor = .none
        
        setArticlesTableContentSize()
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
        let nibCell = UINib(nibName: String(describing: CategoryCell.self), bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: CategoryCell.identifier)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        let category = categories[indexPath.row]
        
        cell.setupCell(category)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        
        print(category)
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
        let nibCell = UINib(nibName: String(describing: ArticleCell.self), bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: ArticleCell.identifier)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath) as! ArticleCell
        let article = articles[indexPath.row]
        
        cell.setupCell(article)
        cell.applyStyles(article)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        
        print(article)
    }
}

// MARK: METHODS
extension HomeViewController {
    
    fileprivate func setArticlesTableContentSize() {
        articlesTableView.setContentSize(rows: articles.count, heightForRow: ArticleCell.height.toInt())
        articlesTableHeight.constant = articlesTableView.contentSize.height
    }
}
