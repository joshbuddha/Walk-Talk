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

class DBLayer {
    
    var onTracksUpdated: (() -> Void)? {
        didSet {
            let realm = try! Realm()
            let results = realm.objects(Track.self)
            self.token = results.observe { [weak self] _ in
                self?.onTracksUpdated?()
            }
        }
    }
    
    var tracks: [Track] {
        let realm = try! Realm()
        return realm.objects(Track.self).map { $0 }
    }
    
    private var token: NotificationToken?
    
    func loadTracks() {
        
        let url = URL(fileURLWithPath: "/Users/Work/Documents/GitHub/Walk-Talk/db.json")
//        guard let url = URL(string: "http://localhost:3000/track") else {
//            return
//        }
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                let trackModel = try decoder.decode(DB.self, from: dataResponse)
                
                let realm = try! Realm()
                try! realm.write {
                    //Writing them all at once so we don't get constant updates
                    for track in trackModel.track {
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
    
    deinit {
        token?.invalidate()
    }
    
    
    //Cheat to load local json because I couldn't get json-server to work
    struct DB: Decodable {
        var track: [Track]
    }
}


