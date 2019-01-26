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
    
    var coordinator = Coordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coordinator.onStateChange = { [weak self] state in
            self?.selectedTrack.text = state.selectedTrack?.song ?? ""
            self?.tableView.reloadData()
            //print("present controller based on index ", state.songIndex)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator.notify(event: .loadTracks)
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        coordinator.notify(event: .loadTracks)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    private var tracks: [Track] {
        return coordinator.state.tracks
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TrackCell = tableView.dequeueReusableCell(for: indexPath)
        
        guard let songTitle = tracks[indexPath.row].song else {
            return cell
        }
        cell.textLabel?.text = songTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let track = tracks[indexPath.row]
        
        coordinator.notify(event: .tapped(track: track))
    }
}

