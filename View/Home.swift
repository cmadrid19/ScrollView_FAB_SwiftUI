//
//  Home.swift
//  ScrollViewFloatActionButton
//
//  Created by Maxim Macari on 27/4/21.
//

import SwiftUI

struct Home: View {
    
    @State var scrollViewOffset: CGFloat = 0
    
    //getting start offset and elimination from current offset so that we will geet exact offset
    @State var startOffset: CGFloat = 0
    
    var body: some View {
        ScrollViewReader { proxyReader in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 25){
                    
                    ForEach(1...30, id: \.self){ index in
                        HStack(spacing: 15){
                            Circle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 60, height: 60)
                            
                            VStack(alignment: .leading, spacing: 8, content: {
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(height: 22)
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(height: 22)
                                    .padding(.trailing, 100)
                                
                                
                            })
                        }
                    }
                }
                .padding()
                .id("SCROLL_TO_TOP")
                
                //getting scrolview offset
                .overlay(
                    GeometryReader{ proxy -> Color in
                        
                        DispatchQueue.main.async {
                            
                            if startOffset == 0 {
                                self.startOffset = proxy.frame(in: .global).minY
                            }
                            let offset = proxy.frame(in: .global).minY
                            self.scrollViewOffset = offset - startOffset
                            print("\(self.scrollViewOffset)")
                        }
                        
                        return Color.clear
                    }
                )
            }
            .overlay(
                Button(action: {
                    withAnimation(.spring()){
                        proxyReader.scrollTo("SCROLL_TO_TOP", anchor: .top)
                    }
                }, label: {
                    
                    Image(systemName: "arrow.up")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.09), radius: 5, x: 5, y: 5)
                    
                })
                .padding(.trailing)
                .padding(.bottom, getSafeArea().bottom == 0 ? 12 : 0)
                .opacity(-scrollViewOffset > 450 ? 1 : 0)
                .animation(.easeInOut)
                
                
                ,alignment: .bottomTrailing
            )
        }
    }
}

extension View {
    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
