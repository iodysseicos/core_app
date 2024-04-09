//
//  CycleCalculation.swift
//  core_app
//
//  Created by Luis Silva on 28/03/24.
//

import BackendLib
import Foundation

struct CycleCalculation {
    // calcula daqui quantos dias será iniciado o próximo ciclo
    func calculateDurationOfTheCycle(_ allCycles: [Cycle]) -> Int {
        var allTheDuration = 0.0
        var cycles = 0.0
        for cycle in allCycles {
            allTheDuration += Double(Calendar.current.dateComponents([.day],
                                                                     from: cycle.startDate, to: cycle.endDate).day ?? 0)
            cycles += 1
        }

        var result = allTheDuration / cycles

        if (result - Double(Int(result))) >= 0.5 {
            result += 1
        }
        return Int(result)
    }

    func getTheStartOfTheLastCycle(_ cycleService: CycleService) -> (Int, Int, Int) {
        var day = 0
        var month = 0
        var year = 0
        for cycle in cycleService.cycles {
            day = Calendar.current.component(.day, from: cycle.startDate)
            month = Calendar.current.component(.month, from: cycle.startDate)
            year = Calendar.current.component(.year, from: cycle.startDate)
        }
        return (day, month, year)
    }

    func verifyDaysOfStartNextCycles(_ today: Date, _ cycleService: CycleService, _ durationOfThePeriod: Int) -> Bool {
        let cyclesSorted = cycleService.cycles.sorted(by: { $0.startDate < $1.startDate })
        guard let startOfLastCycle = cyclesSorted.last?.startDate else { return false }

        let duration = CycleCalculation().calculateDurationOfTheCycle(cyclesSorted) // duration of the cycle

        for variable in 1 ... 6 {
            // colocar que se é maior que a data de inicio e menor que a data + tempo de ciclo
            let dateOfStartOfNextCycle = Calendar.current.date(byAdding: .day,
                                                               value: duration * variable,
                                                               to: startOfLastCycle) ?? Date()

            if today > dateOfStartOfNextCycle {
                if today < Calendar.current.date(byAdding: .day,
                                                 value: durationOfThePeriod,
                                                 to: dateOfStartOfNextCycle) ?? Date()
                {
                    return true
                }
            }
        }

        return false
    }

    func verifyFertileNextDays(_ today: Date, _ cycleService: CycleService) -> Bool {
        let cyclesSorted = cycleService.cycles.sorted(by: { $0.startDate < $1.startDate })
        guard let startOfLastCycle = cyclesSorted.last?.startDate else { return false }

        let duration = CycleCalculation().calculateDurationOfTheCycle(cyclesSorted) // duration of the cycle

        let dateOfStartOfNextCycle = Calendar.current.date(byAdding: .day,
                                                           value: duration,
                                                           to: startOfLastCycle) ?? Date()
        if Calendar.current.date(byAdding: .day, value: -13, to: dateOfStartOfNextCycle) ?? today <= today &&
            Calendar.current.date(byAdding: .day, value: -7, to: dateOfStartOfNextCycle) ?? today >= today
        {
            return true
        }
        return false
    }

    // com o resultado de quanto tempo o ciclo durará, obtido da função a cima,
    // verifica em qual dia será a próxima menstruação
    // o dia, o mes e o ano são da data do inicio da ultima mesntruação
    func calculateTheDayOfTheNextCycle(_ cycleService: CycleService) -> (Int, Int, Int) {
        let (day, month, year) = getTheStartOfTheLastCycle(cycleService)
        let lastDayOfThisMonth = getNumberOfDaysInAMonth(month, year) ?? 30
        let duration = calculateDurationOfTheCycle(cycleService.cycles.sorted(by: { $0.startDate > $1.startDate }))
        var dayOfTheNextStart = day + duration
        var monthOfTheNextStart = month
        var yearOfTheNextStart = year
        if dayOfTheNextStart > lastDayOfThisMonth {
            dayOfTheNextStart -= lastDayOfThisMonth
            monthOfTheNextStart += 1
        }
        if monthOfTheNextStart > month, month == 12 {
            monthOfTheNextStart = 1
            yearOfTheNextStart += 1
        }

        return (dayOfTheNextStart, monthOfTheNextStart, yearOfTheNextStart)
    }

    func getNumberOfDaysInAMonth(_ month: Int, _ year: Int) -> Int? {
        var components = DateComponents()
        components.year = year
        components.month = month + 1
        components.day = 0
        return Calendar.current.component(.day, from: Calendar.current.date(from: components) ?? Date())
    }

    func printAllCycles(cycleService: CycleService) {
        for cycle in cycleService.cycles {
            print(cycle.startDate)
        }
    }

    func createCycles(cycleService: CycleService) {
        _ = cycleService.createCycle(startDate: Calendar.current.date(byAdding: .day, value: -150, to: Date())!,
                                     endDate: Calendar.current.date(byAdding: .day, value: -122, to: Date())!)

        _ = cycleService.createCycle(startDate: Calendar.current.date(byAdding: .day, value: -121, to: Date())!,
                                     endDate: Calendar.current.date(byAdding: .day, value: -95, to: Date())!)

        _ = cycleService.createCycle(startDate: Calendar.current.date(byAdding: .day, value: -94, to: Date())!,
                                     endDate: Calendar.current.date(byAdding: .day, value: -64, to: Date())!)

        _ = cycleService.createCycle(startDate: Calendar.current.date(byAdding: .day, value: -63, to: Date())!,
                                     endDate: Calendar.current.date(byAdding: .day, value: -36, to: Date())!)

        _ = cycleService.createCycle(startDate: Calendar.current.date(byAdding: .day, value: -35, to: Date())!,
                                     endDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!)

        _ = cycleService.createCycle(startDate: Calendar.current.date(byAdding: .day, value: -6, to: Date())!,
                                     endDate: Calendar.current.date(byAdding: .day, value: 20, to: Date())!)
    }
}
