//
//  CycleMomentComponent.swift
//  core_app
//
//  Created by Luis Silva on 04/04/24.
//

import Assets
import BackendLib
import SwiftData
import SwiftUI

enum Phase: String {
    case period = "Period"
    case ovulatory = "Ovulatory phase"
    case luteal = "Luteal phase"
    case follicular = "Follicular phase"
}

struct CycleMomentComponent: View {
    @State var cycleService: CycleService

    init(context: ModelContext) {
        cycleService = CycleService(context: context)
        _cycleService = State(initialValue: cycleService)
    }

    var body: some View {
        let (phase, daysPassedInTheCycle) = calculatePhase()
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

                    BallComponent(cycleService: cycleService, phase: phase, daysPassedInTheCycle: daysPassedInTheCycle)
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

    func calculatePhase() -> (Phase, Int) {
        let durantionOfThePeriod = 5
        let cyclesSorted = cycleService.cycles.sorted(by: { $0.startDate < $1.startDate })
        guard let startOfLastCycle = cyclesSorted.last?.startDate else { return (.period, 0) }
        let today = Date()
        let days = Int(Calendar.current.dateComponents([.day], from: startOfLastCycle, to: today).day ?? 0)

        let duration = CycleCalculation().calculateDurationOfTheCycle(cyclesSorted)
        let dateOfStartOfNextCycle = Calendar.current.date(byAdding: .day,
                                                           value: duration,
                                                           to: startOfLastCycle) ?? Date()

        if Calendar.current.date(byAdding: .day,
                                 value: durantionOfThePeriod,
                                 to: startOfLastCycle) ?? Date() >= today &&
            startOfLastCycle <= today {
            return (.period, days + 1)
        } else if Calendar.current.date(byAdding: .day,
                                        value: durantionOfThePeriod,
                                        to: startOfLastCycle) ?? Date() < today &&
            Calendar.current.date(byAdding: .day,
                                  value: -13, to:
                                  dateOfStartOfNextCycle) ?? Date() > today {
            return (.follicular, days + 1)
        } else if Calendar.current.date(byAdding: .day,
                                        value: -13,
                                        to: dateOfStartOfNextCycle) ?? Date() <= today &&
            Calendar.current.date(byAdding: .day,
                                  value: -7,
                                  to: dateOfStartOfNextCycle) ?? Date() >= today {
            return (.ovulatory, days + 1)
        } else if Calendar.current.date(byAdding: .day,
                                        value: -7,
                                        to: dateOfStartOfNextCycle) ?? Date() < today &&
            Calendar.current.date(byAdding: .day,
                                  value: -1,
                                  to: dateOfStartOfNextCycle) ?? Date() >= today {
            return (.luteal, days + 1)
        }
        return (.period, 0)
    }

    func tipsOfEachPhase(_ phase: Phase) -> String {
        switch phase {
        case .period:
            return "Stay hydrated on your period to ease bloating and discomfort."
        case .ovulatory:
            return "In the ovulatory phase, consider incorporating more omega-3 fatty acids into your diet to support hormone balance and reduce inflammation."
        case .luteal:
            return "In the luteal phase, try to reduce caffeine intake to help manage symptoms like irritability and breast tenderness."
        case .follicular:
            return "During the follicular phase, focus on foods rich in iron and vitamin C to support energy levels and iron absorption."
        }
    }
}

// #Preview {
//    CycleMomentComponent(phase: .period)
// }
