//
//  MovieableViewCell.swift
//  theMovieDb
//
//  Created by İSMAİL AÇIKYÜREK on 30.07.2022.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var PhotoimageView: UIImageView!
    @IBOutlet weak var lblDescirption: UILabel!
    @IBOutlet weak var lblDates: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(content: ResultUpcoming) {
        lblTitle.text = content.title
        lblDescirption.text =  content.overview
        lblDates.text = content.releaseDate
        guard let urlStr = content.posterPath else { return }
        let UrlFront = "https://image.tmdb.org/t/p/w500"
        let Url = "\(UrlFront)\(urlStr)"
        PhotoimageView.kf.setImage(with:URL(string: Url))
        PhotoimageView.layer.cornerRadius = 15
        
    }


}
