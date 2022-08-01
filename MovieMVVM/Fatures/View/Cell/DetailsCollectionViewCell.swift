//
//  DetailsCollectionViewCell.swift
//  theMovieDb
//
//  Created by İSMAİL AÇIKYÜREK on 31.07.2022.
//

import UIKit
import Kingfisher
class DetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var photoimageView: UIImageView!
    
    func configure(content: ResultB) {
      
        guard let urlStr = content.title else { return }
        lblTitle.text = urlStr
    
     
        guard let urlStr = content.posterPath else { return }
        let UrlFront = "https://image.tmdb.org/t/p/w500"
        let Url = "\(UrlFront)\(urlStr)"
      
        photoimageView.kf.setImage(with:URL(string: Url))
        photoimageView.layer.cornerRadius = 8
        photoimageView.layer.borderWidth = 3
        photoimageView.layer.borderColor = CGColor(red: 120/250, green: 120/250, blue: 120/250, alpha: 1)
            
    }
    
}
