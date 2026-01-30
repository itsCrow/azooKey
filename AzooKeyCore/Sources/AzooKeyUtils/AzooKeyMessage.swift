//
//  AzooKeyMessage.swift
//  azooKey
//
//  Created by β α on 2023/07/22.
//  Copyright © 2023 DevEn3. All rights reserved.
//

import Foundation
import KeyboardViews

public enum MessageIdentifier: String, CaseIterable, MessageIdentifierProtocol {
    case mock = "mock_alert_2022_09_16_03"
    case ver3_0_zenzai_introduction = "ver3.0_zenzai_introduction"
    case iOS18_4_new_emoji = "iOS_18_4_new_emoji_commit"                    // MARK: frozen
    case iOS17_4_new_emoji = "iOS_17_4_new_emoji_commit"                    // MARK: frozen
    case iOS16_4_new_emoji = "iOS_16_4_new_emoji_commit"                    // MARK: frozen
    case ver1_9_user_dictionary_update = "ver1_9_user_dictionary_update_release" // MARK: frozen
    case ver2_1_emoji_tab = "ver2_1_emoji_tab"

    // MARK: 過去にプロダクションで用いていたメッセージID
    // ver1_9_user_dictionary_updateが実行されれば不要になるので、この宣言は削除
    // case ver1_5_update_loudstxt = "ver1_5_update_loudstxt"           // MARK: frozen
    // iOS16_4_new_emojiが実行されれば不要になるので、これらの宣言は削除
    // case iOS14_5_new_emoji = "iOS_14_5_new_emoji_fixed_ver_1_6_1"    // MARK: frozen
    // case iOS15_4_new_emoji = "iOS_15_4_new_emoji"                    // MARK: frozen
    // 新機能の紹介も削除
    // case liveconversion_introduction = "liveconversion_introduction" // MARK: frozen
    // case ver1_8_autocomplete_introduction = "ver1_8_autocomplete_introduction" // MARK: frozen

    public var key: String {
        self.rawValue + "_status"
    }

    public var needUsingContainerApp: Bool {
        switch self {
        case .ver1_9_user_dictionary_update, .ver2_1_emoji_tab:
            return true
        case .iOS18_4_new_emoji, .iOS17_4_new_emoji, .iOS16_4_new_emoji, .mock, .ver3_0_zenzai_introduction:
            return false
        }
    }

    public var id: String {
        self.rawValue
    }
}

public enum AzooKeyMessageProvider: ApplicationSpecificKeyboardViewMessageProvider {
    public typealias MessageID = MessageIdentifier

    public static var userDefaults: UserDefaults { UserDefaults(suiteName: SharedStore.appGroupKey)! }

    public static var messages: [MessageData<MessageIdentifier>] {
        []
    }
}

public extension MessageManager where ID == MessageIdentifier {
    @MainActor init() {
        self.init(necessaryMessages: AzooKeyMessageProvider.messages, userDefaults: UserDefaults(suiteName: SharedStore.appGroupKey)!)
    }
}
