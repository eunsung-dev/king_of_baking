//
//  DataRow.swift
//  the_king_of_baking
//
//  Created by 최은성 on 2022/08/21.
//

import Foundation
import SwiftUI

struct DataRow: View {
    var data: DataModel
    @Binding var selectedData: [String]
    
    var isSelected: Bool {
        selectedData.contains(data.name)
    }

    var body: some View {
        HStack {
            Text(data.name)
                .font(.custom("OTRecipekoreaM", size: 15))
            Spacer()
            if isSelected {
                Image("correct")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            if !isSelected {
                Image("check-mark")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if isSelected {
                if let firstIndex = selectedData.firstIndex(of: data.name) {
                    selectedData.remove(at: firstIndex)
                }
            } else {
                selectedData.append(data.name)
            }
        }
    }
}
