//
//  DemoListController.swift
//  Do it
//
//  Created by Nitin A on 05/11/19.
//  Copyright © 2019 Nitin Aggarwal. All rights reserved.
//

import UIKit
import SnapKit

class DemoListController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Variables
    lazy var listCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var dataArray: [Demo] = []
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSetup()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func dataSetup() {
        let demo1 = Demo(title: "UICollectionView", subTitle: "Collection grid layout with equal spacing.")
        dataArray.append(demo1)
        
        let demo2 = Demo(title: "UICollectionView, UIPageViewController", subTitle: "Pagination with multiple controllers with dynamic titles.")
        dataArray.append(demo2)
    }
    
    private func initialSetup() {
        view.backgroundColor = .white
        self.title = "Demos"
        
        view.addSubview(listCollectionView)
        listCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        listCollectionView.register(DemoListCollectionCell.self, forCellWithReuseIdentifier: "DemoListCollectionCell")
    }
    
    // MARK: - UICollectionView's Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DemoListCollectionCell", for: indexPath) as! DemoListCollectionCell
        let demo = dataArray[indexPath.item]
        cell.titleLabel.text = demo.title
        cell.subTitleLabel.text = demo.subTitle
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0: navigationController?.pushViewController(GridLayoutController(), animated: true)
        case 1: navigationController?.pushViewController(PaginationController(), animated: true)
        default: break
        }
    }
}

class DemoListCollectionCell: BaseCollectionCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundColor = UIColor(white: 0.8, alpha: 1)
        
        addSubviews(titleLabel, subTitleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(10)
            make.right.equalTo(-8)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(titleLabel.snp.right)
        }
    }
}
