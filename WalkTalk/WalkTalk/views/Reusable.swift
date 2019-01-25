//
//  ReusableView.swift
//  WalkTalk
//
//  Created by Josh Kneedler on 1/23/19.
//  Copyright © 2019 Josh Kneedler. All rights reserved.
//

import Foundation
import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

//default implementation
extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}


