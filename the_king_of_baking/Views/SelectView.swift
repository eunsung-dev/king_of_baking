//
//  SelectView.swift
//  the_king_of_baking
//
//  Created by 최은성 on 2022/08/21.
//

import SwiftUI

struct SelectView: View {
    var powders: [DataModel] = [DataModel(name: "박력 밀가루"), DataModel(name: "강력 밀가루"), DataModel(name: "중력 밀가루")]
    var butters: [DataModel] = [DataModel(name: "버터"), DataModel(name: "생크림")]
    var cheeses: [DataModel] = [DataModel(name: "크림치즈"), DataModel(name: "피자치즈"), DataModel(name: "분말치즈"), DataModel(name: "연유"), DataModel(name: "분유"), DataModel(name: "우유")]
    var nuts: [DataModel] = [DataModel(name: "견과류"), DataModel(name: "오트밀/씨앗"), DataModel(name: "코코넛/다이스/건조과일"), DataModel(name: "마지판")]
    var pigments: [DataModel] = [DataModel(name: "셰프마스터(반액상)"), DataModel(name: "셰프마스터(젤타입)"), DataModel(name: "윌튼"), DataModel(name: "아이싱칼라")]
    var sugars: [DataModel] = [DataModel(name: "설탕"), DataModel(name: "소금"), DataModel(name: "슈가파우더")]
    var jams: [DataModel] = [DataModel(name: "앙금"), DataModel(name: "잼"), DataModel(name: "필링")]
    var fruits: [DataModel] = [DataModel(name: "딸기"), DataModel(name: "블루베리"), DataModel(name: "바나나")]
    
    var doughs: [DataModel] = [DataModel(name: "크로와상"), DataModel(name: "사각시트"), DataModel(name: "바게트 도우"), DataModel(name: "식빵 도우"), DataModel(name: "먹물빵 볼도우"), DataModel(name: "스콘 생지"), DataModel(name: "단과자 볼도우"), DataModel(name: "시나몬휠 도우")]
    
    var toppings: [DataModel] = [DataModel(name: "하이슈가코트"), DataModel(name: "코코넛슈가")]
    
    @State var data: [String] = []
    
    @State var searchText: String = ""
    let rows = [GridItem(.flexible(maximum: 80))]
        
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("파우더").font(.custom("OTRecipekoreaM", size: 17))) {
                        ForEach(powders) { powder in
                            if powder.name.contains(searchText) || searchText.isEmpty {
                                DataRow(data: powder, selectedData: $data)
                            }
                        }
                    }
                    Section(header: Text("버터/생크림").font(.custom("OTRecipekoreaM", size: 17))) {
                        ForEach(butters) { butter in
                            if butter.name.contains(searchText) || searchText.isEmpty {
                                DataRow(data: butter, selectedData: $data)
                            }
                        }
                    }
                    Section(header: Text("치즈/연유/분유/기타유가공").font(.custom("OTRecipekoreaM", size: 17))) {
                        ForEach(cheeses) { cheese in
                            if cheese.name.contains(searchText) || searchText.isEmpty {
                                DataRow(data: cheese, selectedData: $data)
                            }
                        }
                    }
                    Section(header: Text("견과류/건조과일/마지판").font(.custom("OTRecipekoreaM", size: 17))) {
                        ForEach(nuts) { nut in
                            if nut.name.contains(searchText) || searchText.isEmpty {
                                DataRow(data: nut, selectedData: $data)
                            }
                        }
                    }
                    Section(header: Text("색소").font(.custom("OTRecipekoreaM", size: 17))) {
                        ForEach(pigments) { pigment in
                            if pigment.name.contains(searchText) || searchText.isEmpty {
                                DataRow(data: pigment, selectedData: $data)
                            }
                        }
                    }
                    Section(header: Text("설탕/소금").font(.custom("OTRecipekoreaM", size: 17))) {
                        ForEach(sugars) { sugar in
                            if sugar.name.contains(searchText) || searchText.isEmpty {
                                DataRow(data: sugar, selectedData: $data)
                            }
                        }
                    }
                    Section(header: Text("앙금/잼").font(.custom("OTRecipekoreaM", size: 17))) {
                        ForEach(jams) { jam in
                            if jam.name.contains(searchText) || searchText.isEmpty {
                                DataRow(data: jam, selectedData: $data)
                            }
                        }
                    }
                    Section(header: Text("과일").font(.custom("OTRecipekoreaM", size: 17))) {
                        ForEach(fruits) { fruit in
                            if fruit.name.contains(searchText) || searchText.isEmpty {
                                DataRow(data: fruit, selectedData: $data)
                            }
                        }
                    }
                    Section(header: Text("도우").font(.custom("OTRecipekoreaM", size: 17))) {
                        ForEach(doughs) { dough in
                            if dough.name.contains(searchText) || searchText.isEmpty {
                                DataRow(data: dough, selectedData: $data)
                            }
                        }
                    }
                    Section(header: Text("토핑").font(.custom("OTRecipekoreaM", size: 17))) {
                        ForEach(toppings) { topping in
                            if topping.name.contains(searchText) || searchText.isEmpty {
                                DataRow(data: topping, selectedData: $data)
                            }
                        }
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .listStyle(.sidebar)
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                NavigationLink(destination: {
                    MainView(selectedData: $data)
                }, label: {
                    Text("만들기")
                        .font(.custom("OTRecipekoreaM", size: 17))
                })
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ScrollViewReader { scrollView in
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: rows, spacing: 20) {
                                ForEach(data, id: \.self) {item in
                                    Button {
                                        if let firstIndex = data.firstIndex(of: item) {
                                            data.remove(at: firstIndex)
                                        }
                                    } label: {
                                        HStack {
                                            Spacer()
                                            Text("\(item)")
                                            Image(systemName: "xmark.circle.fill")
                                            Spacer()
                                        }
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 5)
                                        .foregroundColor(.black)
                                        .background(Color(.systemGray4))
                                        .cornerRadius(12)
                                    }
                                }
                                // 추가될 때마다 자동으로 마지막 원소로 이동하기 위해서
                                .onChange(of: data.count) { _ in
                                    if data.count != 0 {
                                        scrollView.scrollTo(data[data.endIndex - 1])
                                    }
                                }
                            }
                        }

                    }
                    
                    .frame(height: 50)
                }
            }
            .clipped()  // 스크롤 뷰에 있는 아이템이 navigation bar에 오지 않게 하기 위해서
        }
        .accentColor(.black)        
    }
}

struct SelectView_Previews: PreviewProvider {
    static var previews: some View {
        SelectView()
    }
}
