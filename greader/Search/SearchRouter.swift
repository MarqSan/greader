//  Copyright © 2020 Lohan Marques. All rights reserved.

import Foundation
import UIKit

class SearchRouter: SearchPresenterToRouterProtocol {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Search", bundle: Bundle.main)
    }
    
    static func createModule() -> UIViewController? {
        guard let view = storyboard.instantiateViewController(withIdentifier: "searchVC") as? SearchViewController else { return nil }
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
}

// MARK: TAB
extension SearchRouter: TabBarViewRouterProtocol {
 
    func configureViewForTab() -> UIViewController? {
        return SearchRouter.createModule()
    }
}
