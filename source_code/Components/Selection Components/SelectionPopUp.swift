//
//  SelectionPopUp.swift
//  core_app
//
//  Created by Clissia Bozzer Bovi on 25/03/24.
//

import Assets
import BackendLib
import SwiftData
import SwiftUI

struct SelectionPopUp: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selection: [SelectionElement]
    @Binding var listElements: [SelectionElement]
    @State private var selectedElements: [SelectionElement] = []
    @State private var removedElements: [SelectionElement] = []
    @State var dateString: String
    @State private var cycleService: CycleService

    var cycle: Cycle
    var context: ModelContext
    let columns = [GridItem(.flexible())]
    let selectionType: SelectionType
    let date: Date
    let title: String

    private func passToFrame() {
        for element in selectedElements {
            selection.append(element)
        }

        for element in removedElements {
            let name = element.selectionName
            if let index = selection.firstIndex(where: { $0.selectionName == name }) {
                selection.remove(at: index)
            }
        }
    }

    private func getSympthomType(_ index: Int) -> SymptomType {
        let text = removedElements[index].selectionName
        return SymptomCorrelation.getSymptomType(text)
    }

    private func getMoodType(_ index: Int) -> MoodType {
        let text = selectedElements[index].selectionName
        return MoodCorrelation.getMoodType(text)
    }

    private func save() {
        switch selectionType {
        case .symptons:
            saveSymptom()
            deleteSymptom()
        case .mood:
            saveMood()
            deleteMood()
        }
    }

    private func deleteSymptom() {
        for index in 0 ..< removedElements.count {
            let sympthomType = getSympthomType(index)
            cycleService.removeSympthom(cycle: cycle, symptom: sympthomType, date: date)
        }
    }

    private func deleteMood() {
        for index in 0 ..< removedElements.count {
            let text = removedElements[index].selectionName
            let moodType = MoodCorrelation.getMoodType(text)
            cycleService.removeMood(cycle: cycle, moodType: moodType, date: date)
        }
    }

    private func saveSymptom() {
        for index in 0 ..< selectedElements.count {
            let text = selectedElements[index].selectionName
            let sympthomType = SymptomCorrelation.getSymptomType(text)
            cycleService.addSymptom(cycle: cycle, symptom: sympthomType, date: date)
        }
    }

    private func saveMood() {
        for index in 0 ..< selectedElements.count {
            let moodType = getMoodType(index)
            cycleService.addMood(cycle: cycle, moodType: moodType, date: date)
        }
    }

    init(selection: Binding<[SelectionElement]>,
         listElements: Binding<[SelectionElement]>,
         dateString: String,
         cycle: Cycle,
         context: ModelContext,
         selectionType: SelectionType,
         date: Date,
         title: String)
    {
        _selection = selection
        _listElements = listElements
        self.dateString = dateString
        self.cycle = cycle
        self.context = context
        self.selectionType = selectionType
        self.date = date
        self.title = title
        let cycleService = CycleService(context: context)
        _cycleService = State(initialValue: cycleService)
    }

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 13, weight: .regular))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Colors.purple_700)

                Text(dateString)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(Color(Colors.gray_700))
            }
            .padding(.leading, 16)

            Divider()

            ScrollView {
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(listElements) { element in
                        let index = listElements.firstIndex(of: element) ?? 0
                        let didTapElement = element.didTap
                        HStack(spacing: 10) {
                            Circle()
                                .size(CGSize(width: 20, height: 20))
                                .foregroundColor(didTapElement ?
                                    Color(Colors.purple_600) : Color(Colors.gray_400))

                            Text(element.selectionName)
                                .font(.system(size: 17, weight: .regular))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .alignmentGuide(.leading) { dimension in
                                    dimension[VerticalAlignment.center]
                                }
                                .foregroundColor(didTapElement ?
                                    Color(Colors.purple_600) : Color(Colors.gray_400))

                            Spacer()
                        }
                        .onTapGesture {
                            listElements[index].tap()
                            if didTapElement {
                                removedElements.append(listElements[index])
                            } else {
                                selectedElements.append(listElements[index])
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            Divider()
            Button {
                dismiss()
            } label: {
                Text("Concluído")
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(Colors.purple_500))
            .frame(width: 100, height: 28)
        }
        .padding(.vertical)
        .background(Color.white)
        .onDisappear {
            save()
            passToFrame()
            dismiss()
        }
    }
}
