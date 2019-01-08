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
        
        guard let url = URL(string: "http://localhost:3000/track") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                let trackModel = try decoder.decode([Track].self, from: dataResponse)
                
                let realm = try! Realm()
                for track in trackModel {
                    try! realm.write {
                        realm.add(track, update: true)
                        //print("writing realm! ", track)
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
            
        }
        task.resume()
    }
}
