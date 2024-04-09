//
//  DaysComponent.swift
//  core_app
//
//  Created by Luis Silva on 26/03/24.
//

import Assets
import BackendLib
import SwiftData
import SwiftUI

enum ArrangeDaysComponent {
    case normalDay
    case dayFromAnotherMonth
}

enum TypeOfTheDays {
    case periodDays
    case fertileDays
    case normalDay
    case anotherMonth
}

struct DaysComponent: View {
    @State var cycleService: CycleService
    var day: Int
    var month: Int
    var year: Int
    @State var dayToAppearOnScreen: Int = 0
    @State var opacity = 1.0
    @State var thereIsInput: Bool = false

    @Binding var date: Date

    init(context: ModelContext, day: Int, month: Int, year: Int, date: Binding<Date>) {
        self.day = day
        self.month = month
        self.year = year
        _date = date

        cycleService = CycleService(context: context)
        _cycleService = State(initialValue: cycleService)
    }

    var body: some View {
        let lastDayInTheMonth = CycleCalculation().getNumberOfDaysInAMonth(month, year) ?? 30
        let arrenge: ArrangeDaysComponent = arrangeOfTheDay(lastDayInTheMonth)
        let type: TypeOfTheDays = verifyTheTypeOfTheDay(day, month, year, lastDayInTheMonth)
        let colorOfTheDay: Color = defineTheColorOfTheDay(type)
        let opacityOfTheDay: Double = defineOpacity(type)
        let (dayToUseOneCalendar, monthToUseOnCalendar, yearToUseOnCalendar):
            (Int, Int, Int) = defineDayToUse(day, month, year, lastDayInTheMonth, arrenge)
        let checkIfIsToday = checkIfDayIsToday(day, month, year, type)

        ZStack {
            Rectangle()
                .frame(width: 52, height: 68, alignment: .center)
                .foregroundColor(checkIfIsToday)
                .background(colorOfTheDay)
                .cornerRadius(24)

            Button(action: {
                date = getADateToUseInTheFunctions(dayToUseOneCalendar, monthToUseOnCalendar, yearToUseOnCalendar)
//                CycleCalculation().createCycles(cycleService: cycleService)
            }, label: {
                ZStack(alignment: .center) {
                    if dayToUseOneCalendar < 10 {
                        Text("0\(dayToUseOneCalendar)")
                            .font(.custom("Poppins", size: 16))
                            .colorMultiply(.black)
                    } else if dayToUseOneCalendar >= 10 {
                        Text("\(dayToUseOneCalendar)")
                            .font(.custom("Poppins", size: 16))
                            .colorMultiply(.black)
                    }
                }
                .frame(width: 44, height: 60, alignment: .center)
            })
            .colorMultiply(colorOfTheDay)
            .background(colorOfTheDay)
            .frame(width: 44, height: 60, alignment: .center)
            .cornerRadius(24)
            .opacity(opacityOfTheDay)

            if thereIsInput {
                RoundedRectangle(cornerRadius: 26)
                    .frame(width: 5, height: 6)
                    .padding(.top, 42)
                    .colorMultiply(.blue)
            }
        }
    }

    func arrangeOfTheDay(_ lastDay: Int) -> ArrangeDaysComponent {
        if day < 1 || day > lastDay {
            return .dayFromAnotherMonth
        } else {
            return .normalDay
        }
    }

    // essa função precisa ser reestruturada quando o banco de dados for integrado, ela deve pegar
    // a data da ultima menstruação e calcular a partir dela a proxima e salvar,
    // e com isso, pegar esse ultimo dado para calcular a proximo e assim por diante
    func verifyTheTypeOfTheDay(_ day: Int, _ month: Int, _ year: Int, _ lastDayInTheMonth: Int) -> TypeOfTheDays {
        let durationOfThePeriod = 5 // corrigir para input da usuária

        let (dayToUse, monthToUSe, yearToUse) = getTheDayFromAnotherMonth(day, month, year, lastDayInTheMonth)

        var today = Date()
        today = getADateToUseInTheFunctions(dayToUse, monthToUSe, yearToUse)

        // se o dia for anterior ao dia de hoje, olha no banco
        if today < Date() {
            for cycle in cycleService.cycles {
                if cycle.startDate <= today &&
                    Calendar.current.date(byAdding: .day, value: 5, to: cycle.startDate) ?? today >= today
                {
                    return .periodDays
                } else if Calendar.current.date(byAdding: .day, value: -13, to: cycle.startDate) ?? today <= today &&
                    Calendar.current.date(byAdding: .day, value: -7, to: cycle.startDate) ?? today >= today
                {
                    return .fertileDays
                }
            }
        } else { // se o dia for no futuro, tenta prever o que acontecerá
            if CycleCalculation().verifyDaysOfStartNextCycles(today, cycleService, durationOfThePeriod) {
                return .periodDays
            } else if CycleCalculation().verifyFertileNextDays(today, cycleService) {
                return .fertileDays
            }
        }

        if day < 1 || day > lastDayInTheMonth {
            return .anotherMonth
        } else {
            return .normalDay
        }
    }

    func getTheDayFromAnotherMonth(_ day: Int, _ month: Int, _ year: Int, _ lastDay: Int) -> (Int, Int, Int) {
        if day < 1 {
            if month - 1 == 0 {
                return ((CycleCalculation().getNumberOfDaysInAMonth(month - 1, year) ?? 30) + day, 12, year - 1)
            } else {
                return ((CycleCalculation().getNumberOfDaysInAMonth(month - 1, year) ?? 30) + day, month - 1, year)
            }
        } else if day > lastDay {
            if month + 1 == 13 {
                return (day - lastDay, 1, year + 1)
            } else {
                return (day - lastDay, month + 1, year)
            }
        } else {
            return (day, month, year)
        }
    }

    func defineTheColorOfTheDay(_ type: TypeOfTheDays) -> Color {
        if type == .normalDay {
            return Colors.gray_50
        } else if type == .anotherMonth {
            return Colors.gray_50
        } else if type == .fertileDays {
            return Colors.blue_200
        } else if type == .periodDays {
            return Colors.red_200
        } else {
            return Colors.gray_50
        }
    }

    func defineOpacity(_ type: TypeOfTheDays) -> Double {
        switch type {
        case .normalDay:
            return 1.0
        case .anotherMonth:
            return 0.3
        case .periodDays:
            return 1.0
        case .fertileDays:
            return 1.0
        }
    }

    func defineDayToUse(_ day: Int, _ month: Int, _ year: Int, _ lastDay: Int, _ arrange: ArrangeDaysComponent) -> (Int, Int, Int) {
        switch arrange {
        case .normalDay:
            return (day, month, year)
        case .dayFromAnotherMonth:
            return getTheDayFromAnotherMonth(day, month, year, lastDay)
        }
    }

    func getADateToUseInTheFunctions(_ dayToUse: Int, _ monthToUSe: Int, _ yearToUse: Int) -> Date {
        var date = Date()

        // acerta o ano
        if yearToUse < Calendar.current.component(.year, from: date) {
            while yearToUse < Calendar.current.component(.year, from: date) {
                date = Calendar.current.date(byAdding: .year, value: -1, to: date) ?? Date()
            }
        } else if yearToUse > Calendar.current.component(.year, from: date) {
            while yearToUse > Calendar.current.component(.year, from: date) {
                date = Calendar.current.date(byAdding: .year, value: 1, to: date) ?? Date()
            }
        }

        // acerta o mes
        if monthToUSe < Calendar.current.component(.month, from: date) {
            while monthToUSe < Calendar.current.component(.month, from: date) {
                date = Calendar.current.date(byAdding: .month, value: -1, to: date) ?? Date()
            }
        } else if monthToUSe > Calendar.current.component(.month, from: date) {
            while monthToUSe > Calendar.current.component(.month, from: date) {
                date = Calendar.current.date(byAdding: .month, value: 1, to: date) ?? Date()
            }
        }

        // acerta o dia
        if dayToUse < Calendar.current.component(.day, from: date) {
            while dayToUse < Calendar.current.component(.day, from: date) {
                date = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? Date()
            }
        } else if dayToUse > Calendar.current.component(.day, from: date) {
            while dayToUse > Calendar.current.component(.day, from: date) {
                date = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? Date()
            }
        }

        return date
    }

    func checkIfDayIsToday(_ day: Int, _ month: Int, _ year: Int, _ type: TypeOfTheDays) -> Color {
        if Calendar.current.component(.day, from: Date()) == day &&
            Calendar.current.component(.month, from: Date()) == month &&
            Calendar.current.component(.year, from: Date()) == year
        {
            return Colors.purple_600
        } else if type == .fertileDays {
            return Colors.blue_200
        } else if type == .periodDays {
            return Colors.red_200
        }
        return Colors.gray_50
    }
}

// #Preview {
//    DaysComponent(day: 1, month: 1, year: 2024)
// }
