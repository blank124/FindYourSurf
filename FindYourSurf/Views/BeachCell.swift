//
//  BeachCell.swift
//  FindYourSurf
//
//  Created by Michael Blank on 1/17/21.
//

import UIKit

class BeachCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
     addSubview(nameLabel)
     addSubview(addressLabel)
     addSubview(starsView)
     
        
    nameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 5, paddingRight: 0, width: 300, height: 0)
     addressLabel.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 400, height: 0)
    starsView.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 80, height: 0)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     var beach : Beach? {
         didSet {
            nameLabel.text = beach?.name
            addressLabel.text = beach?.address
            createStars(numStars: beach?.stars ?? 5)
        }
     }
     
     
     private lazy var nameLabel : UILabel = {
     let lbl = UILabel()
     lbl.textColor = UIColor.customColor(.surfBlue)
     lbl.font = UIFont(name: "Poppins-SemiBold", size: 16)
     lbl.textAlignment = .left
     return lbl
     }()
     
     
     private lazy var addressLabel : UILabel = {
     let lbl = UILabel()
     lbl.textColor = .gray
     lbl.font = UIFont(name: "Poppins-SemiBold", size: 12)
     lbl.textAlignment = .left
     lbl.numberOfLines = 0
     return lbl
     }()
    
    private lazy var starsView: UIImageView = {
        let lbl = UIImageView(image: UIImage(named: "five_star.svg"))
        return lbl
    }()
    
    private func createStars(numStars: Int){
        switch numStars {
        case 1:
            self.starsView.image = UIImage(named: "one_star.svg")
        case 2:
            self.starsView.image = UIImage(named: "two_star.svg")
        case 3:
            self.starsView.image = UIImage(named: "three_star.svg")
        case 4:
            self.starsView.image = UIImage(named: "four_star.svg")
        case 5:
            self.starsView.image = UIImage(named: "five_star.svg")
        default:
            self.starsView.image = UIImage(named: "five_star.svg")
        }
    }

}
