//
//  ReduxStore.swift
//  WalkTalk
//
//  Created by Josh Kneedler on 1/25/19.
//  Copyright © 2019 Josh Kneedler. All rights reserved.
//

import Foundation

class Coordinator {
    //state
    private(set) var state: State = State() {
        didSet {
            self.onStateChange?(state)
        }
    }
    
    private let store = DBLayer()
    
    init() {
        
        store.onTracksUpdated = { tracks in
            self.notify(event: .tracksLoaded(tracks))
        }
    }
    
    var onStateChange: ((State) -> Void)?
    
    func notify(event: Event) {
        state = handle(event: event, oldState: state)
    }
    
    private func handle(event: Event, oldState: State) -> State {
        
        //make copy
        var newState = oldState
        
        //store last event in state
        newState.lastEvent = event
        
        switch event {
        case .loadTracks:
            store.loadTracks()
        case let .tracksLoaded(tracks):
            newState.tracks = tracks
            
        case let .tapped(track: track):
            newState.selectedTrack = track
        }
        
        return newState
    }
}

enum Event {
    case loadTracks
    case tracksLoaded([Track])
    case tapped(track: Track)
}

struct State {
    var tracks: [Track] = []
    var selectedTrack: Track?
    var lastEvent: Event?
}
