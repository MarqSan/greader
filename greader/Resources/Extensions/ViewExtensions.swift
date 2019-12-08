//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

// MARK: VIEW
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
    
    func dropShadow(color: UIColor) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
    }
}

// MARK: NAVIGATION

extension UINavigationController {
    
    override open func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    func customizeBackButton(color: UIColor? = .black) {
        let backButtonImage = #imageLiteral(resourceName: "icn_arrow-left")

        self.navigationBar.backIndicatorImage = backButtonImage
        self.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        self.navigationBar.tintColor = color
    }
    
    func removeNavBarLine() {
        self.navigationBar.shadowImage = UIImage()
    }
}

extension UINavigationItem {
    
    func setupLogoAsNavigationItem() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 110, height: 35))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "img_logo-full")
        
        self.titleView = imageView
    }
}
