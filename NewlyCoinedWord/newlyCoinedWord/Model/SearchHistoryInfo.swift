//
//  SearchHistoryInfo.swift
//  newlyCoinedWord
//
//  Created by meng on 2021/10/04.
//

class SearchHistoryInfo{
    
    var wordList = ["스드메", "자만추", "방구석여포", "갈비"]
    
    func setWordList(with word: String) -> [String]{
        wordList.removeLast()
        wordList.insert(word, at: 0)
        return wordList
    }
}
