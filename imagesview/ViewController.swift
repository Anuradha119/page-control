//
//  ViewController.swift
//  Page Control
//
//  Created by Marni Anuradha on 12/12/19.
//  Copyright © 2019 Marni Anuradha. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController,UIScrollViewDelegate {


    
    @IBOutlet weak var postersPageControllerObj: UIPageControl!
    
    
       //Variable Decalration
       
       var userData:[[String:Any]]!
       var buttonsArray:[UIButton] = []
       var labelsArray:[UILabel] = []
       var audioURLs:[[String]] = [[]]
       let scrollView = UIScrollView()
       var postersBtnArray = [UIButton]()
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.delegate = self
    }

// MARK:- refresh button action
    @IBAction func onButtonTap(_ sender: Any)
    {
    creatingComponents()
         Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerEventHandler), userInfo: nil, repeats: true)
    }
        
            
         // function for  component Creation
            
            func creatingComponents()
            {
             // MARK:- Page Controller
                
             postersPageControllerObj.addTarget(self, action: #selector(pageControlEventHandler), for: UIControl.Event.valueChanged)
             
             // MARK:- Scroll View
             
             scrollView.frame = CGRect(x: 0, y: 160, width: view.frame.width, height: 400)
             scrollView.showsHorizontalScrollIndicator = false
             scrollView.isPagingEnabled = true
             view.addSubview(self.scrollView)
                
                var j = 0
                let moviesData = GettingMoviesData.shared.gettingMoviesDetails()
                
                for x in postersBtnArray
                {
                    x.removeFromSuperview()
                }
                
                postersBtnArray = [UIButton]()
                
                buttonsArray = [UIButton]()
                labelsArray = [UILabel]()
                
                GettingMoviesData.shared.movieBtnTags = 0
                GettingMoviesData.shared.moviesStory = [String]()
                GettingMoviesData.shared.MoviesTitle = [String]()
                GettingMoviesData.shared.actorsNames = [[String]]()
                GettingMoviesData.shared.directorName = [String]()
                GettingMoviesData.shared.moviePosterImage = [UIImage]()
                    
                postersPageControllerObj.numberOfPages = moviesData.count
                
                var x = 0
                for i in moviesData
                {
                    var poster = i.posters
                    let posterData = poster![0]
                    let url = posterData.replacingOccurrences(of: " ", with: "%20")
                    let urlNew = URL(string: "https://www.brninfotech.com/tws/\(url)")
                    let posterDataTask = URLSession.shared.dataTask(with: urlNew!)
                    { (posterData, connDetails, error) in
                        
                    DispatchQueue.main.async {
                       
                        let posterButton = UIButton()
                        posterButton.frame = CGRect(x: CGFloat(x) * self.scrollView.frame.width, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
                                           
                        self.postersBtnArray.append(posterButton)
                                          posterButton.setImage(UIImage(data: posterData!), for: UIControl.State.normal)
                                           posterButton.backgroundColor = UIColor.black
                                          self.scrollView.addSubview(posterButton)
                                           x += 1
                                       
                                           
                                           
                                           posterButton.addTarget(self, action: #selector(self.movieDetails(_:)), for: UIControl.Event.touchUpInside)
                    
                   
                        
                        posterButton.tag = j
                            j += 1
                    
                    // Label Creation
                        
                        let movieTitle = i.title
                        let titleLabel = UILabel()
                        titleLabel.text = movieTitle
                        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
                        titleLabel.textAlignment = .center
                        titleLabel.textColor = UIColor.black
                        self.labelsArray.append(titleLabel)
                        
                        
                        
                        
                        GettingMoviesData.shared.moviePosterImage.append(UIImage(data: posterData!)!)
                    
                        GettingMoviesData.shared.directorName.append(i.director as! String)
                        
                        GettingMoviesData.shared.MoviesTitle.append(i.title as! String)
                        
                        GettingMoviesData.shared.moviesStory.append(i.story as? String ?? "Story is not available")
                        
                        print("***********************")
                        
                        let actorsName = i.actors
                        GettingMoviesData.shared.actorsNames.append(actorsName!)
                        
                        let video = (i.trailers!)[0]
                        let videoURL = video.replacingOccurrences(of: " ", with: "%20")
                        let videoAVPlayer = AVPlayerViewController()
                        videoAVPlayer.player = AVPlayer(url: URL(string: "https://www.brninfotech.com/tws/\(videoURL)")!)
                       GettingMoviesData.shared.movieTrailer.append(videoAVPlayer)
                        
                        let arraySong:[String] = i.songs!
                        
                        let convString = arraySong.joined(separator: "")
                        
                        let string:String = "https://www.brninfotech.com/tws/ "
                        let addString = string.replacingOccurrences(of: " ", with: convString,options: .literal,range: nil)
                        
                        let finalStringSong = addString.replacingOccurrences(of: " ", with: "%20",options: .literal,range: nil)
                        
                        var allSongsUrlInString = [String]()
                        
                        let stringSong:String = "httpa://www.brninfotech.com/tws/"
                        
                        for n in arraySong
                        {
                            let urlData = n.replacingOccurrences(of: " ", with: "%20")
                            
                            allSongsUrlInString.append(stringSong + urlData)
                        }
                        GettingMoviesData.shared.audioSongArray.append(allSongsUrlInString)
                    
            }
            
                
            }
            
                    posterDataTask.resume()
            scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(x), height: scrollView.frame.height)
        }
            
        }
            @objc func movieDetails(_ sender: UIButton){
                
                GettingMoviesData.shared.movieBtnTags = sender.tag
                
                let movieDetailsVC = storyboard?.instantiateViewController(identifier: "svc") as! MovieDetailsViewController
                
                present(movieDetailsVC, animated: true, completion: nil)
                
            }

    
           
          
            // MARK:- Page Controller event handler
                
                @objc func pageControlEventHandler()
                {
                    scrollView.contentOffset.x = CGFloat(postersPageControllerObj.currentPage) * scrollView.frame.width
                    scrollView.contentOffset.y = 50
                }
                
                // MARK:- scrollView
                
                func scrollViewDidScroll(_ scrollView: UIScrollView)
                {
                    postersPageControllerObj.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
                }
                
                // MARK:- timer event handler
                
                @objc func timerEventHandler()
                {
                    if(postersPageControllerObj.currentPage != postersBtnArray.count-1)
                    {
                        postersPageControllerObj.currentPage += 1
                        
                    }
                    else
                    {
                        postersPageControllerObj.currentPage = 0
                    }
                    
                    scrollView.contentOffset.x = CGFloat(postersPageControllerObj.currentPage * Int(scrollView.frame.width))
                }
                
            }

        
