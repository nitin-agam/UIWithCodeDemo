//
//  PaginationController.swift
//  Do it
//
//  Created by Nitin A on 05/11/19.
//  Copyright © 2019 Nitin Aggarwal. All rights reserved.
//

import UIKit

let kTitleFontSize: CGFloat = 15

class PaginationController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    // MARK: - Variables
    lazy var menuItemsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let titlesArray = ["General Knowledge", "Astrology", "Celebrations", "Transportation", "Music", "Movies", "Food & Drink", "Entertainment", "Sports"]
    private var currentPageIndex: Int = 0
    private var pageController: UIPageViewController!
    private var pages: [UIViewController] = []
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.backgroundColor = .white
        title = "Page Menu"
        
        view.addSubview(menuItemsCollection)
        menuItemsCollection.register(MenuItemCollectionCell.self, forCellWithReuseIdentifier: "MenuItemCollectionCell")
        menuItemsCollection.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(64)
            make.height.equalTo(36)
        }
        updateItemMenu()
        pageControllerSetup(menuHeight: 100)
    }
    
    private func pageControllerSetup(menuHeight: CGFloat) {
        self.pageController = UIPageViewController(transitionStyle: .scroll,
                                                   navigationOrientation: .horizontal,
                                                   options: nil)
        
        self.pageController.dataSource = self
        self.pageController.delegate = self
        self.pageController.view.frame = CGRect(x: 0,
                                                y: menuHeight,
                                                width: view.frame.width,
                                                height: view.frame.height - menuHeight)
        addChild(pageController)
        view.addSubview(self.pageController.view)
        pageController.didMove(toParent: self)
        pages.removeAll()
        
        for (index, title) in titlesArray.enumerated() {
            let controller = UIViewController()
            controller.title = title
            controller.view.backgroundColor = index % 2 == 0 ? .yellow : .red
            pages.append(controller)
        }
        pageController.setViewControllers([self.pages[self.currentPageIndex]], direction: .forward, animated: false, completion: nil)
    }
    
    
    // MARK: - UICollectionView's Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titlesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CommonUtils.rectForText(text: titlesArray[indexPath.item],
                                           font: UIFont.systemFont(ofSize: kTitleFontSize),
                                           width: collectionView.frame.width)
        
        // adding some extra margin
        return CGSize(width: size.width + 20, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCollectionCell", for: indexPath) as! MenuItemCollectionCell
        cell.titleLabel.text = titlesArray[indexPath.item]
        cell.bottomLine.backgroundColor = indexPath.item == currentPageIndex ? .black : .gray
        cell.titleLabel.textColor = indexPath.item == currentPageIndex ? .black : .gray
        cell.titleLabel.font = indexPath.item == currentPageIndex ? UIFont.boldSystemFont(ofSize: kTitleFontSize) : UIFont.systemFont(ofSize: kTitleFontSize)
        cell.bottomLine.isHidden = !(indexPath.item == currentPageIndex)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item != currentPageIndex {
            if currentPageIndex < indexPath.item {
                currentPageIndex = indexPath.item
                self.pageController.setViewControllers([pages[currentPageIndex]], direction: .forward, animated: true, completion: nil)
            } else {
                currentPageIndex = indexPath.item
                self.pageController.setViewControllers([pages[currentPageIndex]], direction: .reverse, animated: true, completion: nil)
            }
            updateItemMenu()
        }
    }
    
    fileprivate func updateItemMenu() {
        DispatchQueue.main.async {
            self.menuItemsCollection.reloadData()
            self.menuItemsCollection.scrollToItem(at: IndexPath(item: self.currentPageIndex, section: 0),
                                             at: .centeredHorizontally,
                                             animated: true)
        }
    }
    
    
    // MARK: - UIPageViewController's Methods
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            self.currentPageIndex = viewControllerIndex
            updateItemMenu()
            if viewControllerIndex != 0 {
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            currentPageIndex = viewControllerIndex
            updateItemMenu()
            if viewControllerIndex < self.pages.count - 1 {
                return pages[viewControllerIndex + 1]
            }
        }
        return nil
    }
}

class MenuItemCollectionCell: BaseCollectionCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: kTitleFontSize)
        label.textColor = .gray
        return label
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    override func setupLayout() {
        super.setupLayout()
        
        addSubviews(bottomLine, titleLabel)
        bottomLine.snp.makeConstraints { (make) in
            make.right.left.bottom.equalToSuperview()
            make.height.equalTo(3)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(3)
            make.right.equalTo(-3)
            make.top.equalTo(5)
            make.bottom.equalTo(bottomLine.snp.top)
        }
    }
}

