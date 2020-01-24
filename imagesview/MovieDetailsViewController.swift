//
//  MovieDetailsViewController.swift
//  imagesview
//
//  Created by Marni Anuradha on 12/12/19.
//  Copyright © 2019 Marni Anuradha. All rights reserved.
//
import UIKit
import AVKit
import AVFoundation

class MovieDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var directorNameLbl: UILabel!
    
    @IBOutlet weak var actorStackView: UIStackView!
    
    @IBOutlet weak var storyLbl: UILabel!
    
    @IBOutlet weak var trailerView: UIView!
    
    
    @IBOutlet weak var audioStackView: UIStackView!
    
    
    var avPlayer:AVPlayerViewController!
    var audioBtnArray = [UIButton]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       imageView.image = GettingMoviesData.shared.moviePosterImage[GettingMoviesData.shared.movieBtnTags]
       directorNameLbl.text = GettingMoviesData.shared.MoviesTitle[GettingMoviesData.shared.movieBtnTags]
        directorNameLbl.text = GettingMoviesData.shared.directorName[GettingMoviesData.shared.movieBtnTags]
        storyLbl.text = GettingMoviesData.shared.moviesStory[GettingMoviesData.shared.movieBtnTags]
        
        movieAudioDetails()
        movieVideoDetails()
        actorDetails()

    }
    
    // function for Trailer
    
    func movieVideoDetails(){
        
        
        avPlayer = AVPlayerViewController()
        avPlayer = GettingMoviesData.shared.movieTrailer[GettingMoviesData.shared.movieBtnTags]
        avPlayer.view.frame = CGRect(x: 0, y: 0, width: trailerView.frame.width, height: trailerView.frame.height)
        trailerView.addSubview(avPlayer.view)
            
        }
    // function for ActorDetails
    
    func actorDetails() {
        
        for i in GettingMoviesData.shared.actorsNames[GettingMoviesData.shared.movieBtnTags]
        {
            let actorNameLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
            
            actorNameLbl.text = "\(i)"
            actorStackView.addArrangedSubview(actorNameLbl)
        
        }
    }
    
    // function for Audio
    
    func movieAudioDetails() {
        var number = 1
        if (GettingMoviesData.shared.audioSongArray[GettingMoviesData.shared.movieBtnTags].count == 0)
        {
            print("No Songs available")
        }
        else
        {
            for x in 0...GettingMoviesData.shared.audioSongArray[GettingMoviesData.shared.movieBtnTags].count-1
            {
                let button = UIButton()
                button.addTarget(self, action: #selector(playAndPause(sender:)), for: UIControl.Event.touchUpInside)
                button.backgroundColor = .black
                button.translatesAutoresizingMaskIntoConstraints = false
                button.widthAnchor.constraint(equalToConstant: 300).isActive = true
                button.tag = x
                button.setTitle("song\(number)", for: UIControl.State.normal)
                
                number += 1
                
                audioBtnArray.append(button)
                audioStackView.addArrangedSubview(button)
            }
        }
        
    }
    

    @IBAction func onBackBtn(_ sender: Any) {
  
  dismiss(animated: true, completion: nil)
        
    }
    
    let audioPlayer = AVPlayerViewController()
    
    @objc func playAndPause(sender:UIButton)
    {

        GettingMoviesData.shared.buttonTapped = sender.tag
        
        let audio = GettingMoviesData.shared.audioSongArray[GettingMoviesData.shared.movieBtnTags!][sender.tag]
        
        let data = AVPlayer(url: URL(string: audio)!)
        
        audioPlayer.player = data
        
//        data.play()
//
//        if((data.rate != 0) && (data.error == nil)) {
//            print("========audioPlaying========")
//        }
//
        present(audioPlayer, animated: true) {
            if((self.audioPlayer.player!.rate != 0) && (self.audioPlayer.player?.error == nil)) {
                print("Audio Playing")
                
            }
        }
    }
    
    

}

