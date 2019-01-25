//
//  ViewController.swift
//  WalkTalk
//
//  Created by Josh Kneedler on 1/8/19.
//  Copyright © 2019 Josh Kneedler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedTrack: UILabel!
    
    let db = DBLayer()
    var coordinator = Coordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db.onTracksUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        
        coordinator.onStateChange = { [weak self] state in
            self?.selectedTrack.text = state.title
            
            print("present controller based on index ", state.songIndex)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        db.loadTracks()
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        db.loadTracks()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TrackCell = tableView.dequeueReusableCell(for: indexPath)
        
        guard let songTitle = db.tracks[indexPath.row].song else {
            return cell
        }
        cell.textLabel?.text = songTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let songTitle = db.tracks[indexPath.row].song else {
            return
        }
        
        coordinator.notify(event: .tappedSong(indexPath, songTitle))
        
        
    }
}

