//
//  TimeStepperView.swift
//  Focus
//
//  Created by sandor ferreira on 25/10/23.
//

import SwiftUI

struct TimeStepperView: View {
    @Binding var duration: Int
    var body: some View {
        HStack {
            Button {
                if duration >= 5 {
                    duration -= 5
                }
            } label: {
                Image(systemName: "minus.circle.fill")
                    .font(.title)
                    .foregroundStyle(Color.accentColor)
            }
            
            Text("\(duration):00")
                .font(.title)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.accentColor.opacity(0.2))
                )
            
            Button {
                if duration < 45 {
                    duration += 5
                }
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundStyle(Color.accentColor)
            }
            
            
        }
    }
}

#if DEBUG
#Preview {
    TimeStepperView(duration: .constant(10))
}
#endif
