//
//  SettingsViewController.swift
//  FindYourSurf
//
//  Created by Michael Blank on 1/18/21.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        // Build Top Stack View
        view.addSubview(topStackView)
        constructTopStackView()
        addTopStackViewConstraints()
        
        // Table View
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
    
    // MARK: - Top Stack View
    
    private let settingLabel: UITextField = {
        let settingLabel = UITextField()
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        settingLabel.text = "SETTINGS"
        settingLabel.isUserInteractionEnabled = false
        settingLabel.font = UIFont(name: "Poppins-Bold", size: 30)
        settingLabel.backgroundColor = nil
        settingLabel.textColor = #colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1)
        return settingLabel
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("<", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Poppins-Bold", size: 40)
        button.setTitleColor(#colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1), for: .normal)
        button.backgroundColor = nil
        button.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        return button
    }()
    
    private let topStackView: UIStackView = {
        let topStackView = UIStackView()
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return topStackView
    }()
    
    private let logo: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "wave_blue_circle.png"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private func constructTopStackView() {
        topStackView.addSubview(settingLabel)
        topStackView.addSubview(logo)
        topStackView.addSubview(backButton)
    }
    
    private func addTopStackViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(topStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(topStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(topStackView.heightAnchor.constraint(equalToConstant: 200))
        
        constraints.append(settingLabel.centerXAnchor.constraint(equalTo: topStackView.centerXAnchor))
        constraints.append(settingLabel.topAnchor.constraint(equalTo: topStackView.topAnchor, constant: 150))
        constraints.append(settingLabel.widthAnchor.constraint(equalToConstant: 144))
        constraints.append(settingLabel.heightAnchor.constraint(equalToConstant: 43))

        constraints.append(logo.centerXAnchor.constraint(equalTo: topStackView.centerXAnchor))
        constraints.append(logo.topAnchor.constraint(equalTo: topStackView.topAnchor, constant: 70))
        constraints.append(logo.widthAnchor.constraint(equalToConstant: 71))
        constraints.append(logo.heightAnchor.constraint(equalToConstant: 71))
        
        constraints.append(backButton.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor, constant: 20))
        constraints.append(backButton.topAnchor.constraint(equalTo: topStackView.topAnchor, constant: 40))
        constraints.append(backButton.widthAnchor.constraint(equalToConstant: 32))
        constraints.append(backButton.heightAnchor.constraint(equalToConstant: 36))

        
        // Apply
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        cell.textLabel?.text = "Location"
        return cell
    }
    
    
    // MARK: - Obj-C Functions
    
    @objc func backClicked() {
        self.dismiss(animated: true, completion: nil)
    }

}

