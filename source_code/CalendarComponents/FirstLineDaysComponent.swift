//
//  FirstLineDaysComponent.swift
//  core_app
//
//  Created by Luis Silva on 26/03/24.
//

import BackendLib
import SwiftUI

struct FirstLineDaysComponent: View {
    var day: Int
    var month: Int
    var year: Int

    @Binding var date: Date

    var body: some View {
        HStack(spacing: 31) {
            WeekDaysComponent(
                day: day + WeekDaysNumber.sunday.rawValue,
                month: month,
                year: year,
                weekDay: .sunday,
                date: $date
            )
            WeekDaysComponent(
                day: day + WeekDaysNumber.monday.rawValue,
                month: month,
                year: year,
                weekDay: .monday,
                date: $date
            )
            WeekDaysComponent(
                day: day + WeekDaysNumber.tuesday.rawValue,
                month: month,
                year: year,
                weekDay: .tuesday,
                date: $date
            )
            WeekDaysComponent(
                day: day + WeekDaysNumber.wednesday.rawValue,
                month: month,
                year: year,
                weekDay: .wednesday,
                date: $date
            )
            WeekDaysComponent(
                day: day + WeekDaysNumber.thuesday.rawValue,
                month: month,
                year: year,
                weekDay: .thuesday,
                date: $date
            )
            WeekDaysComponent(
                day: day + WeekDaysNumber.friday.rawValue,
                month: month,
                year: year,
                weekDay: .friday,
                date: $date
            )
            WeekDaysComponent(
                day: day + WeekDaysNumber.saturday.rawValue,
                month: month,
                year: year,
                weekDay: .saturday,
                date: $date
            )
        }
    }
}

// #Preview {
//    FirstLineDaysComponent(day: 1, month: 1, year: 2024)
// }
