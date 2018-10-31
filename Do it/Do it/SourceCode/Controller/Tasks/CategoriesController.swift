//
//  TaskCategoriesController.swift
//  Do it
//
//  Created by Nitin A on 28/10/18.
//  Copyright © 2018 Nitin Aggarwal. All rights reserved.
//

import UIKit

struct Colors {
    // Category colors
    static let kCategoryColor1 = "7995ff"
    static let kCategoryColor2 = "ffb800"
    static let kCategoryColor3 = "60d9bd"
    static let kCategoryColor4 = "ff2c51"
    static let kCategoryColor5 = "0099cc"
    static let kCategoryColor6 = "f58700"
    
    static let kCategoryColor7 = "8E44AD"
    static let kCategoryColor8 = "CD6155"
    static let kCategoryColor9 = "9B59B6"
    static let kCategoryColor10 = "2980B9"
    static let kCategoryColor11 = "17A589"
    static let kCategoryColor12 = "515A5A"
    
    
    static let kCategoryColors = [Colors.kCategoryColor1,
                                  Colors.kCategoryColor2,
                                  Colors.kCategoryColor3,
                                  Colors.kCategoryColor4,
                                  Colors.kCategoryColor5,
                                  Colors.kCategoryColor6,
                                  Colors.kCategoryColor7,
                                  Colors.kCategoryColor8,
                                  Colors.kCategoryColor9,
                                  Colors.kCategoryColor10,
                                  Colors.kCategoryColor11,
                                  Colors.kCategoryColor12]
}


class CategoriesController: UIViewController {

    // MARK: - Variables
    var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi Nitin,"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    let headerSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Today, you have 5 task!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var addCategoryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "add_gray"), for: .normal)
        button.addTarget(self, action: #selector(addCategoryHandle), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Variables
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let width = (view.frame.width - 10 * 3) / 2
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
    
    private let cellIdentifier = "CategoryCollectionCell"
    var tasksCategories: [TaskCategory] = []
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupData()
        setupHeaderView()
        setupCollectionView()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.backgroundColor = .white
    }
    
    private func setupHeaderView() {
        
        view.addSubview(headerView)
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        let viewTop = UIView()
        viewTop.translatesAutoresizingMaskIntoConstraints = false
        viewTop.backgroundColor = .white
        self.view.addSubview(viewTop)
        viewTop.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewTop.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewTop.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewTop.bottomAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        
        headerView.addSubview(headerTitleLabel)
        headerView.addSubview(headerSubtitleLabel)
        headerView.addSubview(addCategoryButton)
        
        NSLayoutConstraint.activate([
            headerTitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),
            headerTitleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
            headerSubtitleLabel.leadingAnchor.constraint(equalTo: headerTitleLabel.leadingAnchor),
            headerSubtitleLabel.topAnchor.constraint(equalTo: headerTitleLabel.bottomAnchor, constant: 5),
            addCategoryButton.heightAnchor.constraint(equalToConstant: 40),
            addCategoryButton.widthAnchor.constraint(equalToConstant: 40),
            addCategoryButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            addCategoryButton.centerYAnchor.constraint(equalTo: headerTitleLabel.centerYAnchor)])
    }
    
    private func setupCollectionView() {
        
        view.addSubview(collectionView)
        let constraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 5),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)]
        NSLayoutConstraint.activate(constraints)
        collectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.reloadData()
    }
    
    @objc func addCategoryHandle() {
        
    }
}

extension CategoriesController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasksCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CategoryCollectionCell
        cell.taskCategory = tasksCategories[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Animation 2
        let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 20, 0)
        cell.layer.transform = transform
        cell.alpha = 0.5
        UIView.animate(withDuration: 0.7) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension CategoriesController {
    
    private func setupData() {
        
        let all = TaskCategory()
        all.name = "All Tasks"
        all.numberOfTasks = 25
        all.subtitle = "View and manage your all tasks."
        all.backgroundColor = UIColor.colorWithHex(hex: Colors.kCategoryColors.randomElement()!)
        all.isPinned = true
        tasksCategories.append(all)
        
        let today = TaskCategory()
        today.name = "Today"
        today.numberOfTasks = 1
        today.subtitle = "Quickly perform your today's tasks and ejoy."
        today.backgroundColor = UIColor.colorWithHex(hex: Colors.kCategoryColors.randomElement()!)
        today.isPinned = true
        tasksCategories.append(today)
        
        let meeting = TaskCategory()
        meeting.name = "Meeting"
        meeting.numberOfTasks = 5
        meeting.subtitle = "Setup your meetings with your contacts."
        meeting.backgroundColor = UIColor.colorWithHex(hex: Colors.kCategoryColors.randomElement()!)
        tasksCategories.append(meeting)
        
        let personal = TaskCategory()
        personal.name = "Personal"
        personal.numberOfTasks = 1
        personal.subtitle = "Do your personal jobs"
        personal.backgroundColor = UIColor.colorWithHex(hex: Colors.kCategoryColors.randomElement()!)
        tasksCategories.append(personal)
        
        let shopping = TaskCategory()
        shopping.name = "Shopping"
        shopping.numberOfTasks = 3
        shopping.subtitle = "Need to buy some fruits and vegatables."
        shopping.backgroundColor = UIColor.colorWithHex(hex: Colors.kCategoryColors.randomElement()!)
        tasksCategories.append(shopping)
        
        let travel = TaskCategory()
        travel.name = "Travel"
        travel.numberOfTasks = 0
        travel.subtitle = "Go and enjoy at your dream place."
        travel.backgroundColor = UIColor.colorWithHex(hex: Colors.kCategoryColors.randomElement()!)
        tasksCategories.append(travel)
        
        let creative = TaskCategory()
        creative.name = "Creative"
        creative.numberOfTasks = 4
        creative.subtitle = "Design and draw your brain sketch."
        creative.backgroundColor = UIColor.colorWithHex(hex: Colors.kCategoryColors.randomElement()!)
        tasksCategories.append(creative)
        
        let office = TaskCategory()
        office.name = "Meeting"
        office.numberOfTasks = 5
        office.subtitle = "Manage your office tasks and activity."
        office.backgroundColor = UIColor.colorWithHex(hex: Colors.kCategoryColors.randomElement()!)
        tasksCategories.append(office)
    }
}

