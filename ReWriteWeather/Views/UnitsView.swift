//
//  UnitsView.swift
//  OpenWeather
//
//  Created by Георгий Борисов on 18.03.2024.
//

import SwiftUI

struct UnitsView: View {
    var scheme : ColorScheme
    @AppStorage("userTheme") private var userTheme:Theme = .systemDefault

    @Namespace private var animation
 
    var body: some View {
        
        VStack(spacing:15){
            
            Text("Choose your style")
                .font(.title2.bold())
                .padding(.top,25)
            Circle()
                .fill(userTheme.color(scheme).gradient)
                .frame(width: 150,height: 150)

            HStack(spacing:0){
                ForEach(Theme.allCases,id:\.rawValue){theme in
                    
                    Text(theme.rawValue)
                        .padding(.vertical,10)
                        .frame(width:100)
                        .background{
                            ZStack{
                                if userTheme == theme{
                                    Capsule()
                                        .fill(.themeBG)
                                        .matchedGeometryEffect(id: "ACTIVETAB", in:animation)
                                }
                            }.animation(.snappy, value:userTheme)
        
                        }.contentShape(.rect)
                        .onTapGesture{
                            userTheme = theme
                      
                        }
                }
            }.padding(3)
                .background(.primary.opacity(0.06),in:.capsule)
                .padding(.top,20)
            
        }
        .frame(maxWidth:.infinity,maxHeight:.infinity)
        .frame(height:410)
        .background(.themeBG)
        .clipShape(.rect(cornerRadius:30))
        .environment(\.colorScheme,scheme)


    }
    
}
#Preview {
    UnitsView(scheme: .dark)
}
