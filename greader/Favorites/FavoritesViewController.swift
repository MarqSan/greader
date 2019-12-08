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
    
    override func viewDidAppear(_ animated: Bool) {
        getFavorites()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = FavoritesPresenter()
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
}

// MARK: DELEGATES
extension FavoritesViewController: ArticleCellDelegate {
    
    func tappedFavoriteButton(id: Int32) {
        articles = articles.filter { $0.id != id }
        
        favoritesTableView.reloadData()
    }
}
