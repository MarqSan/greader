//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

class HomeViewController: UIViewController {

    // MARK: OUTLETS
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    // MARK: VARIABLES
    private var categories: [Category] = Category.getCategories()
    
}

// MARK: LIFECYCLE
extension HomeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setupLogoAsNavigationItem()
        
        categoriesCollectionView.backgroundColor = .none
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
        let nibCell = UINib(nibName: Cells.category, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: Cells.categoryID)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.categoryID, for: indexPath) as! CategoryCell
        cell.setupCell(categories[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = categories[indexPath.row]
        
        print(id)
    }
}
