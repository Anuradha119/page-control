//
//  GettingData.swift
//  imagesview
//
//  Created by Marni Anuradha on 12/12/19.
//  Copyright © 2019 Marni Anuradha. All rights reserved.
//

import UIKit

import AVKit

import AVFoundation



class GettingMoviesData: NSObject

{

    // MARK:- creating static property

    

    static var shared:GettingMoviesData = GettingMoviesData()

    

    // MARK:- variables

    

    var movieBtnTags:Int!

    var buttonTapped:Int?

    var moviesStory = [String]()

    var MoviesTitle = [String]()

    var actorsNames = [[String]]()

    var directorName = [String]()

    var moviePosterImage = [UIImage]()

    var movieTrailer = [AVPlayerViewController]()

    var audioSongsPaths = [AVPlayer]()

    var audioSongBtnTag:Int!

    

    var audioSongArray = [[String]]()

    // MARK:- ServerData

    

    func gettingMoviesDetails() -> [movies]

    {

        var moviesData:[movies]?

        

        var urlObj = URLRequest(url: URL(string: "https://www.brninfotech.com/tws/MovieDetails2.php?mediaType=movies")!)

        

        urlObj.httpMethod = "Get"

        

        let  taskObj = URLSession.shared.dataTask(with: urlObj)

        {

            (data, response, err) in

            

            let  decoder = JSONDecoder()

            

            do

            {

                moviesData = try decoder.decode([movies
                    ].self, from: data!)

            }

            catch

            {

                print("Something went wrong")

            }

        }

        taskObj.resume()

        

        while(moviesData == nil)

        {

            

        }

        

        return moviesData!

        

    }



}

