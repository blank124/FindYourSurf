//
//  BeachCell.swift
//  FindYourSurf
//
//  Created by Michael Blank on 1/17/21.
//

import UIKit

class BeachCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
     var beach : Beach? {
         didSet {
            nameLabel.text = beach?.name
            addressLabel.text = beach?.address
            createStars(numStars: beach?.stars ?? 5)
        }
     }
     
     
     private let nameLabel : UILabel = {
     let lbl = UILabel()
     lbl.textColor = #colorLiteral(red: 0.09803921569, green: 0.2509803922, blue: 0.431372549, alpha: 1)
     lbl.font = UIFont(name: "Poppins-SemiBold", size: 16)
     lbl.textAlignment = .left
     return lbl
     }()
     
     
     private let addressLabel : UILabel = {
     let lbl = UILabel()
     lbl.textColor = .gray
     lbl.font = UIFont(name: "Poppins-SemiBold", size: 12)
     lbl.textAlignment = .left
     lbl.numberOfLines = 0
     return lbl
     }()
    
    private var starsView: UIImageView = {
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
    
     
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
     addSubview(nameLabel)
     addSubview(addressLabel)
     addSubview(starsView)
     
        
    nameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 5, paddingRight: 0, width: 300, height: 0, enableInsets: false)
     addressLabel.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 400, height: 0, enableInsets: false)
    starsView.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 80, height: 0, enableInsets: false)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
     func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
     var topInset = CGFloat(0)
     var bottomInset = CGFloat(0)
     
     if #available(iOS 11, *), enableInsets {
     let insets = self.safeAreaInsets
     topInset = insets.top
     bottomInset = insets.bottom
     
        print("Top: \(topInset)")
        print("bottom: \(bottomInset)")
     }
     
     translatesAutoresizingMaskIntoConstraints = false
     
     if let top = top {
     self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
     }
     if let left = left {
     self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
     }
     if let right = right {
     rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
     }
     if let bottom = bottom {
     bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
     }
     if height != 0 {
     heightAnchor.constraint(equalToConstant: height).isActive = true
     }
     if width != 0 {
     widthAnchor.constraint(equalToConstant: width).isActive = true
     }
     
     }
}
