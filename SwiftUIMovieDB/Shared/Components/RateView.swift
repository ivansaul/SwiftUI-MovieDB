//
//  RateView.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/24/24.
//
//  https://github.com/ivansaul
//

import SwiftUI

struct RateView: View {
    let rate: Double
    var body: some View {
        HStack(spacing: 1) {
            Image(systemName: "star.fill")
                .font(.caption2)
            Text(rate.asNumberString(decimals: 1))
                .textStyle(.h6(color: .theme.secondary.orange, weight: .semibold))
        }
        .foregroundStyle(Color.theme.secondary.orange)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.black.opacity(0.7).blur(radius: 2))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    RateView(rate: 4.72)
}
