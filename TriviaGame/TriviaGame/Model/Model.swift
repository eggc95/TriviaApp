import Foundation

enum Categories: String, CaseIterable {
    case GK = "General Knowledge"
    case Books = "Entertainment: Books"
    case Film = "Entertainment: Film"
    case Music = "Entertainment: Music"
    case Musical = "Entertainment: Musicals & Theatres"
    case Television = "Entertainment: Television"
    case VideoGames = "Entertainment: Video Games"
    case BoardGames = "Entertainment: Board Games"
    case Nature = "Science & Nature"
    case Computers = "Science: Computers"
    case Maths = "Science Mathematics"
    case Mythology = "Mythology"
    case Sports = "Sports"
    case Geography = "Geography"
    case History = "History"
    case Politics = "Politics"
    case Art = "Art"
    case Celebrities = "Celebrities"
    case Animals = "Animals"
    case Vehicles = "Vehicles"
    case Comics = "Entertainment: Comics"
    case Gadgets = "Science: Gadgets"
    case Manga = "Entertainment: Japanese Anime & Manga"
    case Cartoon = "Entertainment: Cartoon & Animations"
}

enum CategoriesID : Int {
    case GK = 9
    case Books = 10
    case Film = 11
    case Music = 12
    case Musical = 13
    case Television = 14
    case VideoGames = 15
    case BoardGames = 16
    case Nature = 17
    case Computers = 18
    case Maths = 19
    case Mythology = 20
    case Sports = 21
    case Geography = 22
    case History = 23
    case Politics = 24
    case Art = 25
    case Celebrities = 26
    case Animals = 27
    case Vehicles = 28
    case Comics = 29
    case Gadgets = 30
    case Manga = 31
    case Cartoon = 32

    static func getRawValue(from value : String) -> Int {
        switch value {
        case "General Knowledge":
            return self.GK.rawValue
        case "Entertainment: Books":
            return self.Books.rawValue
        case "Entertainment: Film":
            return self.Film.rawValue
        case "Entertainment: Music":
            return self.Music.rawValue
        case "Entertainment: Musicals & Theatres":
            return self.Musical.rawValue
        case "Entertainment: Television":
            return self.Television.rawValue
        case "Entertainment: Video Games":
            return self.VideoGames.rawValue
        case "Entertainment: Board Games":
            return self.BoardGames.rawValue
        case "Science & Nature":
            return self.Nature.rawValue
        case "Science: Computers":
            return self.Computers.rawValue
        case "Science Mathematics":
            return self.Maths.rawValue
        case "Mythology":
            return self.Mythology.rawValue
        case "Sports":
            return self.Sports.rawValue
        case "Geography":
            return self.Geography.rawValue
        case "History":
            return self.History.rawValue
        case "Politics":
            return self.Politics.rawValue
        case "Art":
            return self.Art.rawValue
        case "Celebrities":
            return self.Celebrities.rawValue
        case "Animals":
            return self.Animals.rawValue
        case "Vehicles":
            return self.Vehicles.rawValue
        case "Entertainment: Comics":
            return self.Comics.rawValue
        case "Science: Gadgets":
            return self.Gadgets.rawValue
        case "Entertainment: Japanese Anime & Manga":
            return self.Manga.rawValue
        case "Entertainment: Cartoon & Animations":
            return self.Cartoon.rawValue
        default:
            return 9
        }
    }

}

enum Difficulty: String, CaseIterable {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
}

struct Question: Decodable {
    var results: [Result]
    
    struct Result: Decodable, Identifiable {
        var id: UUID {
            UUID()
        }
        let category: String
        let type: String
        var difficulty: String
        var question: String
        var correctAnswer: String
        var incorrectAnswers: [String]
        
        var formattedQuestion : AttributedString {
            do {
                return try AttributedString(markdown: question)
            } catch {
                print("Error formatting formattedQuestion")
                return ""
            }
        }
        var answers: [Answer] {
            do {
                let correct = [Answer(text: try AttributedString(markdown: correctAnswer), isCorrect: true)]
                let incorrects = try incorrectAnswers.map { answer in
                    Answer(text: try AttributedString(markdown: answer), isCorrect: false)
                }
                let allAnswer = correct + incorrects
                
                return allAnswer.shuffled()
                
            } catch {
                print("Error setting answers:\(error)")
                return []
            }
        }
    }
}

struct Score {
    var isCorrect: Bool = false
    var userOption: String = ""
    var question: String = ""
}

struct Answer: Identifiable {
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
}

