//
//  NotesController.swift
//  Do it
//
//  Created by Nitin A on 28/10/18.
//  Copyright © 2018 Nitin Aggarwal. All rights reserved.
//

import UIKit

class NotesController: UIViewController {

    // MARK: - Variables
    
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.backgroundColor = .yellow
    }

}
