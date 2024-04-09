//
//  FlowPeriodIntensity.swift
//  core_app
//
//  Created by Pamella Alvarenga on 05/04/24.
//

import Assets
import SwiftUI

struct FlowPeriodIntensity: View {
    @State private var selectedFlow: FlowIntensity?

    enum FlowIntensity {
        case intense
        case medium
        case light
        case veryLight
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("How is your menstrual flow today?")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Colors.purple_800)
                .font(.custom("SF Pro", size: 17))

            HStack(spacing: 20) {
                VStack(spacing: 8) {
                    libidoButton(flow: .veryLight)
                    Text("Very Light")
                 

                }
                VStack(spacing: 8) {
                    libidoButton(flow: .light)
                    Text("Light")
                    

                }
                VStack(spacing: 8) {
                    libidoButton(flow: .medium)
                    Text("Moderate")
                    

                }
                VStack(spacing: 8) {
                    libidoButton(flow: .intense)
                    Text("Intense")
               

                }
            }.frame(alignment: .center)
                .foregroundColor(Colors.gray_800)
                .font(.custom("SF Pro", size: 12))
            
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(alignment: .center)
        .background(Color.white) // Define o fundo do HStack como branco
        .cornerRadius(10.0)
    }

    func libidoButton(flow: FlowIntensity) -> some View {
        let isSelected = selectedFlow == flow
        let notSelectedImage: Image
        let selectedImage: Image
        
        var circleColor: Color
        
        switch flow {
        case .veryLight:
            notSelectedImage = Images.flowVeryLightNotSelected.swiftUIImage
            selectedImage = Images.flowVeryLightSelected.swiftUIImage
            
        case .light:
            notSelectedImage = Images.flowLightNotSelected.swiftUIImage
            selectedImage = Images.flowLightSelected.swiftUIImage
            
        case .medium:
            notSelectedImage = Images.flowModerateNotSelected.swiftUIImage
            selectedImage = Images.flowModerateSelected.swiftUIImage
            
        case .intense:
            notSelectedImage = Images.flowIntenseNotSelected.swiftUIImage
            selectedImage = Images.flowIntenseSelected.swiftUIImage
        }
        
        if isSelected {
            circleColor = Colors.red_100
        } else {
            circleColor = Colors.red_50
        }
        
        return Button(action: {
            self.selectedFlow = isSelected ? nil : flow
                        
      
            
        }) {
            ZStack {
                Circle()
                    .fill(circleColor)
                    .frame(width:64, height: 64)
                    .shadow(color: isSelected ? Color.black.opacity(0.3) : Color.clear, radius: 5, x: 0, y: 2) // Adiciona sombra somente se estiver selecionado


                if isSelected {
                    selectedImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                    
                    
                } else {
                    notSelectedImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                }

            }
        }.buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    FlowPeriodIntensity()
}
