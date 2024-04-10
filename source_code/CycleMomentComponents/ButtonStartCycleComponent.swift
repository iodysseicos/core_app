//
//  ButtonStartCycleComponent.swift
//  core_app
//
//  Created by Luis Silva on 09/04/24.
//

import SwiftUI
import Assets
import BackendLib
import SwiftData

struct ButtonStartCycleComponent: View {
    @State var cycleService: CycleService
    @State var isShowingPopover: Bool = false
    @State var isToggleOn: Bool = false 
    var date: Date
    init(context: ModelContext, date: Date) {
        self.date = date

        cycleService = CycleService(context: context)
        _cycleService = State(initialValue: cycleService)
    }
    var body: some View {
        let day = Calendar.current.component(.day, from: date)
        let month = getTheMonthNameBasedOnTheNumber(Calendar.current.component(.month, from: date))
        let year = Calendar.current.component(.year, from: date)
        let weekday = getTheWeekday(date)
        Button(action: {
            isShowingPopover = true
        }, label: {
            ZStack(alignment: .center) {
                Text("Period")
                    .bold()
                    .font(.system(size: 22))
                    .foregroundColor(Colors.green_50)
            }
            .frame(width: 155, height: 100)
            .background(Colors.purple_500)
        })
        .cornerRadius(10)
        .buttonStyle(.plain)
        .frame(width: 155, height: 100)
        .popover(isPresented: $isShowingPopover) {
            ZStack(alignment: .top) {
                Rectangle()
                    .frame(width: 246, height: 132)
                VStack {
                    HStack {
                        Text("\(weekday), \(month) \(day) \(String(year))")
                            .foregroundColor(Colors.purple_800)
                            .font(.system(size: 12))
                            .padding(.leading)
                            .padding(.top, 8)
                        Spacer()
                    }
                    Divider()
                        .foregroundColor(.gray)
                        .padding(.bottom)
                    VStack(alignment: .center) {
                        Text("Has your cycle started?")
                            .font(.system(size: 17))
                            .foregroundColor(Colors.purple_500)
                            .padding(.bottom, 8)
                        Toggle(isOn: $isToggleOn) {}
                            .toggleStyle(SwitchToggleStyle(tint: Colors.purple_100))
                    }
                }
            }.foregroundColor(.white)
        }.onChange(of: isToggleOn) {
//            operationOfTheToggleButton(isToggleOn)
        }
    }
    func operationOfTheToggleButton(_ isToggleOn: Bool) {
        let cyclesSorted = cycleService.cycles.sorted(by: { $0.startDate < $1.startDate })
        let duration = CycleCalculation().calculateDurationOfTheCycle(cyclesSorted)
        if isToggleOn {
            cyclesSorted.last?.endDate = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? Date()
            _ = cycleService.createCycle(startDate: date,
                                             endDate: Calendar.current.date(byAdding: .day,
                                                                            value: duration,
                                                                            to: date) ?? Date())
        }
    }
    func  getTheMonthNameBasedOnTheNumber(_ month: Int) -> String {
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
            return months[month] ?? "Non"
    }
    func getTheWeekday(_ date: Date) -> String {
        let numberOfTheWeekday = Calendar.current.component(.weekday, from: date)
        let days = [
                1: "Sunday",
                2: "Monday",
                3: "Tuesday",
                4: "Wednesday",
                5: "Thursday",
                6: "Friday",
                7: "Saturday"
            ]
            return days[numberOfTheWeekday] ?? "Non"
    }
}
