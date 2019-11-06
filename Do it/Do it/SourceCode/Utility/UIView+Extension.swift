//
//  UIView+Extension.swift
//  Do it
//
//  Created by Nitin A on 05/11/19.
//  Copyright © 2019 Nitin Aggarwal. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach{addSubview($0)}
    }
}
