//
//  CategoryCollectionCell.swift
//  Do it
//
//  Created by Nitin A on 28/10/18.
//  Copyright © 2018 Nitin Aggarwal. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    
    var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8.0
        view.layer.masksToBounds = true
        return view
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.text = "Meeting"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var subtitleTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isSelectable = false
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.backgroundColor = .clear
        tv.isUserInteractionEnabled = false
        tv.text = "5 Tasks"
        tv.textAlignment = .center
        tv.textColor = .white
        return tv
    }()
    
    lazy var pinButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "pin_white"), for: .normal)
        //button.addTarget(self, action: #selector(handlePinned), for: .touchUpInside)
        return button
    }()
    
    
    var taskCategory: TaskCategory? {
        didSet {
            nameLabel.text = taskCategory?.name
            subtitleTextView.text = "\(taskCategory?.numberOfTasks ?? 0) Tasks"
            backView.backgroundColor = taskCategory?.backgroundColor
            pinButton.isHidden = !(taskCategory?.isPinned)!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(backView)
        backView.addSubview(nameLabel)
        backView.addSubview(subtitleTextView)
        backView.addSubview(pinButton)
        
        let constraints = [
            backView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            backView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 15),
            nameLabel.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 5),
            nameLabel.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -5),
            subtitleTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            subtitleTextView.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: -5),
            subtitleTextView.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            subtitleTextView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -5),
            pinButton.heightAnchor.constraint(equalToConstant: 30),
            pinButton.widthAnchor.constraint(equalToConstant: 30),
            pinButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -5),
            pinButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10)]
        NSLayoutConstraint.activate(constraints)
    }
}
