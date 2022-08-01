//
//  HomeView.swift
//  photojournal
//
//  Created by Megan Korling on 8/1/22.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        let gradient = LinearGradient(colors: [.mint, .pink, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
        
        ZStack {
            gradient
                .opacity(0.30)
                .ignoresSafeArea()
            VStack {
                Text("Photo")
                Text("Journal")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
