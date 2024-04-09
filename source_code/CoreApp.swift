//
//  CoreApp.swift
//  teste
//
//  Created by Caio Melloni dos Santos on 25/03/24.
//

import BackendLib
import SwiftData
import SwiftUI

@main
struct CoreApp: App {
    let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(
                for:
                User.self,
                UsesMedication.self,
                Medication.self,
                Cycle.self,
                CycleMood.self,
                Period.self,
                CycleSymptom.self
            )
//            container.deleteAllData()

        } catch {
            fatalError("Failed to create ModelContainer")
        }
        let cycleService = CycleService(context: container.mainContext)
        _cycleService = State(initialValue: cycleService)
    }

    var dayToPass = Calendar.current.component(.day, from: Date())
    var monthToPass = Calendar.current.component(.month, from: Date())
    var yearToPass = Calendar.current.component(.year, from: Date())
    @State var date: Date = .init()
    @State private var cycleService: CycleService

    var body: some Scene {
        WindowGroup {
            BackendProvider {
                NavigationView {
                    SideBarView(date: $date, cycleService: cycleService)
                }
                .modelContainer(container)
                .preferredColorScheme(.light)
            }
        }
    }
}
