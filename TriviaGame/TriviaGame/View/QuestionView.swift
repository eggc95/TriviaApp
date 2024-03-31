import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    @State private var timeRemaining = 30
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack(spacing: 40, content: {
            HStack {
                Text("Trivia Game")
                    .boldTitle()
                Spacer()
                Text("Timer left: \(timeRemaining)")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                Spacer()
                VStack {
                    Text("Current Score: \(triviaManager.score)")
                    Text("\(triviaManager.index + 1) out of \(triviaManager.length)").foregroundColor(.accentColor)
                }
            }
            
            ProgressBar(progress: triviaManager.progress)
            
            VStack(alignment: .leading, spacing: 20, content: {
                Text(triviaManager.question).font(.system(size: 20))
                    .bold()
                    .lineLimit(nil)
                
                ForEach(triviaManager.answerChoices, id: \.id) { answer in
                    AnswerRow(answer: answer)
                        .environmentObject(triviaManager)
                }
                
            })
            Button {
                triviaManager.goToNextQuestion()
                timeRemaining = 30
            } label: {
                PrimaryButton(text: "Next", background: triviaManager.answerSelected ? .accentColor : .gray)
            }
            .disabled(!triviaManager.answerSelected)
            
            Spacer()
            
        })
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar(.hidden)
        .onReceive(timer) { time in
            if timeRemaining > 0 {
                timeRemaining -= 1
                triviaManager.setTimerBonus(timer: timeRemaining)
            } else {
                triviaManager.goToNextQuestion()
            }
        }
        
    }
}

#Preview {
    QuestionView().preferredColorScheme(.dark)
        .environmentObject(TriviaManager())
}
