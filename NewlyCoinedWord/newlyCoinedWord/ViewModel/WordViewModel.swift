//
//  WordViewModel.swift
//  newlyCoinedWord
//
//  Created by meng on 2021/10/04.
//

import Foundation


class WordViewModel {
    let wordList: [WordInfo] = [
        WordInfo(word: "삼귀자", meaning: "연애를 시작하기 전 썸 단계!"),
        WordInfo(word: "스드메", meaning: "스튜디오 드레스 메이크업!"),
        WordInfo(word: "꾸안꾸", meaning: "꾸민듯 안꾸민듯"),
        WordInfo(word: "애빼시", meaning: "애교 빼면 시체"),
        WordInfo(word: "혼코노", meaning: "혼자서 코인 노래방~"),
        WordInfo(word: "갑통알", meaning: "갑자기 통장보니 알바 해야겠다"),
        WordInfo(word: "자만추", meaning: "소개팅이 아닌 자연스러운 만남 추구!"),
        WordInfo(word: "갈비", meaning: "갈수록 비호감 -_-"),
        WordInfo(word: "방구석여포", meaning: "사회에서는 매우 소심하지만, 인터넷이나 특정 집단에서만 강한 사람ㅋ"),
        WordInfo(word: "설참", meaning: "설명 참고..")
    ]
    
    func searchWordMeaning(at word: String) -> String? {
        let mean = self.wordList.first { $0.word == word }
        return mean?.meaning
    }
}
