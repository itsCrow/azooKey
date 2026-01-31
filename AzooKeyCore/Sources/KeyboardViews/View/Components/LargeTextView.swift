//
//  LargeTextView.swift
//  Keyboard
//
//  Created by ensan on 2020/09/21.
//  Copyright © 2020 ensan. All rights reserved.
//

import SwiftUI

@MainActor
struct LargeTextView<Extension: ApplicationSpecificKeyboardViewExtension>: View {
    private let text: String
    @Binding private var isViewOpen: Bool
    @EnvironmentObject private var variableStates: VariableStates
    @Environment(Extension.Theme.self) private var theme

    init(text: String, isViewOpen: Binding<Bool>) {
        self.text = text
        self._isViewOpen = isViewOpen
    }

    private var font: Font {
        Font.system(size: Design.largeTextViewFontSize(text, upsideComponent: variableStates.upsideComponent, orientation: variableStates.keyboardOrientation), weight: .bold, design: .default)
    }

    private var backgroundColor: Color {
        theme.magnifyViewFillColor?.color ?? Color.background
    }

    private var textColor: Color {
        theme.magnifyViewTextColor?.color ?? theme.textColor.color
    }

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: true, content: {
                Text(Design.fonts.forceJapaneseFont(text: text))
                    .font(font)
                    .foregroundColor(textColor)
            })
            Button {
                isViewOpen = false
            } label: {
                Image(systemName: "xmark")
            }
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity)
            .frame(width: nil, height: Design.keyboardScreenHeight(upsideComponent: variableStates.upsideComponent, orientation: variableStates.keyboardOrientation) * 0.15)
        }
        .background(backgroundColor)
        .frame(height: Design.keyboardScreenHeight(upsideComponent: variableStates.upsideComponent, orientation: variableStates.keyboardOrientation), alignment: .bottom)
    }
}
