import Foundation
import SwiftUI

// This page is not really important and can be done away with.
// Used for standardising the buttons and texts throughout the app.

// Large Buttons like those used in the Authentication page
struct LargeButton: ViewModifier {
    var width: CGFloat
    var height: CGFloat
    var textColor: Color?
    var backgroundColor: Color?
    
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height)
            .foregroundColor(textColor)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}

struct Title: ViewModifier {
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 40))
            .foregroundColor(textColor)
    }
}

struct VeryLargeText: ViewModifier {
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 35))
            .foregroundColor(textColor)
    }
}

struct LargeText: ViewModifier {
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 30))
            .foregroundColor(textColor)
    }
}


struct MediumText: ViewModifier {
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22))
            .foregroundColor(textColor)
    }
}


struct SmallText: ViewModifier {
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18))
            .foregroundColor(textColor)
    }
}


struct TinyText: ViewModifier {
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13))
            .foregroundColor(textColor)
    }
}


//struct Elements_View: View {
//    var body: some View {
//        VStack (spacing: 20) {
//            Button("Sign Up") {
//                print("yes")
//            }
//            .modifier(LargeButton(width: UIScreen.main.bounds.size.width * (7/8), height: 50, textColor: Color("White"), backgroundColor: Color("NormalBlue")))
//
//            Text("Title")
//                .modifier(Title(textColor: Color("Black")))
//
//            Text("Very Large Text")
//                .modifier(VeryLargeText(textColor: Color("Black")))
//
//            Text("Large Text")
//                .modifier(LargeText(textColor: Color("Black")))
//
//            Text("Medium Text")
//                .modifier(MediumText(textColor: Color("Black")))
//
//            Text("""
//            KY Mobile is your pocket companion for all things KYUEM.  An easy-to-use app that's lite on your pocket that puts information on your fingertips, featuring essential information and tools.
//
//            Student features allow access to essential campus life related information on the fly, including access to student resources, reserving bicycles, find a tutor,  and improved welfare!
//
//            KYUEM Sdn. Bhd. Developers
//            """)
//                .modifier(SmallText(textColor: Color("Black")))
//
//            Text("Tiny Text")
//                .modifier(TinyText(textColor: Color("Black")))
//
//
//        }
//    }
//}
//
//
//struct Elements_Previews: PreviewProvider {
//    static var previews: some View {
//        Elements_View()
//    }
//}

