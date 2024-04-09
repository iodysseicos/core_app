//
//  SymptomCorrelation.swift
//  core_app
//
//  Created by Clissia Bozzer Bovi on 04/04/24.
//

import Assets
import BackendLib
import Foundation
import SwiftUI

enum SymptomCorrelation {
    static func getText(_ symptom: SymptomType) -> String {
        switch symptom {
        case .tenderbreasts:
            return Symptons.sensitiveBreasts.rawValue
        case .cramps:
            return Symptons.cramp.rawValue
        case .headache:
            return Symptons.headache.rawValue
        case .backpain:
            return Symptons.backache.rawValue
        case .acne:
            return Symptons.acne.rawValue
        case .tiredness:
            return Symptons.tiredness.rawValue
        case .largeappetite:
            return Symptons.veryHungry.rawValue
        case .lackofappetite:
            return Symptons.notHungry.rawValue
        case .nausea:
            return Symptons.nausea.rawValue
        case .insomnia:
            return Symptons.insomnia.rawValue
        case .bloating:
            return Symptons.bloating.rawValue
        case .constipation:
            return Symptons.constipation.rawValue
        case .diarrhea:
            return Symptons.diarrhea.rawValue
        }
    }

    static func getSymptomType(_ text: String) -> SymptomType {
        guard let symptons = Symptons(rawValue: text) else { return .nausea }
        switch symptons {
        case .sensitiveBreasts:
            return SymptomType.tenderbreasts
        case .cramp:
            return SymptomType.cramps
        case .headache:
            return SymptomType.headache
        case .backache:
            return SymptomType.backpain
        case .acne:
            return SymptomType.acne
        case .tiredness:
            return SymptomType.tiredness
        case .veryHungry:
            return SymptomType.largeappetite
        case .notHungry:
            return SymptomType.lackofappetite
        case .nausea:
            return SymptomType.nausea
        case .insomnia:
            return SymptomType.insomnia
        case .diarrhea:
            return SymptomType.diarrhea
        case .constipation:
            return SymptomType.constipation
        case .bloating:
            return SymptomType.bloating
        }
    }

    static func getImage(_ symptom: SymptomType) -> Image {
        switch symptom {
        case .tenderbreasts:
            return Images.symptomTenderbreasts.swiftUIImage
        case .cramps:
            return Images.symptomCramps.swiftUIImage
        case .headache:
            return Images.symptomHeadache.swiftUIImage
        case .backpain:
            return Images.symptomBackpain.swiftUIImage
        case .acne:
            return Images.symptomAcne.swiftUIImage
        case .tiredness:
            return Images.symptomTiredness.swiftUIImage
        case .largeappetite:
            return Images.symptomLargeappetite.swiftUIImage
        case .lackofappetite:
            return Images.symptomLackofappetite.swiftUIImage
        case .nausea:
            return Images.symptomNausea.swiftUIImage
        case .insomnia:
            return Images.symptomInsomnia.swiftUIImage
        case .bloating:
            return Images.symptomBloating.swiftUIImage
        case .constipation:
            return Images.symptomConstipation.swiftUIImage
        case .diarrhea:
            return Images.symptomDiarrhea.swiftUIImage
        }
    }
}
