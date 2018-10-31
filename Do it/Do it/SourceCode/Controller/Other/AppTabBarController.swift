//
//  AppTabBarController.swift
//  Do it
//
//  Created by Nitin A on 28/10/18.
//  Copyright © 2018 Nitin Aggarwal. All rights reserved.
//

import UIKit

class AppTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
    }
    
    private func setupTabbar() {
        let categoriesNavigation = CategoriesNavigationController(rootViewController: CategoriesController())
        categoriesNavigation.tabBarItem.image = UIImage(named: "tasks_dark")
        categoriesNavigation.tabBarItem.selectedImage = UIImage(named: "tasks_dark")
        
        let calendarNavigation = CalendarNavigationController(rootViewController: CalendarController())
        calendarNavigation.tabBarItem.image = UIImage(named: "calendar_dark")
        calendarNavigation.tabBarItem.selectedImage = UIImage(named: "calendar_dark")
        
        let notesNavigation = NotesNavigationController(rootViewController: NotesController())
        notesNavigation.tabBarItem.image = UIImage(named: "notes_dark")
        notesNavigation.tabBarItem.selectedImage = UIImage(named: "notes_dark")
        
        let profileNavigation = ProfileNavigationController(rootViewController: ProfileController())
        profileNavigation.tabBarItem.image = UIImage(named: "profile_dark")
        profileNavigation.tabBarItem.selectedImage = UIImage(named: "profile_dark")
        
        viewControllers = [categoriesNavigation, calendarNavigation, notesNavigation, profileNavigation]
        
        guard let items = tabBar.items else { return }
        
        items.forEach { (item) in
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
}
