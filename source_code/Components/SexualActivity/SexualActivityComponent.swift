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
        // verify if this day has a sexual activity
        let sexActivity = currentCycle.sexualActivities?.first(where: {
            $0.day.timeIntervalSince1970 == currentDay.timeIntervalSince1970
        })
        didHaveSex = sexActivity?.didHaveSex ?? false
        didUseCondom = sexActivity?.didUseCondom ?? false
    }
    @ViewBuilder
    var body: some View {
        VStack {
            // Title
            HStack {
                Text("Sexual Activity")
                    .font(.title2)
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
            Button("Add Activity") {
                self.isShowingPopover = true
            }
            .buttonStyle(.plain)
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
        .background(.white)
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
