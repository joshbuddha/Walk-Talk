//
//  UITableView.swift
//  WalkTalk
//
//  Created by Josh Kneedler on 1/23/19.
//  Copyright © 2019 Josh Kneedler. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    /*
    func register<T: UITableViewCell>(_ :T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
 */    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("unable to dequeue")
        }
        
        return cell
    }
}

