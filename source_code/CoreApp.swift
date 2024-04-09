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
    }

    var body: some Scene {
        WindowGroup {
            BackendProvider {
                NavigationView {
                    SideBarView()
                }
                .modelContainer(container)
                .preferredColorScheme(.light)
            }
        }
    }
}
