//
//  WeekDaysComponent.swift
//  core_app
//
//  Created by Luis Silva on 25/03/24.
//

import Assets
import BackendLib
import SwiftUI

struct WeekDaysComponent: View {
    @Environment(\.modelContext) private var modelContext
    var day: Int
    var month: Int
    var year: Int
    var weekDay: WeekDays

    @Binding var date: Date

    var body: some View {
        VStack(spacing: 20) {
            Text("\(weekDay.rawValue)")
                .foregroundColor(Colors.gray_800)
                .font(.system(size: 14))
            DaysComponent(
                context: modelContext,
                day: day,
                month: month,
                year: year,
                date: $date
            )
        }
    }
}

// #Preview {
//    WeekDaysComponent()
// }
