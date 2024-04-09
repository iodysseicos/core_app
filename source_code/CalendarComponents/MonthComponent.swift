//
//  MonthComponent.swift
//  core_app
//
//  Created by Luis Silva on 25/03/24.
//

import Assets
import SwiftUI

struct MonthComponent: View {
    @Binding var month: Int
    @Binding var year: Int

    var body: some View {
        ZStack {
            HStack {
                Button(action: {
                    if month - 1 > 0 {
                        month -= 1
                    } else {
                        month = 12
                        year -= 1
                    }
                }) {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 16))
                        .foregroundColor(Colors.gray_800)
                }.buttonBorderShape(.circle)

                VStack {
                    Text(getMonthName(month) ?? "January")
                        .foregroundColor(Colors.purple_400)
                        .font(.system(size: 26))
                    Text(String(year))
                        .font(.system(size: 16))
                        .foregroundColor(Colors.gray_800)
                }

                Button(action: {
                    if month + 1 < 13 {
                        month += 1
                    } else {
                        month = 1
                        year += 1
                    }
                }) {
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 16))
                        .foregroundColor(Colors.gray_800)
                }.buttonBorderShape(.circle)
            }
        }
    }

    func getMonthName(_ month: Int) -> String? {
        switch month {
        case 1: return "January"
        case 2: return "February"
        case 3: return "March"
        case 4: return "April"
        case 5: return "May"
        case 6: return "June"
        case 7: return "July"
        case 8: return "August"
        case 9: return "September"
        case 10: return "October"
        case 11: return "November"
        case 12: return "December"
        default:
            return "Error"
        }
    }
}

// #Preview {
//    MonthComponent(month: month, year: 2024)
// }
