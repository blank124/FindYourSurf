//
//  ContentViewController.swift
//  FindYourSurf
//
//  Created by Michael Blank on 1/16/21.
//

import UIKit

class BeachesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let beachCell: String = "beachCell"
    var beaches: [Beach] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Title Field
        view.addSubview(titleText)
        titleText.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 80)
        
        // Table View
        view.addSubview(beachesTableView)
        beachesTableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 80, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        // Load Beaches from Firebase
        BeachesService.loadBeaches(completion: { [weak self] (result) in
            if let self = self {
                self.beaches = result
                DispatchQueue.main.async {
                    self.beachesTableView.reloadData()
                    let indexPath = IndexPath(row: self.beaches.count - 1, section: 0)
                    self.beachesTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                }
            }
        })
        
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        beaches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = beachesTableView.dequeueReusableCell(withIdentifier: beachCell, for: indexPath) as! BeachCell
        let currentLast = beaches[indexPath.row]
        cell.beach = currentLast
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    lazy var beachesTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = UITableView.automaticDimension
        tv.register(BeachCell.self, forCellReuseIdentifier: beachCell)
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    // MARK: - Title Text
    
    private lazy var titleText: UITextField = {
        let weightTextField = UITextField()
        weightTextField.text = "SURF SPOTS NEAR YOU"
        weightTextField.isUserInteractionEnabled = false
        weightTextField.font = UIFont(name: "Poppins-SemiBold", size: 18)
        weightTextField.backgroundColor = UIColor.customColor(.surfBlue)
        weightTextField.textColor = .white
        weightTextField.textAlignment = .center
        return weightTextField
    }()
    
}
