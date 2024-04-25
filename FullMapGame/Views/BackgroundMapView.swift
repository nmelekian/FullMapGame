//
//  BackgroundMapView.swift
//  FullMapGame
//
//  Created by Nick Melekian on 4/18/24.
//

import SwiftUI
import MapKit

struct BackgroundMapView: View {
    @State var trigger = false
    @State private var markerTitle = ""
    @State private var markerCoord =  CLLocationCoordinate2D(latitude: 25, longitude: -83.04559)
    @State private var position: MapCameraPosition = .camera(
        .init(centerCoordinate: CLLocationCoordinate2D(latitude: 25, longitude: -180), distance: 50_000_000)
    )
    @State private var detroit = CLLocationCoordinate2D(latitude: 25, longitude: -180)
    
    @State private var rome = CLLocationCoordinate2D(latitude: 25, longitude: 180)
//    @State private var shanghai = CLLocationCoordinate2D(latitude: 25, longitude: 121.37287)
//    @State private var tashkent = CLLocationCoordinate2D(latitude: 25, longitude: 69.85080)
    var body: some View {
        VStack{
            Map(position: $position)
                .allowsHitTesting(false)
            .mapStyle(.imagery)
            .mapCameraKeyframeAnimator(trigger: trigger) { initialCamera in
                KeyframeTrack(\MapCamera.centerCoordinate) {
                    LinearKeyframe(detroit, duration: 0)
                    LinearKeyframe(rome, duration: 180)
                    LinearKeyframe(CLLocationCoordinate2D(latitude: 25, longitude: -180), duration: 180 )
//                    LinearKeyframe(tashkent, duration: 40)
//                    LinearKeyframe(shanghai, duration: 40)
//                    LinearKeyframe(detroit, duration: 40)
                    
                }
                KeyframeTrack(\MapCamera.distance) {
                    LinearKeyframe(initialCamera.distance, duration: 0)
//                    LinearKeyframe(initialCamera.distance, duration: 10)
//                    LinearKeyframe(initialCamera.distance, duration: 10)
//                    LinearKeyframe(initialCamera.distance, duration: 10)
//                    LinearKeyframe(initialCamera.distance, duration: 10)
                }
    
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                trigger = true
            }
        }
    }
}

#Preview {
    BackgroundMapView()
}
