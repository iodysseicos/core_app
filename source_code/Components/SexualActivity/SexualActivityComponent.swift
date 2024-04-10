//
//  SexualActivityComponent.swift
//  core_app
//
//  Created by Caio Melloni dos Santos on 08/04/24.
//

import Assets
import SwiftUI
import BackendLib
import SwiftData

// Main component for the sexual activity box
// it's subcomponents are inside the same SexualActivityComponent
// this main component receives the cycle in which it's going to save
// the sexual activity
// it also receives the selected day in the calendar
struct SexualActivityComponent: View {
    @Environment(\.modelContext) private var context
    @State private var isShowingPopover = false
    @State private var didHaveSex = false
    @State private var didUseCondom = false
    var currentCycle: Cycle
    var currentDay: Date
    init(currentCycle: Cycle, currentDay: Date) {
        self.currentCycle = currentCycle
        self.currentDay = currentDay
    }
    @ViewBuilder
    var body: some View {
        VStack {
            // Title
            HStack {
                Text("Sexual Activity")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(Colors.purple_700)
                Spacer()
            }

            // Icons
            HStack {
                if didHaveSex {
                    RoundedIcon(.sex)
                    Spacer().frame(width: 20)
                }
                if didUseCondom {
                    RoundedIcon(.protection)
                }
                Spacer()
            }

            // Button Section
            Divider().frame(height: 10)
            Button(action: {
                self.isShowingPopover = true
            }, label: {
                Text("Add Activity")
                    .font(.system(size: 17, weight: .regular))
            })
            .buttonStyle(.plain)
            .foregroundStyle(.blue)
            .popover(isPresented: $isShowingPopover) {
                SexualActivityPopOver(
                    context: context,
                    cycle: currentCycle,
                    didHaveSex: $didHaveSex,
                    didUseCondom: $didUseCondom,
                    currentDay: currentDay
                )
                .padding()
            }
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .frame(maxWidth: 350)
        .clipShape(
            RoundedRectangle(
                cornerSize: CGSize(
                    width: 10,
                    height: 10
                ),
                style: .circular
            )
        )
        .onAppear {
            // verify if this day has a sexual activity
            let currentDate = Calendar.current.dateComponents([.day, .year, .month], from: currentDay)
            let sexActivity = currentCycle.sexualActivities?.first(where: { activity in
                let activityDate = Calendar.current.dateComponents([.day, .year, .month], from: activity.day)
                let sameDay = [
                    currentDate.day,
                    currentDate.month,
                    currentDate.year
                ] == [
                    activityDate.day,
                    activityDate.month,
                    activityDate.year
                ]
                return sameDay
            })
            self.didHaveSex = sexActivity?.didHaveSex ?? false
            self.didUseCondom = sexActivity?.didUseCondom ?? false
        }
    }
}

#Preview {
    VStack {
        Spacer()
        HStack {
            Spacer()
            SexualActivityComponent(currentCycle: Cycle(startDate: Date(), endDate: Date()), currentDay: Date())
                .preferredColorScheme(.light)
            Spacer()
        }
        Spacer()
    }.background(.black)
}
