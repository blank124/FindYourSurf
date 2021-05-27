//
//  ContentViewController.swift
//  FindYourSurf
//
//  Created by Michael Blank on 1/16/21.
//

import UIKit
import Firebase

class ContentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var docRef: DocumentReference!
    let beachCell: String = "beachCell"
    var beaches: [Beach] = []
        
    
    let db = Firestore.firestore()
    

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Beaches from Firebase
        loadMessages()
        
        // Add Title Field
        view.addSubview(titleText)
        addTitleTextConstraints()
 
        // Table View
        myTableView.register(BeachCell.self, forCellReuseIdentifier: beachCell)
        myTableView.delegate = self
        myTableView.dataSource = self
        
        
    }
    
    // MARK: - Load Firebase Beaches
    
    func loadMessages() {
        
        db.collection("los_angeles")
//            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            
            self.beaches = []
            
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let beachName = data["name"] as? String, let beachAddress = data["address"] as? String, let beachStars = data["stars"] as? Int {
                            let newBeach = Beach(name: beachName, address: beachAddress, stars: beachStars)
                            self.beaches.append(newBeach)

                            DispatchQueue.main.async {
                                   self.myTableView.reloadData()
                                let indexPath = IndexPath(row: self.beaches.count - 1, section: 0)
                                self.myTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }

    
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        beaches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: beachCell, for: indexPath) as! BeachCell
        let currentLast = beaches[indexPath.row]
        cell.beach = currentLast
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: - Title Text
    
    private let titleText: UITextField = {
        let weightTextField = UITextField()
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.text = "SURF SPOTS NEAR YOU"
        weightTextField.isUserInteractionEnabled = false
        weightTextField.font = UIFont(name: "Poppins-SemiBold", size: 18)
        weightTextField.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1)
        weightTextField.textColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        weightTextField.textAlignment = .center
        return weightTextField
    }()
    
    private func addTitleTextConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
//        constraints.append(titleText.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(titleText.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(titleText.widthAnchor.constraint(equalTo: view.widthAnchor))
        constraints.append(titleText.heightAnchor.constraint(equalToConstant: 80))
        
        // Apply
        NSLayoutConstraint.activate(constraints)
    }

}
