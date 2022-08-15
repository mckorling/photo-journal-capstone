//
//  ContentView.swift
//  photojournal
//
//  Created by Megan Korling on 7/26/22.
// https://medium.nextlevelswift.com/build-an-app-like-lego-with-swiftui-tutorial-3-235af2bf0f88
// https://medium.nextlevelswift.com/build-an-app-like-lego-with-swiftui-tutorial-2-2d01177e35c

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        // Set four tab options with HomeView as default View when app is opened
        TabView {
            NavigationView {
                HomeView()
                    // Set title of selected View
                    .navigationTitle("Photo Journal")
            }
            .navigationViewStyle(StackNavigationViewStyle()) // Dismisses error logged in console
            .tabItem {
                Image(systemName: "house.circle.fill")
                Text("Home")
            }.tag(1)
            NavigationView {
                AddEntryView()
                    .navigationTitle("New Journal Entry")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "plus.square.fill")
                Text("New")
            }.tag(2)
            NavigationView {
                EntryListView()
                    .navigationTitle("Past Entries")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "magazine.fill")
                Text("Lookup")
            }.tag(3)
            NavigationView {
                MapView()
                    .navigationTitle("Map")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "globe.americas.fill")
                Text("Map")
            }.tag(4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
