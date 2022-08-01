//
//  SliderCollectionViewCell.swift
//  theMovieDb
//
//  Created by İSMAİL AÇIKYÜREK on 30.07.2022.
//

import UIKit
import Kingfisher


class SliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var PhotoimageView: UIImageView!
    
    func configure(content: Result) {
      
        guard let urlStr = content.originalTitle else { return }
        lblTitle.text = urlStr
        lblDescription.text = content.overview
        guard let urlStr = content.backdropPath else { return }
        let UrlFront = "https://image.tmdb.org/t/p/w500"
        let Url = "\(UrlFront)\(urlStr)"
       PhotoimageView.kf.setImage(with:URL(string: Url))
            
    }
}
