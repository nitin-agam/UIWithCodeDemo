//
//  GridLayoutController.swift
//  Do it
//
//  Created by Nitin A on 05/11/19.
//  Copyright © 2019 Nitin Aggarwal. All rights reserved.
//

import UIKit

class GridLayoutController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - Variables
    private let gridSpacing: CGFloat = 10
    private let numberOfItemsInRow: CGFloat = 3
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = gridSpacing
        layout.minimumInteritemSpacing = gridSpacing
        let width = (view.frame.width - gridSpacing * (numberOfItemsInRow + 1)) / numberOfItemsInRow
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        
        view.backgroundColor = .white
        title = "Grid Layout"
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        collectionView.register(GridLayoutCollectionCell.self, forCellWithReuseIdentifier: "GridLayoutCollectionCell")
    }

    
    // MARK: - UICollectionView's Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "GridLayoutCollectionCell", for: indexPath) as! GridLayoutCollectionCell
    }
}

class GridLayoutCollectionCell: BaseCollectionCell {
    
    override func setupLayout() {
        super.setupLayout()
        backgroundColor = UIColor(white: 0.8, alpha: 1)
    }
}

