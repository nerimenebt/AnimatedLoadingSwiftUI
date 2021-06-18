//
//  ContentView.swift
//  AnimatedLoading
//
//  Created by Nerimene on 19/5/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var offset: [CGSize] = Array(repeating: .zero, count: 3)
    @State var timer = Timer.publish(every: 4, on: .current, in: .common).autoconnect()
    @State var delayTime: Double = 0
    
    var locations: [CGSize] = [CGSize(width: 50, height: 0),
                               CGSize(width: 0, height: -50),
                               CGSize(width: -50, height: 0),
                               CGSize(width: 50, height: 50),
                               CGSize(width: 50, height: -50),
                               CGSize(width: -50, height: -50),
                               CGSize(width: 0, height: 50),
                               CGSize(width: 50, height: 0),
                               CGSize(width: 0, height: -50),
                               CGSize(width: 0, height: 0),
                               CGSize(width: 0, height: 0),
                               CGSize(width: 0, height: 0)]
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack() {
                HStack(spacing: 10) {
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 50, height: 50)
                        .offset(offset[0])
                }.frame(width: 50, alignment: .leading)
                HStack(spacing: 10) {
                    Circle()
                        .fill(Color.orange)
                        .frame(width: 50, height: 50)
                        .offset(offset[1])
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 50, height: 50)
                        .offset(offset[2])
                }
            }
        }.onAppear(perform: doSomeAnimation)
        .onReceive(timer, perform: { _ in
            delayTime = 0
            doSomeAnimation()
        })
    }
    
    func doSomeAnimation() {
        var tempOffsets: [[CGSize]] = []
        var currentSet: [CGSize] = []
        for item in locations {
            currentSet.append(item)
            if currentSet.count == 3 {
                tempOffsets.append(currentSet)
                currentSet.removeAll()
            }
        }
        if !currentSet.isEmpty {
            tempOffsets.append(currentSet)
            currentSet.removeAll()
        }
        for offset in tempOffsets {
            for item in offset.indices {
                doSomeAnimations(delay: .now() + delayTime, value: offset[item], index: item)
                delayTime += 0.2
            }
        }
    }
    
    func doSomeAnimations(delay: DispatchTime, value: CGSize, index: Int) {
        DispatchQueue.main.asyncAfter(deadline: delay) {
            withAnimation(Animation.easeInOut(duration: 0.3)) {
                offset[index] = value
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
