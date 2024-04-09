//
//  CycleMomentComponent.swift
//  core_app
//
//  Created by Luis Silva on 04/04/24.
//

import Assets
import BackendLib
import SwiftUI

enum Phase: String {
    case period = "Period"
    case ovulatory = "Ovulatory phase"
    case luteal = "Luteal phase"
    case follicular = "Follicular phase"
}

struct CycleMomentComponent: View {
    @Environment(\.modelContext) private var modelContext

    var phase: Phase

    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)

            VStack(alignment: .leading, spacing: 50) {
                VStack(spacing: 30) {
                    HStack {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Cycle Moment")
                                .font(.system(size: 15))
                                .foregroundColor(Colors.purple_700)

                            Text(phase.rawValue)
                                .font(.system(size: 22))
                                .foregroundColor(Colors.purple_700)
                        }.padding(.top, 16)

                        Spacer()
                    }.padding(.leading)

                    BallComponent(context: modelContext, phase: phase)
                }.frame(width: 600, height: 400)

                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 600, height: 120)
                        .foregroundColor(.clear)

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Tips")
                                .font(.system(size: 17))
                                .foregroundColor(Colors.purple_800)
                            Spacer()
                        }

                        Text(tipsOfEachPhase(phase))
                            .font(.system(size: 13))
                            .foregroundColor(Colors.gray_900)
                    }.padding()
                }.frame(width: 600, height: 120)
            }
        }
        .frame(width: 600, height: 552.33)
        .cornerRadius(10)
    }

    func tipsOfEachPhase(_ phase: Phase) -> String {
        switch phase {
        case .period:
            return "nenhuma dica ainda"
        case .ovulatory:
            return "nenhuma dica ainda"
        case .luteal:
            return "nenhuma dica ainda"
        case .follicular:
            return "nenhuma dica ainda"
        }
    }
}

// #Preview {
//    CycleMomentComponent(phase: .period)
// }
