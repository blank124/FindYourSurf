//
//  Firebase.swift
//  FindYourSurf
//
//  Created by Michael Blank on 1/20/21.
//

import Foundation
import Firebase

struct BeachesService {
    
    static func loadBeaches(completion: @escaping ([Beach]) -> ()) {
        let locationRef = Firestore.firestore().collection("los_angeles")
        
        locationRef.getDocuments(completion: { (querySnapshot, error) in
            var beaches = [Beach]()
            
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
                return
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let beachName = data["name"] as? String, let beachAddress = data["address"] as? String, let beachStars = data["stars"] as? Int {
                            let newBeach = Beach(name: beachName, address: beachAddress, stars: beachStars)
                            beaches.append(newBeach)
                            
                        }
                    }
                    completion(beaches)
                }
            }
        })
    }
}
