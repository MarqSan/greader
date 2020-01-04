//  Copyright © 2020 Lohan Marques. All rights reserved.

import Foundation
import UIKit

class HomeRouter: HomePresenterToRouterProtocol {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Home", bundle: Bundle.main)
    }
    
    static func createModule() -> UIViewController? {
        guard let view = storyboard.instantiateViewController(withIdentifier: "homeVC") as? HomeViewController else { return nil }
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
}

// MARK: TAB
extension HomeRouter: TabBarViewRouterProtocol {
 
    func configureViewForTab() -> UIViewController? {
        return HomeRouter.createModule()
    }
}
