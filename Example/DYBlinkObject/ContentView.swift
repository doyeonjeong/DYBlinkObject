//
//  ContentView.swift
//  DYBlinkObject
//
//  Created by doyeonjeong on 11/22/2025.
//

import SwiftUI

@available(iOS 13.0, *)
struct ContentView: View {
    var body: some View {
        TabView {
            // Playground Tab (Default)
            NavigationView {
                InteractivePlaygroundView()
                    .navigationTitle("Playground")
            }
            .tabItem {
                Image(systemName: "play.circle.fill")
                Text("Playground")
            }

            // Samples Tab
            UIKitExamplesWrapper()
                .tabItem {
                    Image(systemName: "square.grid.3x3.fill")
                    Text("Samples")
                }
        }
    }
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
