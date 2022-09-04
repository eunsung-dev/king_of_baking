//
//  DetailView.swift
//  the_king_of_baking
//
//  Created by 최은성 on 2022/08/22.
//

import SwiftUI

struct DetailView: View {
    @Binding var selectedData: Recipe
    var body: some View {
        List{
            VStack(alignment: .leading) {
                Text(selectedData.recipeName)
                    .font(.custom("OTRecipekoreaM", size: 20))
                    .bold()
                    .padding()
                    .background(
                        Rectangle()
                            .fill(Color.brown)
                            .padding()
                    )
                Text(selectedData.recipeAbstract)
                    .font(.custom("OTRecipekoreaM", size: 15))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding([.leading, .bottom])
                VStack(alignment: .center) {
                    Text("준비물")
                        .font(.custom("OTRecipekoreaM", size: 15))
                        .bold()
                    ForEach(selectedData.recipeIngredients, id: \.self) { data in
                        Text(data)
                            .font(.custom("OTRecipekoreaM", size: 15))
                            .lineLimit(5)
                            .frame(alignment: .center)
                        //                            .fixedSize(horizontal: false, vertical: true)
                        //                            .multilineTextAlignment(.center)
                    }
                }
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.black, lineWidth: 4)
                    )
                .frame(maxWidth: .infinity)
                .padding([.bottom])
                Text(selectedData.recipeTitles[0])
                    .font(.custom("OTRecipekoreaM", size: 15))
                    .bold()
                    .background(
                        Rectangle()
                            .fill(Color("TitleColor"))
                            .frame(width: 80)
                    )
                    .padding(.bottom)
                ForEach(1..<selectedData.recipeContents.count) { idx in
                    if idx < selectedData.recipeTitles.count {
                        Text(selectedData.recipeTitles[idx])
                            .font(.custom("OTRecipekoreaM", size: 16))
                            .bold()
                            .background(
                                Rectangle()
                                    .fill(Color("SemiTitleColor"))
                            )
                    }
                    VStack(alignment: .leading) {
                        ForEach(selectedData.recipeContents[idx], id: \.self) { content in
                            Text(content)
                                .font(.custom("OTRecipekoreaM", size: 15))
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding([.bottom])
                }
                ZStack {
                    VideoView(videoID: selectedData.recipeLink)
                        .frame(height: 200)
                        .cornerRadius(12)
                        .padding(.horizontal, 24)
                    
                }
                Spacer()
            }
            .listRowInsets(EdgeInsets())
            .background(Color("BackgroundColor"))
        }
        .listStyle(PlainListStyle())
        .background(Color("BackgroundColor"))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedData: .constant(Recipe("")))
    }
}
