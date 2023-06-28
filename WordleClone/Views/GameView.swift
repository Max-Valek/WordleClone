//
//  GameView.swift
//  WordleClone
//
//  Created by Max Valek on 6/28/23.
//

import SwiftUI

struct GameView: View {
    
    var body: some View {
        NavigationStack {
            Text("Game")
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {}) {
                            Image(systemName: "questionmark.circle")
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("WORDLE")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.primary)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button(action: {}) {
                                Image(systemName: "chart.bar")
                            }
                            Button(action: {}) {
                                Image(systemName: "gearshape.fill")
                            }
                        }
                    }
                }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
