//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

// MARK: ANIMATIONS
extension UIButton {

    func pulse() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            
        }, completion: { _ in
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.transform = CGAffineTransform.identity
            }
        })
    }
}
