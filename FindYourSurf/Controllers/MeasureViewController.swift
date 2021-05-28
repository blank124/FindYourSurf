//
//  MeasureViewController.swift
//  FindYourSurf
//
//  Created by Michael Blank on 1/16/21.
//

import UIKit
import FloatingPanel

class MeasureViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, FloatingPanelControllerDelegate, UIGestureRecognizerDelegate {
    
    var boardImgList = ["SHORTBOARD", "FISH", "FUNBOARD", "FOAMY", "LONGBOARD", "GUN"]
    var boardIndex = 0
    
    var skillLevel = "BEGINNER"
    var currentWeight = 50
    
    let weightArray = Array(0...100)
    
    var fpc: FloatingPanelController!
    var recommender = BoardType()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        
        // Handle Board Swipes
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe(_:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe(_:)))
        view.addGestureRecognizer(rightSwipe)
        
        // Build Floating Panel
        buildFloatingPanel()
    }
    
    // MARK: - Functions
    
    private func setupViews() {
        
        // Build top Stack View
        view.addSubview(topStackView)
        topStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 354, height: 33)
        constructTopStackView()
        
        // Build Middle Board Label and Size
        view.addSubview(middleStackView)
        middleStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 70, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 200, height: 96)
        constructMiddleStackView()
        
        // Add background Image
        view.addSubview(backgroundImage)
        backgroundImage.anchor(top: middleStackView.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 340, height: 260)
        
        // Build Board Image View
        view.addSubview(boardImageView)
        boardImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 180, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 95, height: 310)
       
        // Build Level Switch
        view.addSubview(levelStackView)
        levelStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 520, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 240, height: 43)
        levelStackView.addSubview(buttonLeft)
        buttonLeft.anchor(top: levelStackView.topAnchor, left: nil, bottom: nil, right: levelStackView.centerXAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 43)
        levelStackView.addSubview(buttonRight)
        buttonRight.anchor(top: levelStackView.topAnchor, left: levelStackView.centerXAnchor, bottom: nil, right: nil, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 43)
       
        // Build Bottom View
        view.addSubview(bottomStackView)
        bottomStackView.anchor(top: levelStackView.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 310, height: 200)
        constructBottomStackView()
    }
    
    // MARK: - Floating Panel
    
    private func buildFloatingPanel() {
        fpc = FloatingPanelController()
        fpc.delegate = self
        let contentVC = BeachesViewController()
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
        fpc.track(scrollView: contentVC.beachesTableView)
        fpc.surfaceView.appearance.cornerRadius = 20.0
    }
    
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
        label.textColor = UIColor.customColor(.surfBlue)
        label.textAlignment = .center
        label.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        return label
    }
    
    // MARK: - Background Image
    
    private lazy var backgroundImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "lines_background"))
        return img
    }()
    
    // MARK: - Top Stack View
    
    private lazy var appName: UITextField = {
        let appName = UITextField(frame: CGRect(x: 40, y: 3, width: 133, height: 30))
        appName.text = "Find Your Surf"
        appName.isUserInteractionEnabled = false
        appName.font = UIFont(name: "Poppins-Bold", size: 18)
        appName.backgroundColor = nil
        appName.textColor = UIColor.customColor(.surfBlue)
        return appName
    }()
    
    private lazy var topStackView: UIStackView = {
        let topStackView = UIStackView()
        return topStackView
    }()
    
    private func constructTopStackView() {
        let logo = UIImageView(image: UIImage(named: "wave_blue_circle.png"))
        logo.frame = CGRect(x: 0, y: 0, width: 33, height: 33)
        topStackView.addSubview(logo)
        topStackView.addSubview(appName)
    }
    
    // MARK: - Middle Stack View
    
    private lazy var boardType: UITextField = {
        let boardType = UITextField(frame: CGRect(x: 0, y: 0, width: 180, height: 56))
        boardType.isUserInteractionEnabled = false
        boardType.font = UIFont(name: "Poppins-Bold", size: 22)
        boardType.backgroundColor = nil
        boardType.textColor = UIColor.customColor(.surfBlue)
        boardType.text = "SHORTBOARD"
        return boardType
    }()
    
    private lazy var boardSize: UITextField = {
        let boardSize = UITextField(frame: CGRect(x: 0, y: 35, width: 124, height: 60))
        boardSize.isUserInteractionEnabled = false
        boardSize.font = UIFont(name: "Poppins-Bold", size: 48)
        boardSize.backgroundColor = nil
        boardSize.textColor = UIColor.customColor(.surfBlue)
        return boardSize
    }()
    
    private lazy var middleStackView: UIStackView = {
        let middleStackView = UIStackView()
        return middleStackView
    }()
    
    private func constructMiddleStackView() {
        middleStackView.addSubview(boardType)
        middleStackView.addSubview(boardSize)
        getNewRecommendation()
    }
    
    private func getNewRecommendation() {
        recommender.calculateRecommendation(weight: currentWeight, skillLevel: skillLevel, boardType: boardImgList[boardIndex])
        let newBoardSize = recommender.getBoardSize()
        boardSize.text = newBoardSize
    }
    
    // MARK: - Skill Level Stack View
    
    private lazy var buttonLeft: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("BEGINNER", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Poppins-SemiBold", size: 14)
        button.setTitleColor(UIColor.customColor(.surfBlue), for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.customColor(.surfBlue).cgColor
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        button.addTarget(self, action: #selector(leftLevelButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonRight: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("INTERMEDIATE", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Poppins-SemiBold", size: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.customColor(.surfBlue)
        button.layer.cornerRadius = 10.0
        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        button.addTarget(self, action: #selector(rightLevelButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var levelStackView: UIStackView = {
        let levelStackView = UIStackView()
        return levelStackView
    }()
    
    // MARK: - Bottom Stack View
    
    private lazy var weightTextField: UITextField = {
        let weightTextField = UITextField(frame: CGRect(x: 70, y: 90, width: 166, height: 36))
        weightTextField.text = "YOUR WEIGHT (KG)"
        weightTextField.isUserInteractionEnabled = false
        weightTextField.font = UIFont(name: "Poppins-SemiBold", size: 14)
        weightTextField.backgroundColor = nil
        weightTextField.textColor = UIColor.customColor(.surfBlue)
        return weightTextField
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let bottomStackView = UIStackView()
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
    
    // MARK: - Board Image View
    
    private lazy var boardImageView: UIImageView = {
        let board = UIImageView(image: UIImage(named: "SHORTBOARD.svg"))
        return board
    }()
    
    // MARK: - Weight Picker View
    
    private lazy var weightPickerView: UIPickerView = {
        let weightPickerView = UIPickerView()
        return weightPickerView
    }()
    
    private func constructWeightPickerView() {
        view.addSubview(weightPickerView)
        weightPickerView.anchor(top: bottomStackView.topAnchor, left: nil, bottom: nil, right: nil, centerX: bottomStackView.centerXAnchor, centerY: nil, paddingTop: -100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 300)
        
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
            buttonLeft.setTitleColor(UIColor.customColor(.surfBlue), for: .normal)
            buttonLeft.backgroundColor = .white
            buttonLeft.layer.borderWidth = 2.0
            buttonLeft.layer.borderColor = UIColor.customColor(.surfBlue).cgColor
            
            buttonRight.setTitleColor(.white, for: .normal)
            buttonRight.backgroundColor = UIColor.customColor(.surfBlue)
            buttonRight.layer.borderWidth = 0
            skillLevel = "BEGINNER"
            getNewRecommendation()
        }
    }
    
    @objc func rightLevelButtonClicked() {
        if skillLevel == "BEGINNER" {
            buttonRight.setTitleColor(UIColor.customColor(.surfBlue), for: .normal)
            buttonRight.backgroundColor = .white
            buttonRight.layer.borderWidth = 2.0
            buttonRight.layer.borderColor = UIColor.customColor(.surfBlue).cgColor
    
            buttonLeft.setTitleColor(.white, for: .normal)
            buttonLeft.backgroundColor = UIColor.customColor(.surfBlue)
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
