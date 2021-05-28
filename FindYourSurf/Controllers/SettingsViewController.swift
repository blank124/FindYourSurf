//
//  SettingsViewController.swift
//  FindYourSurf
//
//  Created by Michael Blank on 1/18/21.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    // MARK: - Top Stack View
    
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var settingLabel: UITextField = {
        let settingLabel = UITextField()
        settingLabel.text = "SETTINGS"
        settingLabel.isUserInteractionEnabled = false
        settingLabel.font = UIFont(name: "Poppins-Bold", size: 30)
        settingLabel.backgroundColor = nil
        settingLabel.textColor = UIColor.customColor(.surfBlue)
        return settingLabel
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("<", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Poppins-Bold", size: 40)
        button.setTitleColor(UIColor.customColor(.surfBlue), for: .normal)
        button.backgroundColor = nil
        button.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var topStackView: UIStackView = {
        let topStackView = UIStackView()
        topStackView.backgroundColor = .white
        return topStackView
    }()
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "wave_blue_circle.png"))
        return logo
    }()
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        cell.textLabel?.text = "Location"
        return cell
    }
    
    // MARK: - Functions
    
    private func setupViews() {
        // Build Top Stack View
        view.addSubview(topStackView)
        topStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        constructTopStackView()
        
        // Table View
        view.addSubview(settingsTableView)
        settingsTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 200, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    private func constructTopStackView() {
        topStackView.addSubview(settingLabel)
        settingLabel.anchor(top: topStackView.topAnchor, left: nil, bottom: nil, right: nil, centerX: topStackView.centerXAnchor, centerY: nil, paddingTop: 150, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 144, height: 43)
        topStackView.addSubview(logo)
        logo.anchor(top: topStackView.topAnchor, left: nil, bottom: nil, right: nil, centerX: topStackView.centerXAnchor, centerY: nil, paddingTop: 70, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 71, height: 71)
        topStackView.addSubview(backButton)
        backButton.anchor(top: topStackView.topAnchor, left: topStackView.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: nil, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 32, height: 36)
    }
    
    // MARK: - Obj-C Functions
    
    @objc func backClicked() {
        self.dismiss(animated: true, completion: nil)
    }

}

