//
//  SaberView.swift
//  Lightsaber
//
//  Created by Ethan Humphrey on 2/27/20.
//  Copyright © 2020 Ethan Humphrey. All rights reserved.
//

import SwiftUI

struct SaberView: View {
    
    @State var metrics: GeometryProxy
    @State var saberWidth: CGFloat
    @Binding var saberColor: Color
    
    var body: some View {
        Path { path in
            let x = metrics.size.width*(0.5-(self.saberWidth/2))
            path.addRect(CGRect(x: x, y: metrics.size.height*0.65, width: metrics.size.width*self.saberWidth, height: -metrics.size.height*0.65))
        }
        .fill(LinearGradient(gradient: Gradient(colors: [self.saberColor, Color.white, Color.white, self.saberColor]), startPoint: .init(x: 0.3, y: 0), endPoint: .init(x: 0.7, y: 0)))
        .shadow(color: self.saberColor, radius: 30, x: 0, y: 0)
        .shadow(color: self.saberColor, radius: 90, x: 0, y: 0)
        .zIndex(1)
    }
}

