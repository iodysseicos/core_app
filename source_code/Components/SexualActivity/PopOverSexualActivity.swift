//
//  PopOverSexualActivity.swift
//  core_app
//
//  Created by Caio Melloni dos Santos on 08/04/24.
//

import SwiftUI
import Assets
import BackendLib
import SwiftData

struct SexualActivityPopOver: View {
    @Environment(\.dismiss) var dismiss
    @Binding var didHaveSex: Bool
    @Binding var didUseCondom: Bool
    @State var didHaveSexToggle: Bool
    @State var didUseCondomToggle: Bool
    @State private var cycleService: CycleService
    let currentDay: Date
    let cycle: Cycle
    init(
        context: ModelContext,
        cycle: Cycle,
        didHaveSex: Binding<Bool>,
        didUseCondom: Binding<Bool>,
        currentDay: Date
    ) {
        self._didHaveSex = didHaveSex
        self._didUseCondom = didUseCondom
        self.didHaveSexToggle = didHaveSex.wrappedValue
        self.didUseCondomToggle = didUseCondom.wrappedValue
        self.currentDay = currentDay
        self.cycle = cycle
        let cycleService = CycleService(context: context)
        _cycleService = State(initialValue: cycleService)
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text("Sexual activity")
            .foregroundStyle(Colors.purple_700)
            Text(dayString())
                .font(.title3)
            Divider()
            Text("Did you have sex?").opacity(0.8)
            Toggle(isOn: $didHaveSexToggle) {}
                .toggleStyle(SwitchToggleStyle(tint: Colors.red_300))
            Divider()
            Text("Did you use a condom").opacity(0.8)
            Toggle(isOn: $didUseCondomToggle) {}
                .toggleStyle(SwitchToggleStyle(tint: Colors.purple_500))
            Divider()
            Button("Done") {
                didHaveSex = didHaveSexToggle
                didUseCondom = didUseCondomToggle
                cycleService.addSexualActivity(
                    cycle: cycle,
                    didHaveSex: didHaveSex,
                    didUseCondom: didUseCondom,
                    date: currentDay
                )
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .tint(Colors.purple_300)
        }
    }
    private func dayString() -> String {
        let weekDay = getWeekDayFromInt(Calendar.current.component(.weekday, from: currentDay))
        let day = Calendar.current.component(.day, from: currentDay)
        let month = getMonthFromInt(Calendar.current.component(.month, from: currentDay))
        let year = Calendar.current.component(.year, from: currentDay)
        return "\(weekDay), \(day) \(month) \(year)"
    }
}

func getMonthFromInt(_ month: Int) -> String {
    let months = [
        1: "January",
        2: "February",
        3: "March",
        4: "April",
        5: "May",
        6: "June",
        7: "July",
        8: "August",
        9: "September",
        10: "Octover",
        11: "November",
        12: "December"
    ]
    return months[month] ?? "SomeMonth"
}

func getWeekDayFromInt(_ day: Int) -> String {
    let days = [
        1: "Sunday",
        2: "Monday",
        3: "Tuesday",
        4: "Wednesday",
        5: "Thursday",
        6: "Friday",
        7: "Saturday"
    ]
    return days[day] ?? "SomeDay"
}
