//
//  MainView.swift
//  the_king_of_baking
//
//  Created by 최은성 on 2022/08/21.
//

import SwiftUI

struct MainView: View {
    @State var isActive: Bool = true
    @State var isToggle: Bool = true
    @Binding var selectedData: [String]
    var body: some View {
        VStack {
            VStack {
                if isActive {
                    PossibleView(selectedData: $selectedData)
                } else {
                    ImpossibleView(selectedData: $selectedData)
                }
            }
                .toolbar {
                    ToolbarItemGroup(placement: .principal) {
                        HStack {
                            Button(action: {
                                isActive = true
                                isToggle = true
//                                toggleB = false
                            }, label: {
                                Text("가능 메뉴")
                                    .foregroundColor(isToggle ? .black : .gray)
                                    .font(.custom("OTRecipekoreaM", size: 15))
                            })
                            Button(action: {
                                isActive = false
                                isToggle = false
                            }, label: {
                                Text("근접 메뉴")
                                    .foregroundColor(!isToggle ? .black : .gray)
                                    .font(.custom("OTRecipekoreaM", size: 15))
                            })
                        }
                    }
                }
        }
        .onAppear {
            print("selectedData: \(selectedData)")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selectedData: .constant([""]))
    }
}
