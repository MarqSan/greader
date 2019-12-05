//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

struct Loading {
    static var activity: UIActivityIndicatorView = UIActivityIndicatorView()
    
    static func start(view: UIView, color: String = Colors.primary,
                      blockInteraction: Bool? = false,
                      style: UIActivityIndicatorView.Style = .whiteLarge) {
        
        activity.center = view.center
        activity.hidesWhenStopped = true
        activity.style = style
        activity.color = UIColor(named: color)
        
        view.addSubview(activity)
        
        activity.startAnimating()
        
        if blockInteraction != nil && blockInteraction == true {
             UIApplication.shared.beginIgnoringInteractionEvents()
        }
       
    }
    
    static func stop() {
        activity.stopAnimating()
        
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
