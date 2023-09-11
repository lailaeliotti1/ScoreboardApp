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
                
                Button(action: {
                    if isClockRunning {
                        isClockRunning = false
                    } else {
                        isClockRunning = true
                        startClock()
                    }
                
                }) {
                    Text(isClockRunning ? "Game ON" : "Timeout")
                }
                
                
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
           if isClockRunning {
               stopClock()
           } else {
               startClock()
           }
           isClockRunning.toggle()
       }
    
    func startClock() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                timer.stopClock();
            }
        }
    }
    
    mutating func stopClock() {
        timer?.invalidate()
        timer = nil
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
