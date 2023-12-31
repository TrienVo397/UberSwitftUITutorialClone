//
//  MapViewActionButton.swift
//  UberSwitftUITutorial
//
//  Created by kiet on 16/09/2023.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var showLocationSearchView: Bool
    var body: some View {
        Button{
            withAnimation(.spring()){
                showLocationSearchView.toggle()
            }        } label: {
                Image(systemName: showLocationSearchView ? "arrow.left" : "line.3.horizontal")
                .font(.title)//possible to use font for image
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading)
        
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(showLocationSearchView: .constant(true))
    }
}
