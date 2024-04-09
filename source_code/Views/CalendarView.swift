//
//  CalendarView.swift
//  core_app
//
//  Created by Larissa Fazolin on 04/04/24.
//

import BackendLib
import SwiftData
import SwiftUI

struct CalendarView: View {
    private var context: ModelContext
    @State var cycleService: CycleService
    @Binding var date: Date {
        didSet {
            currentCycle = cycleService.getCycleByDate(date: date) ?? Self.emptyCycle
        }
    }
    @State var currentCycle: Cycle

    var monthToPass = Calendar.current.component(.month, from: Date())
    var yearToPass = Calendar.current.component(.year, from: Date())
    init(context: ModelContext, date: Binding<Date>) {
        self.context = context
        self._date = date
        let cycleService = CycleService(context: context)
        _cycleService = State(initialValue: cycleService)
        currentCycle = cycleService.getCycleByDate(date: date.wrappedValue) ?? Self.emptyCycle

    }

    var body: some View {
        ScrollView {
            HStack {
                LazyVStack(alignment: .leading) {
                    // Greetings
                    Text("Hello, Julia!")
                        .font(.system(.title2))

                    LazyHStack {
                        // Calendar
                        CalendarComponent(month: monthToPass,
                                          year: yearToPass,
                                          date: $date)

                        LazyVStack(alignment: .leading) {
                            // Begin cycle
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 142, height: 78)

                            // Current cycle phase
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 317, height: 281)
                        }
                    }
                    .padding(.bottom, 32)

                    // Selected date
                    Text("Thursday, 14 March 2024")
                        .bold()
                        .font(.system(.title))

                    Text("Personal Records")
                        .font(.system(.title2))

                    LazyHStack(alignment: .top) {
                        LazyVStack {
                            SelectedFrame(cycle: currentCycle,
                                          context: context, selectionType: .symptons, date: date)
                            SelectedFrame(cycle: currentCycle,
                                          context: context, selectionType: .mood, date: date)
                            SexualActivityComponent(currentCycle: currentCycle, currentDay: date)
                        }
                        LazyVStack {
                            LibidoIntensityFrame()
                            FlowPeriodIntensity()
                        }
                    }

                    Spacer()
                }
                .padding(.bottom, 150)
                .padding()
            }
        }
    }
    static let emptyCycle = Cycle(startDate: Date(), endDate: Date())
}
