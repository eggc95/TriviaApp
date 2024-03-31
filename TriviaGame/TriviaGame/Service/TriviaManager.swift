import Foundation
import SwiftUI

class TriviaManager: ObservableObject {
    private(set) var trivia: [Question.Result] = []
    @Published private(set) var length = 0
    @Published private(set) var difficulty = Difficulty.easy
    @Published private(set) var category = 9
    
    @Published private(set) var index = 0
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []
    
    @Published private(set) var score = 0
    @Published private(set) var progress: CGFloat = 0.00
    
    @Published private(set) var answerSelected = false
    @Published private(set) var reachedEnd = false
    private(set) var timerBonus = 5
    

    func fetchTrivia() async {
        var urlEditable = "https://opentdb.com/api.php?amount=10"
        urlEditable += "&category=\(category)"
        urlEditable += "&difficulty=\(difficulty.rawValue)"
        guard let url = URL(string: urlEditable) else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(Question.self, from: data)

            DispatchQueue.main.async {
                self.index = 0
                self.score = 0
                self.progress = 0.00
                self.reachedEnd = false

                self.trivia = decodedData.results
                self.length = self.trivia.count
                self.setQuestion()
            }
        } catch {
            print("Error fetching trivia: \(error)")
        }
    }
    
    
    func goToNextQuestion() {
        timerBonus = 5
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            reachedEnd = true
            saveUserHighscore()
        }
    }
    
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double((index + 1)) / Double(length) * 350)

        if index < length {
            let currentTriviaQuestion = trivia[index]
            question = currentTriviaQuestion.formattedQuestion
            answerChoices = currentTriviaQuestion.answers
        }
    }
    
    func selectAnswer(answer: Answer) {
        answerSelected = true
        
        if answer.isCorrect {
            switch difficulty {
            case .easy:
                score += 1 * timerBonus
            case .medium:
                score += 2 * timerBonus
            case .hard:
                score += 3 * timerBonus
                
            }
        } else {
            if score - 2 >= 0 {
                score -= 2
            } else {
                score = 0
            }
        }
    }
    
    func setDifficulty(difficulty: Difficulty) {
        self.difficulty = difficulty
    }
    
    func setCategory(category: Categories) {
        self.category = CategoriesID.getRawValue(from: category.rawValue)
    }
    
    func setTimerBonus(timer: Int) {
        if timer >= 25 {
            timerBonus = 5
        } else if timer >= 20 {
            timerBonus = 4
        } else if timer >= 15 {
            timerBonus = 3
        } else if timer >= 10 {
            timerBonus = 2
        } else {
            timerBonus = 1
        }
    }
    
    func saveUserHighscore() {
        var highScores = UserDefaults.standard.array(forKey: "AllHighScores") as? [Int] ?? []
        
        if highScores.count < 10 {
            highScores.append(score)
        } else {
            if highScores.min() ?? 0 < score {
                if let minIndex = highScores.firstIndex(of: highScores.min()!) {
                    highScores.remove(at: minIndex)
                }
                highScores.append(score)
            }
        }
        UserDefaults.standard.set(highScores, forKey: "AllHighScores")
    }
}
