import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ViewModel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    
    @State private var homeScore = 0
    @State private var awayScore = 0

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            topScoreboard()
                .padding()
            Spacer()
        }
    }
    
    func topScoreboard() -> some View {
        return ZStack{
            VStack {
                HStack{
                    VStack {
                        Text("Home")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                        Text("\(homeScore)")
                            .font(.title)
                            .foregroundColor(.white)
                        Button(action: {
                            homeScore += 1
                        }) {
                            Text("Increase Home Score")
                                .foregroundColor(.red)
                        }
                    }
                        .frame(width: 125, height: 200)
                        .background(Color.blue)
                        .cornerRadius(20)
                    
                        
                    
                    displayTimer()
                    
                        VStack {
                            Text("Away")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                            Text("\(awayScore)")
                                .font(.title)
                                .foregroundColor(.white)
                        
                            Button("Increase Away Score") {
                                awayScore += 1
                            }
                        }
                        .frame(width: 125, height: 200)
                        .background(Color.red)
                        .cornerRadius(20)
        
                }
                startStopButton()
            }
        }
    }
    
    func displayTimer() -> some View {
        VStack{
            Text("\(vm.time)")
                .font(.system(size: 70, weight: .medium, design: .rounded))
                .padding()
                .frame(width: width)
                .background(.thinMaterial)
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 4))
                .alert("Times up!", isPresented: $vm.showingAlert){
                    Button("Continue", role: .cancel){
                        //may add a notification later
                    }
                }
            Slider(value: $vm.minutes, in: 1...10, step: 1)
                .disabled(vm.isActive)
                .animation(.easeOut, value: vm.minutes)
        }
        .onReceive(timer) { _ in
            vm.updateCountdown()}
    }
    
    func startStopButton() -> some View {
        HStack(spacing: 50) {
            Button("Start") {
                vm.start(minutes: vm.minutes)
            }
            Button("Reset", action: vm.reset)
                .tint(.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
