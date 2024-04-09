//
//  BallComponent.swift
//  core_app
//
//  Created by Luis Silva on 04/04/24.
//

import Assets
import BackendLib
import SwiftData
import SwiftUI

struct BallComponent: View {
    @State var cycleService: CycleService
    let phase: Phase

    init(context: ModelContext, phase: Phase) {
        self.phase = phase

        cycleService = CycleService(context: context)
        _cycleService = State(initialValue: cycleService)
    }

    var body: some View {
        let dayOfTheCicle = calculateDayOfTheCycle(cycleService)
        let (colorOutside, colorBetween, colorInside) = colorOfTheBall(phase)

        ZStack {
            Circle()
                .frame(width: 272, height: 272)
                .foregroundColor(colorOutside)

            Circle()
                .frame(width: 260, height: 260)
                .foregroundColor(colorBetween)

            Circle()
                .frame(width: 167, height: 167)
                .foregroundColor(colorOutside)

            VStack {
                if dayOfTheCicle < 10 {
                    Text("Day 0\(dayOfTheCicle)")
                        .font(.system(size: 22))
                        .bold()
                        .foregroundColor(.white)
                } else {
                    Text("Day \(dayOfTheCicle)")
                        .font(.system(size: 22))
                        .bold()
                        .foregroundColor(.white)
                }

                Text("of your \(CycleCalculation().calculateDurationOfTheCycle(cycleService.cycles.sorted(by: { $0.startDate < $1.startDate })))-day cycle")
                    .font(.system(size: 13))
                    .foregroundColor(.white)
            }
        }
    }

    func calculateDayOfTheCycle(_: CycleService) -> Int {
        // continuar aqui

        return 0
    }

    func colorOfTheBall(_ phase: Phase) -> (Color, Color, Color) {
        switch phase {
        case .follicular:
            return (Colors.blue_100, Colors.blue_50, Colors.blue_200)
        case .period:
            return (Colors.red_100, Colors.red_50, Colors.red_200)
        case .ovulatory:
            return (Colors.green_300, Colors.green_100, Colors.green_500)
        case .luteal:
            return (Colors.pink_100, Colors.pink_50, Colors.pink_200)
        }
    }
}

// #Preview {
//    BallComponent(cycleService: cycle, dayOfTheCicle: 1, phase: .period)
// }
