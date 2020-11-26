//
//  HotelCell.swift
//  Hotels
//
//  Created by Dilan Anuruddha on 11/26/20.
//

import UIKit

class HotelCell: UITableViewCell {
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }
        setupView()
    }
    
    //MARK: Components
    let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let lblAddress : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .light)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let imgPic: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.darkGray.cgColor
        iv.layer.borderWidth = 0.5
        return iv
    }()
    
    //MARK: Setup UI
    func setupView() {
        addSubViews(lblTitle,lblAddress,imgPic)
        NSLayoutConstraint.activate([
        
            imgPic.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imgPic.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imgPic.widthAnchor.constraint(equalToConstant: 50),
            imgPic.heightAnchor.constraint(equalToConstant: 50),
            
            lblTitle.leadingAnchor.constraint(equalTo: imgPic.trailingAnchor, constant: 16),
            lblTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            lblAddress.leadingAnchor.constraint(equalTo: imgPic.trailingAnchor, constant: 16),
            lblAddress.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            lblAddress.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 4),
            lblAddress.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor,constant: -16),
        ])
        imgPic.layer.cornerRadius = 25
    }

}
