//
//  AuthCodeView.swift
//  Lightek
//
//  Created by Marlon on 12/5/24.
//

import SwiftUI

struct AuthCodeView: View {
    @State private var timeRemaining = 60
    @State private var timerIsActive = false
    @State private var resendCodeActive = false
    // State variables for the four text fields
        @State private var field1: String = ""
        @State private var field2: String = ""
        @State private var field3: String = ""
        @State private var field4: String = ""
    
    // Boolean state to check if all fields are filled
        @State private var allFieldsFilled: Bool = false
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                Spacer().frame(height:20)
                Text("Enter Authentication Code").foregroundColor(.white).font(.system(size: 24))
                    .padding(.bottom,4)
                Text("We just sent 4-digit code to +91 ***** ***18, enter it bellow: ").foregroundColor(.gray).font(.system(size: 14))
                Spacer().frame(height:50)
                HStack{
                    // TextField 1
                                    TextField("", text: $field1)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 56, height: 56)
                                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.gray, lineWidth: 1))
                                        .padding(.leading, 50)
                                        .onChange(of: field1) { _ in checkFields() }

                                    // TextField 2
                                    TextField("", text: $field2)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 56, height: 56)
                                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.gray, lineWidth: 1))
                                        .onChange(of: field2) { _ in checkFields() }

                                    // TextField 3
                                    TextField("", text: $field3)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 56, height: 56)
                                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.gray, lineWidth: 1))
                                        .onChange(of: field3) { _ in checkFields() }

                                    // TextField 4
                                    TextField("", text: $field4)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 56, height: 56)
                                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.gray, lineWidth: 1))
                                        .onChange(of: field4) { _ in checkFields() }
                }
                Spacer().frame(height:60)
                
                Group{Text("Code expires in : \(timeRemaining)").foregroundColor(.gray)
                    .padding(.bottom,8)
                    Text("Resend code").foregroundColor(resendCodeActive ? .yellow : .gray)
                Spacer().frame(height:330)
                RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(allFieldsFilled ? .yellow : .gray)
                    //.stroke(Color.gray, lineWidth: 1) // Add a light gray stroke
                    .frame(width: UIScreen.main.bounds.width - 20, height:62).overlay(Text("Verify").foregroundColor(.black))
                    }
                Spacer().onAppear{
                    startTimer()
                }
            }
            
        }
    }
    
    // Timer function to decrement timeRemaining every second
        func startTimer() {
            timerIsActive = true
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timer.invalidate() // Stop the timer when it reaches 0
                    timerIsActive = false
                    resendCodeActive.toggle()
                }
            }
        }
    
    // Function to check if all text fields are filled
        private func checkFields() {
            allFieldsFilled = !field1.isEmpty && !field2.isEmpty && !field3.isEmpty && !field4.isEmpty
        }
}

struct AuthCodeView_Previews: PreviewProvider {
    static var previews: some View {
        AuthCodeView()
    }
}
