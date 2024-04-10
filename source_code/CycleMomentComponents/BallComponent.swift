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
    var cycleService: CycleService
    let phase: Phase
    let daysPassedInTheCycle: Int

    var body: some View {
        // let dayOfTheCicle = calculateDayOfTheCycle(cycleService)
        let colorOutside = colorOfTheBigBall(phase)
        let colorOftheLine = colorOfTheLine(phase)
        let colorBetween = colorOfTheBetweenBall(phase)
        let colorInside = colorOfTheInsideBall(phase)
        let durationOfTheCompleteCycle = CycleCalculation().calculateDurationOfTheCycle(
            cycleService.cycles.sorted(by: { $0.startDate < $1.startDate }))

        ZStack {
            Circle()
                .frame(width: 272, height: 272)
                .foregroundColor(colorOutside)

            Circle()
                .trim(from: 0.0, to: Double(daysPassedInTheCycle) / Double(durationOfTheCompleteCycle))
                .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                .foregroundColor(colorOftheLine)
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 268, height: 268)

            Circle()
                .frame(width: 260, height: 260)
                .foregroundColor(colorBetween)

            Circle()
                .frame(width: 167, height: 167)
                .foregroundColor(colorInside)

            VStack {
                if daysPassedInTheCycle < 10 {
                    Text("Day 0\(daysPassedInTheCycle)")
                        .font(.system(size: 22))
                        .bold()
                        .foregroundColor(.white)
                } else {
                    Text("Day \(daysPassedInTheCycle)")
                        .font(.system(size: 22))
                        .bold()
                        .foregroundColor(.white)
                }

                Text("of your \(durationOfTheCompleteCycle)-day cycle")
                    .font(.system(size: 13))
                    .foregroundColor(.white)
            }
        }.onAppear {
            print(daysPassedInTheCycle)
            print(durationOfTheCompleteCycle)
            print(Double(daysPassedInTheCycle) / Double(durationOfTheCompleteCycle))
        }
    }

    func colorOfTheBigBall(_ phase: Phase) -> Color {
        switch phase {
        case .follicular:
            return Colors.blue_100
        case .period:
            return Colors.red_100
        case .ovulatory:
            return Colors.green_300
        case .luteal:
            return Colors.pink_100
        }
    }

    func colorOfTheLine(_ phase: Phase) -> Color {
        switch phase {
        case .follicular:
            return Colors.blue_400
        case .period:
            return Colors.red_400
        case .ovulatory:
            return Colors.green_700
        case .luteal:
            return Colors.pink_400
        }
    }

    func colorOfTheBetweenBall(_ phase: Phase) -> Color {
        switch phase {
        case .follicular:
            return Colors.blue_50
        case .period:
            return Colors.red_50
        case .ovulatory:
            return Colors.green_100
        case .luteal:
            return Colors.pink_50
        }
    }

    func colorOfTheInsideBall(_ phase: Phase) -> Color {
        switch phase {
        case .follicular:
            return Colors.blue_200
        case .period:
            return Colors.red_200
        case .ovulatory:
            return Colors.green_500
        case .luteal:
            return Colors.pink_200
        }
    }
}

// #Preview {
//    BallComponent(cycleService: cycle, dayOfTheCicle: 1, phase: .period)
// }
