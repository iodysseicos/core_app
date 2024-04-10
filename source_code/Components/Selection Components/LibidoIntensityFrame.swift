//
//  LibidoIntensityFrame.swift
//  core_app
//
//  Created by Pamella Alvarenga on 05/04/24.
//

import Assets
import SwiftUI

struct LibidoIntensityFrame: View {
    @State private var selectedLibido: LibidoIntensity?

    enum LibidoIntensity {
        case high
        case medium
        case low
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What is your libido level today?")
                .foregroundColor(Colors.purple_800)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("SF Pro", size: 17))
            HStack(spacing: 20) {
                VStack(spacing: 8) {
                    libidoButton(intensity: .low)
                    Text("Low")
                }
                VStack(spacing: 8) {
                    libidoButton(intensity: .medium)
                    Text("Moderate")
                }
                VStack(spacing: 8) {
                    libidoButton(intensity: .high)
                    Text("High")
                }
            }.foregroundColor(Colors.gray_900)
                .font(.custom("SF Pro", size: 12))
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(10.0)
    }

    func libidoButton(intensity: LibidoIntensity) -> some View {
        let isSelected = selectedLibido == intensity
        let notSelectedImage: Image
        let selectedImage: Image
        var circleColor: Color

        switch intensity {
        case .high:
            notSelectedImage = Images.libidoHighNotSelected.swiftUIImage
            selectedImage = Images.libidoHighSelected.swiftUIImage
        case .medium:
            notSelectedImage = Images.libidoModerateNotSelected.swiftUIImage
            selectedImage = Images.libidoModerateSelected.swiftUIImage
        case .low:
            notSelectedImage = Images.libidoLowNotSelected.swiftUIImage
            selectedImage = Images.libidoLowSelected.swiftUIImage
        }
        if isSelected {
            circleColor = Colors.purple_100
        } else {
            circleColor = Colors.purple_50
        }

        return Button(action: {
            self.selectedLibido = isSelected ? nil : intensity
        }) {
            ZStack{
                Circle()
                    .fill(circleColor)
                    .frame(width: 64, height: 64)
                    .shadow(color: isSelected ? Color.black.opacity(0.3) : Color.clear, radius: 5, x: 0, y: 2) // Adiciona sombra somente se estiver selecionado
                if isSelected {
                    selectedImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: intensity == .low ? 16 : 24)
                } else {
                    notSelectedImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: intensity == .low ? 16 : 24)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
