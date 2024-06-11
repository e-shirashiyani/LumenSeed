//
//  TagView.swift
//  LumenSeed
//
//  Created by e.shirashiyani on 4/17/24.
//

import SwiftUI

struct TagView: View {
    var tag: Tag
    var onDelete: (Tag) -> Void

    var body: some View {
        HStack(spacing: 6) {
            Text(tag.name)
                .foregroundColor(Color(hex: tag.color))
                .font(.system(size: 16))
                .padding(.leading, 10)

            Button(action: { onDelete(tag) }) {
                Image(systemName: "xmark")
                    .resizable()
                    .foregroundColor(Color(hex: tag.color))
                    .frame(width: 10, height: 10)
            }
            .padding(.horizontal, 3)
            .padding(.trailing, 8)
        }
        .padding(.vertical, 6)
        .background(
            Capsule()
                .foregroundColor(Color(hex: tag.color)?.opacity(0.2))
        )
    }
}
//#Preview {
//    TagView(tag: Tag(id: UUID(), name: "work", color: .cyan))
//}
