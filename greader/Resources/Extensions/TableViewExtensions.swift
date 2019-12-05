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
}
