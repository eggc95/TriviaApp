import SwiftUI

struct TopScores: View {
    @State private var highScores: [Int] = []

    var body: some View {
        VStack {
            Text("High Scores")
                .font(.title)
                .padding()
            
            if highScores.isEmpty {
                Text("No high scores yet!")
            } else {
                List {
                    ForEach(highScores.sorted(by: >), id: \.self) { score in
                        Text("\(score)")
                    }
                }
            }
        }.onAppear {
            highScores = UserDefaults.standard.array(forKey: "AllHighScores") as? [Int] ?? []
        }
    }
}

struct TopScores_Previews: PreviewProvider {
    static var previews: some View {
        TopScores()
    }
}
