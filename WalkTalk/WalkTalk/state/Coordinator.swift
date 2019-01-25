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
    
    var onStateChange: ((State) -> Void)?
    
    func notify(event: Event) {
        state = handle(event: event, oldState: state)
    }
    
    private func handle(event: Event, oldState: State) -> State {
        
        //make copy
        var newState = oldState
        
        switch event {
            
        case let .tappedSong(indexPath, song):
            newState.title = song
            newState.songIndex = indexPath.row
        }
        
        return newState
    }
}

enum Event {
    case tappedSong(IndexPath, String)
}

struct State {
    var title: String = ""
    var songIndex: Int = 0
}
