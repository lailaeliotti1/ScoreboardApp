//
//  ContentView.swift
//  ScoreboardApp
//
//  Created by Laila Eliotti on 9/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isClockRunning = false
    @State private var timeRemaining = 600 //ten minutes in sec
    private var timer: Timer?
    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            VStack{
                Text("Scoreboard")
                    .foregroundColor(.gray)
                    .font(.largeTitle)
                    .padding()
                topScoreboard()
                displayClock()
                timerControlButton()
                
            }
        }
        .padding()
    }
    
    func topScoreboard() -> some View {
        return ZStack{
            Rectangle()
                .stroke(.blue, lineWidth: 2)
                .frame(width: 400, height: 300)
            HStack{
                Text("Home")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding([.bottom, .trailing], 225)
                
                
                Text("Away")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.leading, 25)
                    .padding(.bottom, 225)
            }
        }
    }
    
    func displayClock() -> some View {
           return Text("\(timeRemaining / 60):\(timeRemaining % 60)")
               .font(.largeTitle)
       }
    
    mutating func toggleTimer() {
           isClockRunning.toggle()
           
           if !isClockRunning {
               stopTimer() // Stop the timer when toggling to off
           }
       }
    
    mutating func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                stopTimer();
            }
        }
    }
    
    mutating func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    mutating func timerControlButton() -> some View {
            return Button(action: {
                toggleTimer()
            }) {
                Text(isClockRunning ? "Game ON" : "Timeout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
