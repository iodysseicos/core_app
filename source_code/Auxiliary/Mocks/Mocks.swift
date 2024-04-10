//
//  Mocks.swift
//  core_app
//
//  Created by Clissia Bozzer Bovi on 01/04/24.
//

import Foundation
import SwiftUI
import BackendLib

enum SelectionType {
    case symptons
    case mood
}

protocol SelectionData {
    var titleText: String { get set }
    var popOverTitle: String { get set }
    var buttonTitle: String { get set }
    var list: [SelectionElement] { get set }
    // var getImage
}

enum Mocks {
    struct Symptons: SelectionData {
        var titleText: String = "Today's Symptom"

        var popOverTitle: String = "Symptoms"

        var buttonTitle: String = "Add Symptom"

        var list: [SelectionElement] = [SelectionElement(selectionName: SymptomCorrelation.getText(.tenderbreasts),
                                                         image: SymptomCorrelation.getImage(.tenderbreasts)),
                                        SelectionElement(selectionName: SymptomCorrelation.getText(.cramps),
                                                         image: SymptomCorrelation.getImage(.cramps)),
                                        SelectionElement(selectionName: SymptomCorrelation.getText(.headache),
                                                         image: SymptomCorrelation.getImage(.headache)),
                                        SelectionElement(selectionName: SymptomCorrelation.getText(.backpain),
                                                         image: SymptomCorrelation.getImage(.backpain)),
                                        SelectionElement(selectionName: SymptomCorrelation.getText(.acne),
                                                         image: SymptomCorrelation.getImage(.acne)),
                                        SelectionElement(selectionName: SymptomCorrelation.getText(.nausea),
                                                         image: SymptomCorrelation.getImage(.nausea)),
                                        SelectionElement(selectionName: SymptomCorrelation.getText(.tiredness),
                                                         image: SymptomCorrelation.getImage(.tiredness)),
                                        SelectionElement(selectionName: SymptomCorrelation.getText(.largeappetite),
                                                         image: SymptomCorrelation.getImage(.largeappetite)),
                                        SelectionElement(selectionName: SymptomCorrelation.getText(.lackofappetite),
                                                         image: SymptomCorrelation.getImage(.lackofappetite)),
                                        SelectionElement(selectionName: SymptomCorrelation.getText(.insomnia),
                                                         image: SymptomCorrelation.getImage(.insomnia)),
                                        SelectionElement(selectionName: SymptomCorrelation.getText(.diarrhea),
                                                         image: SymptomCorrelation.getImage(.diarrhea)),
                                        SelectionElement(selectionName: SymptomCorrelation.getText(.constipation),
                                                         image: SymptomCorrelation.getImage(.constipation)),
                                        SelectionElement(selectionName: SymptomCorrelation.getText(.bloating),
                                                         image: SymptomCorrelation.getImage(.bloating))]
    }

    struct Mood: SelectionData {
        var titleText: String = "Today's mood"

        var popOverTitle: String = "Moods"

        var buttonTitle: String = "Add Mood"

        var list: [SelectionElement] = [SelectionElement(selectionName: MoodCorrelation.getText(.calm),
                                                         image: MoodCorrelation.getImage(.calm)),
                                        SelectionElement(selectionName: MoodCorrelation.getText(.happy),
                                                         image: MoodCorrelation.getImage(.happy)),
                                        SelectionElement(selectionName: MoodCorrelation.getText(.energetic),
                                                         image: MoodCorrelation.getImage(.energetic)),
                                        SelectionElement(selectionName: MoodCorrelation.getText(.irritated),
                                                         image: MoodCorrelation.getImage(.irritated)),
                                        SelectionElement(selectionName: MoodCorrelation.getText(.anxious),
                                                         image: MoodCorrelation.getImage(.anxious)),
                                        SelectionElement(selectionName: MoodCorrelation.getText(.sad),
                                                         image: MoodCorrelation.getImage(.sad)),
                                        SelectionElement(selectionName: MoodCorrelation.getText(.apathetic),
                                                         image: MoodCorrelation.getImage(.apathetic)),
                                        SelectionElement(selectionName: MoodCorrelation.getText(.confused),
                                                         image: MoodCorrelation.getImage(.confused)),
                                        SelectionElement(selectionName: MoodCorrelation.getText(.selfcritical),
                                                         image: MoodCorrelation.getImage(.selfcritical)),
                                        SelectionElement(selectionName: MoodCorrelation.getText(.emotional),
                                                         image: MoodCorrelation.getImage(.emotional)),
                                        SelectionElement(selectionName: MoodCorrelation.getText(.tired),
                                                         image: MoodCorrelation.getImage(.tired))]
    }

    static func getData(type: SelectionType) -> SelectionData {
        switch type {
        case .symptons:
            return Symptons()
        case .mood:
            return Mood()
        }
    }
    static func mapSympthomToSelectionElement(_ sympthom: SymptomType) -> SelectionElement {
        let mapping: [SymptomType: SelectionElement] = [
            .tenderbreasts: SelectionElement(selectionName: SymptomCorrelation.getText(.tenderbreasts),
                                        image: SymptomCorrelation.getImage(.tenderbreasts)),
            .cramps: SelectionElement(selectionName: SymptomCorrelation.getText(.cramps),
                                        image: SymptomCorrelation.getImage(.cramps)),
            .headache: SelectionElement(selectionName: SymptomCorrelation.getText(.headache),
                                        image: SymptomCorrelation.getImage(.headache)),
            .backpain: SelectionElement(selectionName: SymptomCorrelation.getText(.backpain),
                                        image: SymptomCorrelation.getImage(.backpain)),
            .acne: SelectionElement(selectionName: SymptomCorrelation.getText(.acne),
                                        image: SymptomCorrelation.getImage(.acne)),
            .nausea: SelectionElement(selectionName: SymptomCorrelation.getText(.nausea),
                                        image: SymptomCorrelation.getImage(.nausea)),
            .tiredness: SelectionElement(selectionName: SymptomCorrelation.getText(.tiredness),
                                        image: SymptomCorrelation.getImage(.tiredness)),
            .largeappetite: SelectionElement(selectionName: SymptomCorrelation.getText(.largeappetite),
                                        image: SymptomCorrelation.getImage(.largeappetite)),
            .lackofappetite: SelectionElement(selectionName: SymptomCorrelation.getText(.lackofappetite),
                                        image: SymptomCorrelation.getImage(.lackofappetite)),
            .insomnia: SelectionElement(selectionName: SymptomCorrelation.getText(.insomnia),
                                        image: SymptomCorrelation.getImage(.insomnia)),
            .diarrhea: SelectionElement(selectionName: SymptomCorrelation.getText(.diarrhea),
                                        image: SymptomCorrelation.getImage(.diarrhea)),
            .constipation: SelectionElement(selectionName: SymptomCorrelation.getText(.constipation),
                                        image: SymptomCorrelation.getImage(.constipation)),
            .bloating: SelectionElement(selectionName: SymptomCorrelation.getText(.bloating),
                                        image: SymptomCorrelation.getImage(.bloating))
        ]
        return mapping[sympthom]!
    }
    
    static func mapMoodToSelectionElement(_ mood: MoodType) -> SelectionElement {
        let mapping: [MoodType: SelectionElement] = [
            .calm: SelectionElement(selectionName: MoodCorrelation.getText(.calm),
                                                                      image: MoodCorrelation.getImage(.calm)),
            .happy: SelectionElement(selectionName: MoodCorrelation.getText(.happy),
                                                                      image: MoodCorrelation.getImage(.happy)),
            .energetic: SelectionElement(selectionName: MoodCorrelation.getText(.energetic),
                                                                      image: MoodCorrelation.getImage(.energetic)),
            .irritated: SelectionElement(selectionName: MoodCorrelation.getText(.irritated),
                                                                      image: MoodCorrelation.getImage(.irritated)),
            .anxious:SelectionElement(selectionName: MoodCorrelation.getText(.anxious),
                                                                      image: MoodCorrelation.getImage(.anxious)),
            .sad: SelectionElement(selectionName: MoodCorrelation.getText(.sad),
                                                                      image: MoodCorrelation.getImage(.sad)),
            .apathetic: SelectionElement(selectionName: MoodCorrelation.getText(.apathetic),
                                                                      image: MoodCorrelation.getImage(.apathetic)),
            .confused: SelectionElement(selectionName: MoodCorrelation.getText(.confused),
                                                                      image: MoodCorrelation.getImage(.confused)),
            .selfcritical: SelectionElement(selectionName: MoodCorrelation.getText(.selfcritical),
                                                                      image: MoodCorrelation.getImage(.selfcritical)),
            .emotional: SelectionElement(selectionName: MoodCorrelation.getText(.emotional),
                                                                      image: MoodCorrelation.getImage(.emotional)),
            .tired: SelectionElement(selectionName: MoodCorrelation.getText(.tired),
                                                                      image: MoodCorrelation.getImage(.tired))
        ]
        
        return mapping[mood]!
    }
}
