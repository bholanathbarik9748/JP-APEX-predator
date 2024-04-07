//
//  PredatorMap.swift
//  JPApex
//
//  Created by Bholanath Barik on 07/04/24.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let predotors = Predators();
    @State var position : MapCameraPosition
    
    var body: some View {
        Map(position: $position) {
            ForEach(predotors.apexPredators) {
                predotor in
                Annotation(predotor.name, coordinate: predotor.location){
                    Image(predotor.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .shadow(color: .white,radius: 3)
                        .scaleEffect(x: -1)
                }
            }
        }
    }
}

#Preview {
    PredatorMap(position: .camera(MapCamera(
        centerCoordinate: Predators().apexPredators[2].location,
        distance: 1000,
        heading: 250,
        pitch: 80)))
    .preferredColorScheme(.dark)
}
