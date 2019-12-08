//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

class SearchViewController: UIViewController {

    // MARK: OUTLETS
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchesTableView: UITableView!
    
    // MARK: VARIABLES
    private var presenter = HomePresenter()
    private var articles: [Article] = []
    private var searchedArticles: [Article] = []
}

// MARK: LIFECYCLE
extension SearchViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getArticles()
    }
}

// MARK: SEGUES
extension SearchViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let articleDetailsVC = segue.destination as? ArticleDetailsViewController {
            guard let article = sender as? Article else { return }
            
            articleDetailsVC.article = article
        }
    }
}

// MARK: PRESENTER
extension SearchViewController {

    private func getArticles() {
        presenter.getArticles { [weak self] (response, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if let articles = response {
                self?.articles = articles
            }
        }
    }
}

// MARK: TABLEVIEW
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedArticles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ArticleCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return searchedArticles[indexPath.row].instantiateCell(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        
        performSegue(withIdentifier: Segues.searchToArticleDetails, sender: article)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

// MARK: SEARCHBAR
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            searchedArticles = articles.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        } else {
            searchedArticles = []
        }
        
        searchesTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
