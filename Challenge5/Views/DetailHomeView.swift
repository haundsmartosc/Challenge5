import SwiftUI

struct DetailHomeView: View {
    @EnvironmentObject var userModel: AppState
    @State private var backgroundColor = Color.white
    @Binding var savedBackgroundColor: Color
    var body: some View {
        
        VStack {
            Spacer()
            Text("This is the Detail View")
                .font(.title)
                .fontWeight(.medium)
            
            
            Button(action: {
                backgroundColor = randomColor()
            }) {
                Text("Random Background Color")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(8)
            }

            Button(action: {
                savedBackgroundColor = backgroundColor
            }) {
                Text("Save and back to home")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
            }
            Spacer()
        }
        .padding(.horizontal)
        .background(backgroundColor)
        .edgesIgnoringSafeArea(.all)
    }
    
    func randomColor() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        
        return Color(red: red, green: green, blue: blue)
    }
}

