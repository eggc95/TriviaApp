import SwiftUI

struct PrimaryButton: View {
    var text: String
    var background: Color = .accentColor
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .padding()
            .padding(.horizontal)
            .background(background)
            .cornerRadius(30)
            .shadow(radius: 10)
            .font(.headline)
    }
}

#Preview {
    PrimaryButton(text: "Next")
}
