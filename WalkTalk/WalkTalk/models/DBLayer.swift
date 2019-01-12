//
//  DBLayer.swift
//  WalkTalk
//
//  Created by Josh Kneedler on 1/8/19.
//  Copyright © 2019 Josh Kneedler. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

struct DBLayer {
    
    mutating func loadJSON() {
        //make sure local url is available
        //https://api.iextrading.com/1.0/stock/market/collection/tag?collectionName=Computer%20Hardware
        //https://ws-api.iextrading.com/1.0/stock/market/collection/sector?collectionName=Materials
        //http://localhost:3000/track
        guard let url = URL(string: "http://localhost:3000/track") else {
            return
        }
        //load url with URLSession
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            
            do {
                print("data loaded from server")
                let decoder = JSONDecoder()
                //decode json to Track class with Decodable protocol
                let trackModel = try decoder.decode([Track].self, from: dataResponse)
                
                let realm = try! Realm()
                for track in trackModel {
                    try! realm.write {
                        //add the track classes with update set to true so you can easily call the server whenever needed.
                        realm.add(track, update: true)
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
            
        }
        task.resume()
    }
}
