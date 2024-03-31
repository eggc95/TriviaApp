import SwiftUI

struct DifficultyView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    let category: Categories
    var body: some View {
        
        NavigationStack{
            VStack(alignment: .leading, spacing: 20, content: {
                
                Text("Choose your difficulty.")
                    .font(.title3)
                
                Text("Current: Difficulty: \(triviaManager.difficulty)")
                
                ForEach(Difficulty.allCases, id: \.self) { difficulty in
                    Button  {
                        triviaManager.setDifficulty(difficulty: difficulty)
                        triviaManager.setCategory(category: self.category)
                        Task.init {
                            await triviaManager.fetchTrivia()
                        }
                    } label: {
                        PrimaryButton(text: difficulty.rawValue)
                    }
                }
                
                NavigationLink {
                    TriviaView().environmentObject(triviaManager)
                } label: {
                    PrimaryButton(text: "Next")
                }
                

            })
        }
    }
}

struct DifficultyView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyView(category: Categories.GK).preferredColorScheme(.dark)
            .environmentObject(TriviaManager())
    }
}
