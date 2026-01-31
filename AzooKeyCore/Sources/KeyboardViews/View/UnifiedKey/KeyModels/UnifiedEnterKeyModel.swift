import Foundation
import KeyboardThemes
import SwiftUI

struct UnifiedEnterKeyModel<Extension: ApplicationSpecificKeyboardViewExtension>: UnifiedKeyModelProtocol {
    // Qwertyでは小さめの文字、Flickでは既定サイズを使う。nilの場合はデフォルトサイズ。
    private let textSize: Design.Fonts.LabelFontSizeStrategy

    init(textSize: Design.Fonts.LabelFontSizeStrategy = .small) {
        self.textSize = textSize
    }

    func pressActions(variableStates: VariableStates) -> [ActionType] {
        switch variableStates.enterKeyState {
        case .complete:
            return [.enter]
        case .return:
            return [.input("\n")]
        }
    }

    func longPressActions(variableStates _: VariableStates) -> LongpressActionType {
        .none
    }

    func variationSpace(variableStates _: VariableStates) -> UnifiedVariationSpace { .none }

    private func specialTextColor<ThemeExtension: ApplicationSpecificKeyboardViewExtensionLayoutDependentDefaultThemeProvidable>(states: VariableStates, theme: ThemeData<ThemeExtension>) -> Color? {
        switch states.enterKeyState {
        case .complete:
            return nil
        case let .return(type):
            switch type {
            case .default:
                return nil
            default:
                if theme == ThemeExtension.native {
                    return .white
                } else {
                    return nil
                }
            }
        }
    }

    func label<ThemeExtension>(width: CGFloat, theme: ThemeData<ThemeExtension>, states: VariableStates, color: Color?) -> KeyLabel<Extension> where ThemeExtension: ApplicationSpecificKeyboardViewExtensionLayoutDependentDefaultThemeProvidable {
        let textColor = color ?? specialTextColor(states: states, theme: theme)

        switch states.tabManager.existentialTab() {
        case .flick_hira, .flick_abc, .flick_numbersymbols:
            // All flick keyboards: show return arrow icon
            return KeyLabel(.image("return.left"), width: width, textSize: textSize, textColor: textColor)
        case .qwerty_hira, .qwerty_abc, .qwerty_numbers, .qwerty_symbols:
            // All QWERTY keyboards: show "enter" text
            return KeyLabel(.text("enter"), width: width, textSize: textSize, textColor: textColor)
        default:
            // For other keyboards, use the original localized text
            let text = Design.language.getEnterKeyText(states.enterKeyState)
            return KeyLabel(.text(text), width: width, textSize: textSize, textColor: textColor)
        }
    }

    func backgroundStyleWhenUnpressed<ThemeExtension>(states: VariableStates, theme: ThemeData<ThemeExtension>) -> UnifiedKeyBackgroundStyleValue where ThemeExtension: ApplicationSpecificKeyboardViewExtensionLayoutDependentDefaultThemeProvidable {
        switch states.enterKeyState {
        case .complete:
            return (theme.specialKeyFillColor.color, theme.specialKeyFillColor.blendMode, theme.specialKeyFillColor.isGlass)
        case let .return(type):
            switch type {
            case .default:
                return (theme.specialKeyFillColor.color, theme.specialKeyFillColor.blendMode, theme.specialKeyFillColor.isGlass)
            default:
                if theme == ThemeExtension.default {
                    return (Design.colors.specialEnterKeyColor, .normal, false)
                } else if theme == ThemeExtension.native {
                    return (.accentColor, .normal, false)
                } else {
                    return (theme.specialKeyFillColor.color, theme.specialKeyFillColor.blendMode, theme.specialKeyFillColor.isGlass)
                }
            }
        }
    }

    func feedback(variableStates: VariableStates) {
        switch variableStates.enterKeyState {
        case .complete:
            KeyboardFeedback<Extension>.tabOrOtherKey()
        case let .return(type):
            switch type {
            case .default:
                KeyboardFeedback<Extension>.click()
            default:
                KeyboardFeedback<Extension>.tabOrOtherKey()
            }
        }
    }
}
