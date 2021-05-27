//
//  MeasureViewController.swift
//  FindYourSurf
//
//  Created by Michael Blank on 1/16/21.
//

import UIKit
import FloatingPanel

class MeasureViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, FloatingPanelControllerDelegate, UIGestureRecognizerDelegate {
    
    // MARK:- Picker View
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weightArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(weightArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentWeight = weightArray[row]
        getNewRecommendation()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.font = UIFont (name: "Poppins-SemiBold", size: 16)
        label.text =  String(weightArray[row])
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1)
        label.textAlignment = .center
        label.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        return label
    }
    
    // MARK: - Floating Panel
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return FloatingPanelStocksLayout()
    }
    
    class FloatingPanelStocksLayout: FloatingPanelLayout {
        let position: FloatingPanelPosition = .bottom
        let initialState: FloatingPanelState = .tip

        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .full: FloatingPanelLayoutAnchor(absoluteInset: 56.0, edge: .top, referenceGuide: .safeArea),
                .half: FloatingPanelLayoutAnchor(absoluteInset: 262.0, edge: .bottom, referenceGuide: .safeArea),
                .tip: FloatingPanelLayoutAnchor(absoluteInset: 45.0, edge: .bottom, referenceGuide: .safeArea),
            ]
        }

        func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
            return 0.0
        }
    }
    
   // MARK:- View Did Load
    
    var boardImgList = ["SHORTBOARD", "FISH", "FUNBOARD", "FOAMY", "LONGBOARD", "GUN"]
    var boardIndex = 0
    
    var skillLevel = "BEGINNER"
    var currentWeight = 50
    
    let weightArray = Array(0...100)
    
    var fpc: FloatingPanelController!
    var recommender = BoardType()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        // Build top Stack View
        view.addSubview(topStackView)
        addTopStackViewConstraints()
        constructTopStackView()
        
        // Build Middle Board Label and Size
        view.addSubview(middleStackView)
        addMiddleStackViewConstraints()
        constructMiddleStackView()
        
        
        // Build Board Image View
        view.addSubview(boardImageView)
        addBoardImageViewConstraints()
        
        // Handle Board Swipes
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe(_:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe(_:)))
        view.addGestureRecognizer(rightSwipe)
        
        // Build Level Switch
        view.addSubview(levelStackView)
        addLevelStackViewConstraints()
        constructLevelStackView()
        
        // Build Bottom View
        view.addSubview(bottomStackView)
        addBottomStackViewConstraints()
        constructBottomStackView()
        
        // Build Floating Panel
        fpc = FloatingPanelController()
        fpc.delegate = self
        guard let contentVC = storyboard?.instantiateViewController(identifier: "fpc_content") as? ContentViewController else { return }
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
        fpc.track(scrollView: contentVC.myTableView)
        fpc.surfaceView.appearance.cornerRadius = 20.0

        
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
    
    // MARK: - Middle Stack View
    
    private let boardType: UITextField = {
        let boardType = UITextField(frame: CGRect(x: 0, y: 0, width: 180, height: 56))
        boardType.isUserInteractionEnabled = false
        boardType.font = UIFont(name: "Poppins-Bold", size: 22)
        boardType.backgroundColor = nil
        boardType.textColor = #colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1)
        boardType.text = "SHORTBOARD"
        return boardType
    }()
    
    private let boardSize: UITextField = {
        let boardSize = UITextField(frame: CGRect(x: 0, y: 35, width: 124, height: 60))
        boardSize.isUserInteractionEnabled = false
        boardSize.font = UIFont(name: "Poppins-Bold", size: 48)
        boardSize.backgroundColor = nil
        boardSize.textColor = #colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1)
        return boardSize
    }()
    
    private let middleStackView: UIStackView = {
        let middleStackView = UIStackView()
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        return middleStackView
    }()
    
    private func constructMiddleStackView() {
        middleStackView.addSubview(boardType)
        middleStackView.addSubview(boardSize)
        getNewRecommendation()
    }
    
    private func addMiddleStackViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(middleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70))
        constraints.append(middleStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(middleStackView.widthAnchor.constraint(equalToConstant: 200))
        constraints.append(middleStackView.heightAnchor.constraint(equalToConstant: 96))
        
        // Apply
        NSLayoutConstraint.activate(constraints)
    }
    
    private func getNewRecommendation() {
        recommender.calculateRecommendation(weight: currentWeight, skillLevel: skillLevel, boardType: boardImgList[boardIndex])
        let newBoardSize = recommender.getBoardSize()
        boardSize.text = newBoardSize
    }
    
//    // MARK: - Swipe Text View
//
//    private let swipeText: UITextField = {
//        let text = UITextField()
//        text.isUserInteractionEnabled = false
//        text.font = UIFont(name: "Poppins-Bold", size: 12)
//        text.backgroundColor = nil
//        text.textColor = #colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1)
//        text.text = "⬅SWIPE⮕"
//        return text
//    }()
//
//    private func addSwipeTextConstraints() {
//        var constraints = [NSLayoutConstraint]()
//
//        // Add
//        constraints.append(swipeText.topAnchor.constraint(equalTo: middleStackView.bottomAnchor, constant: 10))
//        constraints.append(swipeText.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
//        constraints.append(swipeText.widthAnchor.constraint(equalToConstant: 100))
//        constraints.append(swipeText.heightAnchor.constraint(equalToConstant: 30))
//
//        // Apply
//        NSLayoutConstraint.activate(constraints)
//    }
    
    // MARK: - Skill Level Stack View
    
    private let buttonLeft: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("BEGINNER", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Poppins-SemiBold", size: 14)
        button.setTitleColor(#colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderWidth = 2.0
        button.layer.borderColor = #colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        button.addTarget(self, action: #selector(leftLevelButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private let buttonRight: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("INTERMEDIATE", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Poppins-SemiBold", size: 14)
        button.setTitleColor(#colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1)
        button.layer.cornerRadius = 10.0
        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        button.addTarget(self, action: #selector(rightLevelButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private func addLeftButtonConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(buttonLeft.trailingAnchor.constraint(equalTo: levelStackView.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(buttonLeft.topAnchor.constraint(equalTo: levelStackView.safeAreaLayoutGuide.topAnchor))
        constraints.append(buttonLeft.widthAnchor.constraint(equalToConstant: 120))
        constraints.append(buttonLeft.heightAnchor.constraint(equalToConstant: 43))
        
        // Apply
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addRightButtonConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(buttonRight.leadingAnchor.constraint(equalTo: levelStackView.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(buttonRight.topAnchor.constraint(equalTo: levelStackView.safeAreaLayoutGuide.topAnchor))
        constraints.append(buttonRight.widthAnchor.constraint(equalToConstant: 120))
        constraints.append(buttonRight.heightAnchor.constraint(equalToConstant: 43))
        
        // Apply
        NSLayoutConstraint.activate(constraints)
    }
    
    private let levelStackView: UIStackView = {
        let levelStackView = UIStackView()
        levelStackView.translatesAutoresizingMaskIntoConstraints = false
//        levelStackView.isUserInteractionEnabled = true
        return levelStackView
    }()
    
    private func constructLevelStackView() {
        levelStackView.addSubview(buttonLeft)
        addLeftButtonConstraints()
        levelStackView.addSubview(buttonRight)
        addRightButtonConstraints()
    }

    private func addLevelStackViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(levelStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 520))
        constraints.append(levelStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(levelStackView.widthAnchor.constraint(equalToConstant: 240))
        constraints.append(levelStackView.heightAnchor.constraint(equalToConstant: 43))
        
        // Apply
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Bottom Stack View
    
    private let weightTextField: UITextField = {
        let weightTextField = UITextField(frame: CGRect(x: 70, y: 90, width: 166, height: 36))
        weightTextField.text = "YOUR WEIGHT (KG)"
        weightTextField.isUserInteractionEnabled = false
        weightTextField.font = UIFont(name: "Poppins-SemiBold", size: 14)
        weightTextField.backgroundColor = nil
        weightTextField.textColor = #colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1)
        return weightTextField
    }()
    
    private let bottomStackView: UIStackView = {
        let bottomStackView = UIStackView()
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        return bottomStackView
    }()
    
    private func constructBottomStackView() {
        bottomStackView.addSubview(weightPickerView)
        constructWeightPickerView()
        bottomStackView.addSubview(weightTextField)
        
        let settingsCog = UIImageView(image: UIImage(named: "settings_blue.png"))
        settingsCog.frame = CGRect(x: 210, y: 100, width: 18, height: 18)
        let UITapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.settingsClicked))
        UITapRecognizer.delegate = self
        settingsCog.addGestureRecognizer(UITapRecognizer)
        settingsCog.isUserInteractionEnabled = true
        bottomStackView.addSubview(settingsCog)
    }
    
    private func addBottomStackViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(bottomStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 570))
        constraints.append(bottomStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(bottomStackView.widthAnchor.constraint(equalToConstant: 310))
        constraints.append(bottomStackView.heightAnchor.constraint(equalToConstant: 200))
        
        // Apply
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Board Image View
    
    private var boardImageView: UIImageView = {
        let board = UIImageView(image: UIImage(named: "SHORTBOARD.svg"))
        board.translatesAutoresizingMaskIntoConstraints = false
        return board
    }()
    
    
    private func addBoardImageViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(boardImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 180))
        constraints.append(boardImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(boardImageView.widthAnchor.constraint(equalToConstant: 95))
        constraints.append(boardImageView.heightAnchor.constraint(equalToConstant: 310))
        
        // Apply
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Weight Picker View
    
    private let weightPickerView: UIPickerView = {
        let weightPickerView = UIPickerView()
        weightPickerView.translatesAutoresizingMaskIntoConstraints = false
        return weightPickerView
    }()
    
    private func addWeightPickerViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(weightPickerView.topAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: -100))
        constraints.append(weightPickerView.centerXAnchor.constraint(equalTo: bottomStackView.centerXAnchor))
        constraints.append(weightPickerView.widthAnchor.constraint(equalToConstant: 100))
        constraints.append(weightPickerView.heightAnchor.constraint(equalToConstant: 300))
        
        // Apply
        NSLayoutConstraint.activate(constraints)
    }
    
    private func constructWeightPickerView() {
        view.addSubview(weightPickerView)
        addWeightPickerViewConstraints()
        weightPickerView.delegate = self
        weightPickerView.dataSource = self
        
        let middleOfPicker = weightArray.count / 2
        weightPickerView.selectRow(middleOfPicker, inComponent: 0, animated: false)
        
        let rotationAngle: CGFloat = -90 * (.pi/180)
        weightPickerView.transform = CGAffineTransform(rotationAngle: rotationAngle)
    }
    
    
    // MARK: - Obj-C Functions
    
    @objc func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        if boardIndex < boardImgList.count - 1 {
            boardIndex = boardIndex + 1
            let boardName = boardImgList[boardIndex]
            boardImageView.image = UIImage(named: "\(boardName).svg")
            boardType.text = "\(boardName)"
            getNewRecommendation()
        }
    }
    
    @objc func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        if boardIndex > 0 {
            boardIndex = boardIndex - 1
            let boardName = boardImgList[boardIndex]
            boardImageView.image = UIImage(named: "\(boardName).svg")
            boardType.text = "\(boardName)"
            getNewRecommendation()
        }
    }
    
    @objc func leftLevelButtonClicked() {
        if skillLevel == "INTERMEDIATE" {
            buttonLeft.setTitleColor(#colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1), for: .normal)
            buttonLeft.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            buttonLeft.layer.borderWidth = 2.0
            buttonLeft.layer.borderColor = #colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1)
            
            buttonRight.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            buttonRight.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1)
            buttonRight.layer.borderWidth = 0
            skillLevel = "BEGINNER"
            getNewRecommendation()
        }
    }
    
    @objc func rightLevelButtonClicked() {
        if skillLevel == "BEGINNER" {
            buttonRight.setTitleColor(#colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1), for: .normal)
            buttonRight.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            buttonRight.layer.borderWidth = 2.0
            buttonRight.layer.borderColor = #colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1)
            
            buttonLeft.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            buttonLeft.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1)
            buttonLeft.layer.borderWidth = 0
            skillLevel = "INTERMEDIATE"
            getNewRecommendation()
        }
    }
    
    @objc func settingsClicked() {
        let settingsVC = SettingsViewController()
        present(settingsVC, animated: true, completion: nil)
    }
}
