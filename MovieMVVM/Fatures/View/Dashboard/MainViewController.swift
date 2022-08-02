//
//  ViewController.swift
//  MovieMVVM
//
//  Created by İSMAİL AÇIKYÜREK on 1.08.2022.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {

    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var sliderCollection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let refreshControl: UIRefreshControl = UIRefreshControl()
    var modelNowPlaying : NowPlaying?
    var modelUpcoming : Upcoming?
    var modelSearch : Search?
    var modelUpcomingSend : ResultUpcoming?
    var modelSearchSend : ResultSearch?
    var searchDo : Bool?
    let viewModel : DashboardViewModelProtocol = DashboardViewModel()
    var timer : Timer?
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = searchBar
        viewModel.setUpDelegate(self)
        viewModel.initialize()
       startTimer()
        pageView.numberOfPages = 20
        searchBar.delegate = self

        //reflesh
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.blue
        movieTableView.addSubview(refreshControl)
}

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(movieToIndex), userInfo: nil, repeats: true)
    }
    @objc func movieToIndex() {
        if currentIndex == 19 {
            currentIndex = -1
        } else {
            currentIndex += 1
            sliderCollection.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
            pageView.currentPage = currentIndex
        }
    }
   @objc func refresh(sender:AnyObject) {
        sliderCollection.reloadData()
        movieTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let nextViewController = segue.destination as? DetailsViewController
            if searchDo == true {
               nextViewController!.modelSearch = modelSearchSend
            } else {
                nextViewController!.modelUpcoming = modelUpcomingSend
            }
            
        }
    }
}


extension MainViewController : DashboardViewModelOutputProtocol{
    func showDataSearch(content: Search) {
         modelSearch = content
    }
    func showDataUpcoming(content: Upcoming) {
        modelUpcoming = content
        movieTableView.reloadData()
    }
    func showDataNowPlaying(content: NowPlaying) {
        modelNowPlaying = content
        sliderCollection.reloadData()
    }
}

//CollectionView

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = sliderCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SliderCollectionViewCell
       
        if let content = modelNowPlaying?.results?[indexPath.row] {
        cell.configure(content: content)
        }
     
       return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sliderCollection.frame.width, height: sliderCollection.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

//TableView
extension MainViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! MovieTableViewCell
        var searchFormat = ""
        if searchDo == true {
            for k in searchBar.text! {
                searchFormat.append(k)
                if searchFormat.count == 3 {
                    break
                }
            }
     
            viewModel.theMovieServiceSearch(search: searchFormat)
           
            cell.textLabel?.text = modelSearch?.results?[indexPath.row].title
            cell.lblTitle.isHidden = true
            cell.lblDates.isHidden = true
            cell.lblDescirption.isHidden = true
            cell.PhotoimageView.isHidden = true
            movieTableView.rowHeight = 50
        } else {
            movieTableView.rowHeight = 153
            cell.lblTitle.isHidden = false
            cell.lblDates.isHidden = false
            cell.lblDescirption.isHidden = false
            cell.PhotoimageView.isHidden = false
            cell.textLabel?.text = ""
            if let content = modelUpcoming?.results?[indexPath.row] {
            cell.configure(content: content)
            
            }
        }
        return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       modelSearchSend = modelSearch?.results?[indexPath.row]
        modelUpcomingSend = modelUpcoming?.results?[indexPath.row]
        performSegue(withIdentifier: "goToDetail", sender: indexPath)
    }
}

extension MainViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchDo = true
        if searchDo == true {
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
            }
        } else {

            DispatchQueue.main.async {
                self.movieTableView.reloadData()
                }
        }
        if searchText == "" {
            searchDo = false
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchDo = false
        searchBar.text = ""
        DispatchQueue.main.async {
            self.movieTableView.reloadData()
        }
    }
}

