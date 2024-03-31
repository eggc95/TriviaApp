import SwiftUI

struct MainAppView: View {
    
    var body: some View {
        TabView {
            CollectionView()
                .tabItem {
                    Label("Collections", systemImage: "folder.fill")
                }
            TopScores()
                .tabItem {
                Label("High Score", systemImage: "clock.arrow.circlepath")
            }
        }.background(Color(.red))
    }
}

#Preview {
    MainAppView().preferredColorScheme(.dark)
}
