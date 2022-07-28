//
//  ContentView.swift
//  photojournal
//
//  Created by Megan Korling on 7/26/22.
//

import SwiftUI

struct ContentView: View {
    // to access and save, need the context: as moc
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var entries: FetchedResults<Entry>
    // make a new fetch request with no sorting, put it into entries that has type of FetchedResults<Entry>
    // then we can use it like an array
    // some properties of Entry are optional
    // when unpacking them, entry.title ?? "title" so that by default there is a string "title" if no title is entered.
    
    var body: some View {
        TabView {
            NavigationView {
                Text("Name of App")
                    .navigationTitle("Home")
            }
            .tabItem { Image(systemName: "house.circle.fill") }.tag(1)
            NavigationView {
                Text("New Entry View Goes Here")
                    .navigationTitle("New Journal Entry")
            }
            .tabItem { Image(systemName: "plus.square.fill") }.tag(2)
            NavigationView {
                Text("List View of Entries Goes Here")
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
