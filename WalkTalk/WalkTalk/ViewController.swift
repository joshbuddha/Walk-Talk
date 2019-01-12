//
//  ViewController.swift
//  WalkTalk
//
//  Created by Josh Kneedler on 1/8/19.
//  Copyright © 2019 Josh Kneedler. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func updateBtn(_ sender: Any) {
        getDataFromServer()
    }
    var myDB: DBLayer = DBLayer()
    var myTracks: Results<Track>?
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        loadJSON() { [unowned self] (tracks: [Track]) -> () in
            
            self.heartOfGold = heart
            
            guard let heartData = self.heartOfGold else {
                return
            }
            
            print("Welcome Arthur: ", heartData)
            print("You are: ", heartData.description)
        }
 */

        
        //myDB = DBLayer()
        
        getDataFromServer()
        
        let realm = try! Realm()
        let results = realm.objects(Track.self)
        token = results.observe { _ in
            self.updateUI()
        }

        myTracks = realm.objects(Track.self)

    }
    func getDataFromServer() {
        myDB.loadJSON()
    }
    func updateUI() {
        tableView.reloadData()
    }
    deinit {
        token?.invalidate()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tracks = myTracks else {
            return 0
        }
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath)
        
        guard let songTitle = myTracks?[indexPath.row]["song"] as? String else {
            return cell
        }
        cell.textLabel?.text = songTitle
        
        return cell
    }
}

