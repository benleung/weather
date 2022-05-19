//
//  ErrorWidgetView.swift
//  weatherwidgetExtension
//
//  Created by Ben Leung on 2022/05/19.
//

import SwiftUI

struct ErrorWidgetView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "location.slash")
                .resizable()
                .scaledToFit()
            
            Text("No Data for WeatherWidget")
                .multilineTextAlignment(.center)
                .font(.system(size: 16))
                .padding(.bottom, 5)

            Text("Tap to authorize location service")
                .multilineTextAlignment(.center)
                .font(.system(size: 12))
        }.padding(10)
    }
}
