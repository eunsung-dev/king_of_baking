//
//  PossibleView.swift
//  the_king_of_baking
//
//  Created by 최은성 on 2022/08/21.
//

import SwiftUI
import SwiftSoup
import CachedAsyncImage

struct PossibleView: View {
    @State var recipes: [Recipe] = []
    
    @Binding var selectedData: [String]
    @State var isPresented: Bool = false
    @State var selectedRecipe: Recipe = Recipe("")
    var body: some View {
        List(recipes, id: \.id) { recipe in
            if compare(selectedData,Array(recipe.recipeIngredients)) >= 0.3 { // 보유한 재료와 레시피의 재료를 비교
                HStack {
                    CachedAsyncImage(url: URL(string: recipe.recipeImage)) { phase in
                        
                        switch phase {
                                case .success(let image):
                                    image
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .scaledToFit()
                                    .padding([.leading,.top,.bottom])

                                case .failure:

                                    //Call the AsynchImage 2nd time - when there is a failure. (I think you can also check NSURLErrorCancelled = -999)
                                    AsyncImage(url: URL(string: recipe.recipeImage)) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .frame(width: 80, height: 80)
                                                .scaledToFit()
                                                .padding([.leading,.top,.bottom])
                                        } else{
                                            Image(systemName: "xmark.octagon")
                                        }
                                    }
                        case .empty:
                            ProgressView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                    VStack(alignment: .leading) {
                        Text(recipe.recipeName)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(nil)
                            .font(.custom("OTRecipekoreaM", size: 15))
                            .padding(.bottom, 0.1)
                        Text(recipe.recipeAbstract)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(nil)
                            .font(.custom("OTRecipekoreaM", size: 12))
                    }
                    .padding()
                    Spacer()
                }
                .listRowBackground(Color("BackgroundColor"))
                .contentShape(Rectangle())
                .onTapGesture(perform: {
                    self.isPresented.toggle()
                    self.selectedRecipe = recipe
                })
                .listRowSeparator(.hidden)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                .sheet(isPresented: $isPresented) {
                    DetailView(selectedData: $selectedRecipe)
                }
            }
        }
        .listStyle(PlainListStyle())
        .background(Color("BackgroundColor"))
        .onAppear {
            for idx in 1..<2 {
                let links = fetchPage("https://www.serveq.co.kr/recipe/BAK/recipe_list?page=\(idx)&PAGESIZE=12&SORTCOL=&SORTDIR=&SEL_R_CATE_CODE=BAK001&SEARCH_COL=&SEARCH_KEYWORD=")
                for link in links {
                    recipes.append(Recipe("https://www.serveq.co.kr/\(link)"))
                }
            }
        }

    }
    
    // MARK: - 비교 함수
    // 내가 가지고 있는 재료와 레시피에 필요한 재료를 비교하는 함수
    func compare(_ myIngredients: [String], _ recipeIngredients: [String]) -> Double {
        var percent: Double = 0.0
        var correct: Int = 0
        for i in myIngredients {
            for j in recipeIngredients {
                if j.contains(i) {
                    correct += 1
                    break
                }
            }
        }
        percent = Double(correct) / Double(recipeIngredients.count)
        return percent
    }
    
    // MARK: - 페이지 단위로 fetch
    func fetchPage(_ str: String) -> [String] {
        var fetchedLinks: [String] = []
        let url = URL(string: str)
        if let url = url {
            do {
                let webString = try String(contentsOf: url)
                let document = try SwiftSoup.parse(webString)

                let links = try document.getElementsByClass("result_list").select("a[href]").array()
                for link in links {
                    let l = try link.attr("href")
                    fetchedLinks.append(l)
                }
                
            } catch let error {
                print(error)
            }
        }
        return fetchedLinks
    }
}

struct PossibleView_Previews: PreviewProvider {
    static var previews: some View {
        PossibleView(selectedData: .constant([""]))
    }
}
