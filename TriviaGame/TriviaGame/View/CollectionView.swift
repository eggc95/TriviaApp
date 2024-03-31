import SwiftUI

struct CollectionView: View {
    
    @StateObject var triviaManager = TriviaManager()
    private var gridColumns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridColumns) {
                    ForEach(Categories.allCases, id: \.self) { category in
                        GeometryReader { geo in
                            NavigationLink {
                                DifficultyView(category: category).environmentObject(triviaManager)
//                                QuestionsView(category: category.rawValue, childCategory: category.getChild())
                            } label: {
                                categoryItem(category, size: geo.size.width)
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding()
            }
            .navigationTitle("Trivia App")
        }
    }
    
    private func categoryItem (_ category: Categories, size: Double) -> some View {
            VStack(alignment: .center, spacing: 10) {
                Image(systemName: category.icon)
                    .imageScale(.large)
                    .symbolRenderingMode(.palette)
                    .foregroundColor(Color(uiColor: .white))
                Text(category.rawValue)
                    .foregroundColor(Color(uiColor: .white))
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
                    .lineLimit(2)
                    .padding(.horizontal)
            }
            .frame(width: size, height: size)
            .background(Color.random)
            .cornerRadius(12)
    }
}

#Preview {
    CollectionView().preferredColorScheme(.dark)
}
