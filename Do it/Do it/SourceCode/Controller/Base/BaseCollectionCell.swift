//
//  BaseCollectionCell.swift
//  Do it
//
//  Created by Nitin A on 05/11/19.
//  Copyright © 2019 Nitin Aggarwal. All rights reserved.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        backgroundColor = .clear
    }
}
