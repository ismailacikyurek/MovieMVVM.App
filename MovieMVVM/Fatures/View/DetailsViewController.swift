//
//  DetaitsViewController.swift
//  theMovieDb
//
//  Created by İSMAİL AÇIKYÜREK on 31.07.2022.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {

    @IBOutlet weak var lblımdb: UILabel!
    @IBOutlet weak var PhotoİmageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    let viewModel : DashboardViewModelProtocol = DashboardViewModel()
    var modelSimilar : Similar?
   
   @IBOutlet weak var sliderCollection: UICollectionView!
    @IBOutlet weak var txtDescription: UITextView!
    var modelSearch : ResultA?
    var modelUpcoming : Resultt?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.initialize()
        viewModel.setUpDelegate(self)
        sliderCollection.delegate = self
        sliderCollection.dataSource = self
        
        if modelSearch != nil {
            label.text = modelSearch?.title
            lblDate.text = modelSearch?.releaseDate
            txtDescription.text = modelSearch?.overview
            lblımdb.text = "\(modelSearch!.voteAverage!)"
            
            guard let urlStr = modelSearch?.posterPath  else { return } //BAZI FİLMLERDE POSTERPATH , BAZILARINDA BACKDROPPATH BOŞ OLDUĞU İÇİN, HANGİSİ VARSA EKRANDA GÖSTERİLSİN.
            let urlFront = "https://image.tmdb.org/t/p/w500"
            let Url = "\(urlFront)\(urlStr)"
            PhotoİmageView.kf.setImage(with:URL(string: Url))
            
            guard let urlStrPosther = modelSearch?.backdropPath  else { return }//BAZI FİLMLERDE POSTERPATH , BAZILARINDA BACKDROPPATH BOŞ OLDUĞU İÇİN, HANGİSİ VARSA EKRANDA GÖSTERİLSİN.
            print("URLPSOTER\(urlStrPosther)")
            let UrlPor = "\(urlFront)\(urlStrPosther)"
            PhotoİmageView.kf.setImage(with:URL(string: UrlPor))
            
            
            navigationItem.title = modelSearch?.title
            viewModel.theMovieServiceSimilar(id: (modelSearch?.id)!)
        } else {
            label.text = modelUpcoming?.title
            lblDate.text = modelUpcoming?.releaseDate
            txtDescription.text = modelUpcoming?.overview
            lblımdb.text = "\(modelUpcoming!.voteAverage!)"
            guard let urlStr = modelUpcoming?.backdropPath else { return }
            let urlFront = "https://image.tmdb.org/t/p/w500"
            let Url = "\(urlFront)\(urlStr)"
            PhotoİmageView.kf.setImage(with:URL(string: Url))
            navigationItem.title = modelUpcoming?.title
            viewModel.theMovieServiceSimilar(id: (modelUpcoming?.id)!)
           
        }
    }
}

extension DetailsViewController : DashboardViewModelOutputProtocol {
    func showDataNowPlaying(content: NowPlaying) {}
    func showDataUpcoming(content: Upcoming) {}
    func showDataSearch(content: Search) {}
    func showDataSimilar(content: Similar) {
        modelSimilar = content
        }
}


extension DetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sliderCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DetailsCollectionViewCell
        if let content = modelSimilar?.results?[indexPath.row] {
        cell.configure(content: content)
       }
        
        DispatchQueue.main.async {
            self.sliderCollection.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sliderCollection.frame.width/4, height: sliderCollection.frame.height-20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}


