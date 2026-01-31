import Foundation
import KeyboardThemes
import SwiftUI

struct QwertySpaceKeyModel<Extension: ApplicationSpecificKeyboardViewExtension>: UnifiedKeyModelProtocol {
    func pressActions(variableStates _: VariableStates) -> [ActionType] {
        [.input(" ")]
    }
    func longPressActions(variableStates _: VariableStates) -> LongpressActionType {
        .init(start: [.setCursorBar(.toggle)])
    }
    func variationSpace(variableStates _: VariableStates) -> UnifiedVariationSpace {
        .none
    }

    func label<ThemeExtension>(width: CGFloat, theme _: ThemeData<ThemeExtension>, states: VariableStates, color: Color?) -> KeyLabel<Extension> where ThemeExtension: ApplicationSpecificKeyboardViewExtensionLayoutDependentDefaultThemeProvidable {
        // Use "space" for all QWERTY keyboards for consistency
        return KeyLabel(.text("space"), width: width, textSize: .small, textColor: color)
    }

    func backgroundStyleWhenUnpressed<ThemeExtension>(states _: VariableStates, theme: ThemeData<ThemeExtension>) -> UnifiedKeyBackgroundStyleValue where ThemeExtension: ApplicationSpecificKeyboardViewExtensionLayoutDependentDefaultThemeProvidable {
        (theme.normalKeyFillColor.color, theme.normalKeyFillColor.blendMode, theme.normalKeyFillColor.isGlass)
    }
    func feedback(variableStates _: VariableStates) {
        KeyboardFeedback<Extension>.click()
    }
}
