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
//                Text("Photo")
//                Text("Journal")
                    
                Image("collage-transparent")
                    .padding(-11.0)
                
                    
//                Image("photojournal-transparent")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
                // add collage image
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
