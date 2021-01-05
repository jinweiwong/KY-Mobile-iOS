import Foundation
import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            Image("Logo")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(15)
        }
    }
}
