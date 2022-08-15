//
//  HomeView.swift
//  photojournal
//
//  Created by Megan Korling on 8/1/22.
//

import SwiftUI

struct HomeView: View {
    // View holds no functionality other than being the View that app opens to
    
    var body: some View {
        let gradient = LinearGradient(colors: [.mint, .pink, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
        
        ZStack {
            gradient
                .opacity(0.30)
                .ignoresSafeArea()
            VStack {
                // Stack simple background image
                Image("collage-transparent")
                    .padding(-11.0)
                Image("collage-transparent")
                    .padding(.top, -14.0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
