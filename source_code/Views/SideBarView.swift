//
//  SideBarView.swift
//  core_app
//
//  Created by Caio Melloni dos Santos on 25/03/24.
//

import Assets
import BackendLib
import SwiftData
import SwiftUI

struct SideBarView: View {
    @State var date: Date = Date()
    @Environment(\.modelContext) private var context

    var body: some View {
        VStack {
            List {
                sidebarItem(label: "Calendar", systemImage: "calendar",
                            destination: AnyView(CalendarView(context: context, date: $date)))
                sidebarItem(label: "Exams", systemImage: "calendar", destination: AnyView(ExamsView()))
                sidebarItem(label: "Graphic", systemImage: "calendar", destination: AnyView(GraphicView()))
            }
            .padding(.top, 16)
            .background(Color.clear)
            .listStyle(.sidebar)
        }
    }

    func sidebarItem(label: String, systemImage: String, destination: AnyView) -> some View {
        NavigationLink(destination: destination) {
            Label(label, systemImage: systemImage)
                .frame(height: 56)
                .fixedSize(horizontal: true, vertical: false)
        }
    }
}
