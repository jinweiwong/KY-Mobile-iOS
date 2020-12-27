//
//  ForgotPasswordView.swift
//  KYMobile
//
//  Created by Wong Jin Wei on 31/08/2020.
//  Copyright © 2020 Jin Wei & Faiz. All rights reserved.
//

import Foundation
import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var Email = ""
    @State private var StudentID = ""
    
    var body: some View {
        ZStack {
            
            Color("VeryLightGrey")
                .edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 80) {
                VStack (alignment: .leading, spacing: 30) {
                    
                    VStack (alignment: .leading, spacing: 8) {
                        Text("Forgot your password?")
                            .modifier(VeryLargeText(textColor: Color("Black")))
                        
                        Text("Enter your email and check your inbox")
                            .modifier(MediumText(textColor: Color("VeryDarkGrey")))
                    }.frame(width: UIScreen.main.bounds.size.width * 7/8, alignment: .leading)
                    
                    HStack (spacing: 15) {
                        VStack (spacing: 46) {
                            Image(systemName: "envelope")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 15)
                        }.frame(width: 20, alignment: .trailing)
                        
                        VStack (spacing: 30) {
                            VStack (spacing: 0) {
                                TextField("Enter your email", text: $Email)
                                    .frame(width: 300, height: 30)
                                
                                Divider()
                                    .frame(width: 300, height: 2)
                            }
                        }
                    }
                    
                    VStack (alignment: .leading, spacing: 15) {
                        VStack (spacing: 10) {
                            Button(action: {
                                print("Send Email")
                            }) {
                                Text("Send Email")
                            }.modifier(LargeButton(width: UIScreen.main.bounds.size.width * (7/8), height: 50, textColor: Color("White"), backgroundColor: Color("NormalBlue")))
                        }
                        
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color("Green"))
                            
                            Text("An email has been sent to trialemail12345@gmail.com")
                                .modifier(TinyText(textColor: Color("Green")))
                        }
                    }
                }
                
                //Divider
                HStack (spacing: 15) {
                    VStack { Divider()
                        .background(Color("DarkGrey"))
                    }.padding(0)
                    
                    Text("or")
                        .foregroundColor(Color("DarkGrey"))
                    
                    VStack { Divider()
                        .background(Color("DarkGrey"))
                    }.padding(0)
                }.padding(.horizontal, 25)
                
                VStack (alignment: .leading, spacing: 30) {
                    
                    VStack (alignment: .leading) {
                        Text("Enter your Student ID and check your inbox")
                            .modifier(MediumText(textColor: Color("VeryDarkGrey")))
                    }.frame(width: UIScreen.main.bounds.size.width * 7/8, alignment: .leading)
                    
                    HStack (spacing: 15) {
                        VStack (spacing: 46) {
                            Image(systemName: "grid")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 15)
                        }.frame(width: 20, alignment: .trailing)
                        
                        VStack (spacing: 30) {
                            VStack (spacing: 0) {
                                TextField("Enter your Student ID", text: $Email)
                                    .frame(width: 300, height: 30)
                                
                                Divider()
                                    .frame(width: 300, height: 2)
                            }
                        }
                    }
                    
                    VStack (alignment: .leading, spacing: 15) {
                        VStack (spacing: 10) {
                            Button(action: {
                                print("Send Email")
                            }) {
                                Text("Send Email")
                            }.modifier(LargeButton(width: UIScreen.main.bounds.size.width * (7/8), height: 50, textColor: Color("White"), backgroundColor: Color("NormalBlue")))
                        }
                        
                        HStack {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color("Red"))
                            
                            Text("Invalid Student ID")
                                .modifier(TinyText(textColor: Color("Red")))
                        }
                    }
                }
            }
        }.navigationBarTitle("Reset Password", displayMode: .inline)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForgotPasswordView()
        }
    }
}
