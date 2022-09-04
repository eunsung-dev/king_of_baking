//
//  Recipe.swift
//  the_king_of_baking
//
//  Created by 최은성 on 2022/08/21.
//

import Foundation
import SwiftSoup
import SwiftUI

struct Recipe {
    var id = UUID()
    var recipeTitles: [String] = []  // 레시피 제목 ex. 제조공정, 충전물 제조 등
    var recipeContents: [[String]] = [[]]    // 레시피 내용
    var recipeIngredients: [String] = []  // 레시피 필요한 재료
    var recipeName: String = ""    // 빵 이름
    var recipeAbstract: String = ""    // 간략한 설명
    var recipeImage: String = ""    // 빵 사진
    var recipeLink: String = "" // 레시피 유튜브 링크
    // 웹 크롤링을 통해 url에 해당되는 레시피 정보 가져오기
    init(_ str: String) {
        let url = URL(string: str)
        if let url = url {
            do {
                let webString = try String(contentsOf: url)
                let document = try SwiftSoup.parse(webString)
                
                // MARK: - 제목 가져오기
                let titles = try document.getElementById("make")?.select("h4").array()
                for title in titles! {
                    let t = try title.select("h4").first()?.text()
                    self.recipeTitles.append(t!)
                }
                
                // MARK: - 내용 가져오기
                let contents = try document.getElementById("make")?.select("div").select("ol").array()
                for content in contents! {
                    let c = try content.select("li").array()
                    var arr: [String] = []
                    for j in c {
                        arr.append(try j.text())
                    }
                    self.recipeContents.append(arr)
                }
                
                // MARK: - 재료 가져오기
                let ingredients = try document.getElementById("ingredient")?.select("td").array()
                var combinedStr: String = ""
                for ingredient in ingredients! {
                    let c = try ingredient.text()
                    if !(c.contains("냉동생지") || c.contains("충전물") || c.contains("글레이즈버터") || c.contains("토핑") || c.contains("크림치즈 필링") || c.contains("적당량")) {
                        if c.filter({ $0.isNumber }).count == 0 {   // 숫자가 있으면 중량이라고 판단
                            combinedStr += c
                        } else {
                            combinedStr = combinedStr + " " + c
                            if c.filter({ $0.isNumber }).count == c.count {
                                combinedStr += "g"
                            }
                            self.recipeIngredients.append(combinedStr)
                            combinedStr = ""
                        }
                    }
                }
                
                // MARK: - 이름 가져오기
                let name = try document.getElementsByClass("info_area").select("h3").text()
                self.recipeName = name
                
                // MARK: - 요약 가져오기
                let abstract = try document.getElementsByClass("txt_area").select("p").first()?.text().components(separatedBy: "[ 제품 사양 ]")
                self.recipeAbstract = abstract?[0] ?? "nil"
                
                // MARK: - 이미지 가져오기
                let pngs = try document.getElementsByClass("info_area").select("img[src]")
                let stringImage = try pngs.attr("src").description
                self.recipeImage = "https://www.serveq.co.kr\(stringImage)"
                
                // MARK: - 유튜브 링크 가져오기
                let link = try document.getElementById("ingredient")?.select("a[href]").attr("href").description.components(separatedBy: "/")
                let index: Int = 3
                if link!.count > index {
                    self.recipeLink = link![3]
                }
                
            } catch let error {
                print(error)
            }
        }

    }
}
