import SwiftUI

struct TriviaView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    
    var body: some View {
        NavigationStack {
            if triviaManager.reachedEnd {
                VStack(spacing: 20) {
                    Text("Trivia Game")
                        .boldTitle()
                    
                    Text("Congratulations, you completed the game! 🥳")
                    
                    Text("You scored \(triviaManager.score) out of \(triviaManager.length)")
                    
                    NavigationLink {
                        MainAppView()
                    } label: {
                        PrimaryButton(text: "Play Again?")
                    }
                    
                }
                .foregroundColor(Color("AccentColor"))
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                QuestionView()
                    .environmentObject(triviaManager)
                
            }
        }
        .toolbar(.hidden)
    }
}

#Preview {
    TriviaView().preferredColorScheme(.dark)
        .environmentObject(TriviaManager())
}
