//
//  AboutView.swift
//  Bullseye
//
//  Created by Abhinav Utkarsh on 22/05/20.
//  Copyright © 2020 Priyansh. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    let beige = Color(red: 255.0/255.0, green: 214.0 / 255.0, blue: 179.0/255.0)
    var body: some View {
        Group{
        VStack{
            Text("🥳Bullseye🥳")
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .foregroundColor(Color.black)
                .padding(.bottom,20)
                .padding(.top,20)
            Text("My first iOS App")
                .lineLimit(nil)
            .font(Font.custom("Arial Rounded MT Bold", size: 16))
            .foregroundColor(Color.black)
            .padding(.leading,60)
            .padding(.trailing,60)
            .padding(.bottom,20)
        Text("💖Was created with love💖")
        Text("By Abhinav Utkarsh")
    }
        .navigationBarTitle("About Bullseye")
        .background(beige)

    }.background(Image("Background"))
    }
    

}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
        
    }
}
