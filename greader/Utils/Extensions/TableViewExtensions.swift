//  Copyright © 2019 Lohan Marques. All rights reserved.

import UIKit

extension UITableView {
    
    func setContentSize(rows: Int, heightForRow height: Int, spacingOf spacing: Int = 0) -> Void {
        var totalHeight: CGFloat = CGFloat(rows * height)
        
        if spacing > 0 {
            totalHeight += CGFloat(rows * spacing)
        }
        
        self.contentSize = CGSize(width: self.bounds.width, height: totalHeight)
    }
    
    func addEmptyView(title: String, titleColor: UIColor = UIColor(named: Colors.primary) ?? .black,
                      message: String?, messageColor: UIColor? = UIColor(named: Colors.secondary) ?? .black,
                      image: UIImage? = nil) {
        
        let dimensions = CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height)
        let emptyView = UIView(frame: dimensions)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = titleColor
        titleLabel.font = UIFont(name: Fonts.medium, size: 20)
        
        emptyView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        if let text = message, let color = messageColor {
            let messageLabel = UILabel()
            messageLabel.text = text
            messageLabel.textColor = color
            messageLabel.font = UIFont(name: Fonts.light, size: 14)
            
            emptyView.addSubview(messageLabel)
            
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
            messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        }
        
        if let image = image {
            let imageView = UIImageView()
            imageView.image = image
            
            emptyView.addSubview(imageView)
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -30).isActive = true
            imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        }
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
}
