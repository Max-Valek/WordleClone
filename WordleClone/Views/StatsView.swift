//
//  StatsView.swift
//  WordleClone
//
//  Created by Max Valek on 6/28/23.
//

import SwiftUI

struct StatsView: View {
    
    @EnvironmentObject var dm: WordleDataModel
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            // x button
            xButton
            
            // title
            Text("STATISTICS")
                .font(.headline)
                .fontWeight(.bold)
            
            // stats row
            stats
            
            // graph label
            Text("GUESS DISTRIBUTION")
                .font(.headline)
                .fontWeight(.bold)
            
//            VStack(spacing: 5) {
//                ForEach(0..<5) { index in
//                    HStack {
//                        Text("\(index + 1)")
//                        if dm.currentStat.frequencies[index] == 0 {
//                            Rectangle()
//                                .fill(Color.wrong)
//                                .frame(width: 22, height: 20)
//                                .overlay(
//                                    Text("0")
//                                        .foregroundColor(.white)
//                                )
//                        } else {
//                            if let maxValue = dm.currentStat.frequencies.max() {
//                                Rectangle()
//                                    .fill((dm.tryIndex == index && dm.gameOver) ? Color.correct : Color.wrong)
//                                    .frame(width: CGFloat(dm.currentStat.frequencies[index] / CGFloat(maxValue) * 210), height: 20)
//                                    .overlay(
//                                        Text("\(dm.currentStat.frequencies[index])")
//                                            .foregroundColor(.white)
//                                            .padding(.horizontal, 5)
//                                    )
//                            }
//                        }
//
//                        Spacer()
//                    }
//                }
//            }
            
            if dm.gameOver {
                HStack {
                    Spacer()
                    Button {
                        dm.shareResult()
                    } label: {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Share")
                        }
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.correct)
                    }

                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 40)
        .frame(width: 320, height: 370)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.systemBackground))
        .padding()
        .shadow(color: .black.opacity(0.3), radius: 10)
        .offset(y: -70)
    }
}

extension StatsView {
    private var xButton: some View {
        HStack {
            Spacer()
            Button {
                withAnimation {
                    dm.showStats.toggle()
                }
            } label: {
                Text("X")
            }
            .offset(x: 20, y: 10)
        }
    }
    
    private var stats: some View {
        HStack(alignment: .top) {
            SingleStat(value: dm.currentStat.games, text: "Played")
            if dm.currentStat.games != 0 {
                SingleStat(value: Int(100 * dm.currentStat.wins / dm.currentStat.games), text: "Win %")
            }
            SingleStat(value: dm.currentStat.streak, text: "Current Streak")
                .fixedSize(horizontal: false, vertical: true)
            SingleStat(value: dm.currentStat.maxStreak, text: "Max Streak")
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct SingleStat: View {
    
    let value: Int
    let text: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.largeTitle)
            Text(text)
                .font(.caption)
                .frame(width: 50)
                .multilineTextAlignment(.center)
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(WordleDataModel())
    }
}
