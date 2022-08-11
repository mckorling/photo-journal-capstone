//
//  MapView.swift
//  photojournal
//
//  Created by Megan Korling on 8/11/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @FetchRequest(sortDescriptors: []) var entries: FetchedResults<Entry>
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $mapRegion, annotationItems: entries, annotationContent: { entry in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: entry.latitude, longitude: entry.longitude)) {
                    NavigationLink {
                        SingleEntryView(entry: entry)
                    } label: {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 25, height: 25)
                    }
                }
            })
            .ignoresSafeArea(.all, edges: .top)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
