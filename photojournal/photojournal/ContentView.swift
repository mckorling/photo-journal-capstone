//
//  ContentView.swift
//  photojournal
//
//  Created by Megan Korling on 7/26/22.
//

import SwiftUI

struct ContentView: View {
    // to access and save, need the context: as moc
   // @Environment(\.managedObjectContext) var moc
    //@FetchRequest(sortDescriptors: []) var entries: FetchedResults<Entry>
    // make a new fetch request with no sorting, put it into entries that has type of FetchedResults<Entry>
    // then we can use it like an arrayA
    // some properties of Entry are optional
    // when unpacking them, entry.title ?? "title" so that by default there is a string "title" if no title is entered.
    
    var body: some View {
        // let gradient = LinearGradient(colors: [.pink, .mint], startPoint: .topLeading, endPoint: .bottomTrailing)
        TabView {
            NavigationView {
                HomeView()
                .navigationTitle("Home")
            }
            .tabItem { Image(systemName: "house.circle.fill") }.tag(1)
            NavigationView {
                AddEntryView()
                    .navigationTitle("New Journal Entry")
            }
            .tabItem { Image(systemName: "plus.square.fill") }.tag(2)
            NavigationView {
                EntryListView()
                    .navigationTitle("Past Entries")
            }
            .tabItem { Image(systemName: "magazine.fill") }.tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
