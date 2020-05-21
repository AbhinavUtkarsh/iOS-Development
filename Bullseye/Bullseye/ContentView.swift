//
//  ContentView.swift
//  Bullseye
//
//  Created by Abhinav Utkarsh on 16/05/20.
//  Copyright © 2020 Priyansh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    @State var sliderUpdated: Double = 50.0
    @State var Target: Int = Int.random(in: 1...100)
    @State var Score: Int = 0
    @State var roundTotal = 1
    let midnightBlue = Color(red: 0.0/255.0, green: 51.0 / 255.0, blue: 102.0/255.0)
    //@State var StartOver =
    
    struct LabelStyle: ViewModifier{
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.white)
           .modifier(Shadow())
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    struct ValueStyle: ViewModifier{
        func body(content: Content) -> some View{
            return content
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
            .modifier(Shadow())
        }
    }
    struct Shadow: ViewModifier{
        func body(content: Content) -> some View{
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    struct ButtonLargeTextStyle: ViewModifier{
        func body(content: Content) -> some View{
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    struct ButtonSmallTextStyle: ViewModifier{
        func body(content: Content) -> some View{
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
        var body: some View {
            VStack {
                Spacer()
                // Target Row
                HStack{
                    Text("Put the Bullseye as close as to :").modifier(LabelStyle())
                    Text("\(Target)").modifier(ValueStyle())
                }
                Spacer()
                // silder row
                HStack{
                    Text("1").modifier(LabelStyle())
                    Slider(value: self.$sliderUpdated, in: 1...100).accentColor(Color.green)
                    Text("100").modifier(LabelStyle())
                }
                Spacer()
                // Button row
                    Button(action: {
                        print("Button Pressed!")
                        self.alertIsVisible=true
                        
                    }) {
                        Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/).modifier(ButtonLargeTextStyle())
                    }.alert(isPresented: $alertIsVisible){() -> Alert in
                        let roundedValue: Int = Int(self.sliderUpdated.rounded())
                        return Alert(title: Text("\(alertTitle())"), message: Text("You guessed \(roundedValue).\n You Scored \(self.pointsForCurrentRound())"),dismissButton: .default(Text("Awesmome")){
                            self.Score = self.Score + self.pointsForCurrentRound()+self.Bonus()
                            self.Target = Int.random(in: 1...100)
                            self.roundTotal = self.roundTotal + 1
                            
                            })
                    }
                    .background(Image("Button")).modifier(Shadow())
                    Spacer()
                // Score row
                HStack{
                    Button(action: {
                        print("Startover Pressed!")
                        //self.StartOver = true
                        self.resetTheGame()
                    }){
                        HStack{
                            Image("StartOverIcon")
                        Text("Start Over").modifier(ButtonSmallTextStyle())
                    }
                    }.background(Image("Button")).modifier(Shadow())
                    Spacer()
                    Text("Score").modifier(LabelStyle())
                    
                    Text("\(Score)").modifier(ValueStyle())
                     Spacer()
                    Text("Round").modifier(LabelStyle())
                    Text("\(roundTotal)").modifier(ValueStyle())
                     Spacer()
                    NavigationLink(destination: AboutView()){
                        HStack{
                        Image("StartOverIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                        }
                    }.background(Image("Button")).modifier(Shadow())
                    
                }.padding(.bottom,20)
                
            }
            .background(Image("Background"), alignment: .center)
            .accentColor(midnightBlue)
        .navigationBarTitle("Bullseye")
        }
    func resetTheGame() {
        self.Score = 0
        self.roundTotal = 1
        self.sliderUpdated = 50.0
        self.Target = Int.random(in: 1...100)
    }
    func amountOf() -> Int{
        return abs(Int(self.sliderUpdated.rounded()) - self.Target)
    }
    func pointsForCurrentRound() -> Int{
        print("Diffrence of the Slider"+String(abs(Int(self.sliderUpdated.rounded()) - 100)))
        if amountOf() == 0{
            return 200
        }
        else{
            return 100 - amountOf() + Bonus()
        }
    }
    func Bonus()->Int{
        if amountOf() == 0{
            return 100
        }else if amountOf() == 1{
            return 50
        }else{
            return 0
        }
    }
    func alertTitle() -> String {
        let diff = amountOf()
        let title: String
        if diff == 0{
            title="Perfect You got a Bonus of 100 points"
        }else if diff < 2{
            title="Very close, Here is a 50 point Bonus"
        }else if diff < 5 {
            title="You almost had it"
        }else if diff <= 10{
            title="Not Bad"
        }else{
            title="Are you even trying?"
        }
        return title
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
        
    }
}
