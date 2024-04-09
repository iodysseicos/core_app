//
//  RoundedIcon.swift
//  core_app
//
//  Created by Caio Melloni dos Santos on 08/04/24.
//

import SwiftUI
import Assets

enum ActivityType {
    case sex
    case protection
}

struct RoundedIcon: View {
    let type: ActivityType
    init(_ type: ActivityType) {
        self.type = type
    }
    @ViewBuilder
    var body: some View {
        VStack {
            ZStack {
                if type == .sex {
                    Images.sexualActivitySelected.swiftUIImage
                }
                if type == .protection {
                    Images.protectionSelected.swiftUIImage
                }

            }
            Text("Sex")
        }
    }
}
