//
//  ViewController.swift
//  FindYourSurf
//
//  Created by Michael Blank on 1/15/21.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display Background Image
        setBackgroundImage()
        
        // Build Stack View
        view.addSubview(topStackView)
        addTopStackViewConstraints()
        constructTopStackView()
        
        //Build Button
        view.addSubview(startButton)
        addButtonConstraints()
    }

    // MARK: - BackgroundImage
    
    private func setBackgroundImage () {
        let img = UIImage(named: "Surfer Background.png")
        view.layer.contents = img?.cgImage
    }
    
    
    // MARK: - Button
    
    private let startButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("START", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Poppins-Bold", size: 18)
        button.setTitleColor(#colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }()
    
    private func addButtonConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30))
        constraints.append(startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(startButton.widthAnchor.constraint(equalToConstant: 188))
        constraints.append(startButton.heightAnchor.constraint(equalToConstant: 47))
        
        // Apply
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Top Stack View
    
    private let appName: UITextField = {
        let appName = UITextField(frame: CGRect(x: 40, y: 3, width: 133, height: 30))
        appName.text = "Find Your Surf"
        appName.isUserInteractionEnabled = false
        appName.font = UIFont(name: "Poppins-Bold", size: 18)
        appName.backgroundColor = nil
        appName.textColor = #colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1)
        return appName
    }()
    
    private let topStackView: UIStackView = {
        let topStackView = UIStackView()
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        return topStackView
    }()
    
    private func constructTopStackView() {
        let logo = UIImageView(image: UIImage(named: "wave_blue_circle.png"))
        logo.frame = CGRect(x: 0, y: 0, width: 33, height: 33)
        topStackView.addSubview(logo)
        
        topStackView.addSubview(appName)
        
        let settingsCog = UIImageView(image: UIImage(named: "settings_blue.png"))
        settingsCog.frame = CGRect(x: 330, y: 3, width: 29, height: 29)
        let UITapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.settingsClicked))
        UITapRecognizer.delegate = self
        settingsCog.addGestureRecognizer(UITapRecognizer)
        settingsCog.isUserInteractionEnabled = true
        topStackView.addSubview(settingsCog)
    }
    
    private func addTopStackViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6))
        constraints.append(topStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(topStackView.widthAnchor.constraint(equalToConstant: 354))
        constraints.append(topStackView.heightAnchor.constraint(equalToConstant: 33))
        
        // Apply
        NSLayoutConstraint.activate(constraints)
    }
    
    
    // MARK: - Obj-C Functions
    
    @objc func buttonClicked(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let measureVC = storyboard.instantiateViewController(identifier: "MeasureViewController")

        
        measureVC.modalPresentationStyle = .fullScreen
        measureVC.modalTransitionStyle = .crossDissolve
        
        present(measureVC, animated: true, completion: nil)
    }
    
    @objc func settingsClicked() {
        let settingsVC = SettingsViewController()
        present(settingsVC, animated: true, completion: nil)
    }

}

