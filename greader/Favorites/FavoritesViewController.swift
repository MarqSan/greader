//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: OUTLETS
    @IBOutlet weak var favoritesTableView: UITableView!
    
    // MARK: VARIABLES
    var presenter: FavoritesPresenter!
    var articles: [Article] = []
}

// MARK: LIFECYCLE
extension FavoritesViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getFavorites()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = FavoritesPresenter()
    }
}

// MARK: SEGUES
extension FavoritesViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let articleDetailsVC = segue.destination as? ArticleDetailsViewController {
            guard let article = sender as? Article else { return }
            
            articleDetailsVC.article = article
        }
    }
}

// MARK: PRESENTER
extension FavoritesViewController {
    
    private func getFavorites() {
        presenter.getFavoritesAsArticles { [weak self] articles in
            self?.articles = articles
            
            self?.favoritesTableView.reloadData()
        }
    }
}

// MARK: TABLE VIEW
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = articles.count
        
        if rows == 0 {
            tableView.addEmptyView(title: "Você ainda não tem favoritos",
                                   message: "Guarde seus artigos favoritos aqui",
                                   image: #imageLiteral(resourceName: "icn_broken-heart"))
        } else {
            tableView.backgroundView = nil
        }
        
        return rows
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
        
        performSegue(withIdentifier: Segues.favoritesToArticleDetails, sender: article)
    }
}

// MARK: DELEGATES
extension FavoritesViewController: ArticleCellDelegate {
    
    func tappedFavoriteButton(id: Int32) {
        articles = articles.filter { $0.id != id }
        
        favoritesTableView.reloadData()
    }
}
