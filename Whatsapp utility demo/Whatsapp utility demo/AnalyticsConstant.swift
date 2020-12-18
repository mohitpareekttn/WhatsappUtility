//
//  AnalyticsConstant.swift
//  Whatsapp utility demo
//
//  Created by MOHIT PAREEK on 18/12/20.
//  Copyright © 2020 MOHIT PAREEK. All rights reserved.
//

import UIKit

struct AnalyticsConstants {
        
    struct UserAttributes {
        static let DEVICE_PLATFORM = "DEVICE_PLATFORM"
        static let DEVICE_MODEL = "DEVICE_MODEL"
        static let OS_VERSION   = "OS_VERSION"
        static let DEVICE_MANUFACTURER = "DEVICE_MANUFACTURER"
    }
        
    struct EventKey {
        static let CUSTOM_MESSAGE_PAGE = "CUSTOM_MESSAGE_PAGE"
        static let COMPOSE_PAGE = "COMPOSE_PAGE"
        static let HISTORY_PAGE = "HISTORY_PAGE"
        static let SETTINGS_PAGE = "SETTINGS_PAGE"
        static let SEND_MESSAGE = "SEND_MESSAGE"
        static let SEND_VIA_WHATSAPP = "SEND_VIA_WHATSAPP"
        static let SEND_VIA_IPHONE_MESSGEAPP = "SEND_VIA_IPHONE_MESSGEAPP"
    }
    
    struct EventAttributes {
        static let PHONE_NUMBER = "PHONE_NUMBER"
        static let MESSAGE = "MESSAGE"
    }
}

public class AnalyticsUserAttributes : NSObject {
    class func devicePlatform() -> String { return AnalyticsConstants.UserAttributes.DEVICE_PLATFORM }
    class func deviceOSVersion() -> String { return AnalyticsConstants.UserAttributes.OS_VERSION }
    class func deviceModel() -> String { return AnalyticsConstants.UserAttributes.DEVICE_MODEL }
    class func deviceManufacturer() -> String { return AnalyticsConstants.UserAttributes.DEVICE_MANUFACTURER }
}

public class AnalyticsEventKey : NSObject {
    class func composePageOpened() -> String { return AnalyticsConstants.EventKey.COMPOSE_PAGE }
    class func historyPageOpened() -> String { return AnalyticsConstants.EventKey.HISTORY_PAGE }
    class func customMessagePageOpened() -> String { return AnalyticsConstants.EventKey.CUSTOM_MESSAGE_PAGE }
    class func settingsPageOpened() -> String { return AnalyticsConstants.EventKey.SETTINGS_PAGE }
    class func sendMessageButtonTapped() -> String { return AnalyticsConstants.EventKey.SEND_MESSAGE }
    class func sendViaWhatsapp() -> String { return AnalyticsConstants.EventKey.SEND_VIA_WHATSAPP }
    class func sendViaIphoneMessage() -> String { return AnalyticsConstants.EventKey.SEND_VIA_IPHONE_MESSGEAPP }
}


public class AnalyticsEventAttributes : NSObject {
    class func phoneNumber() -> String { return AnalyticsConstants.EventAttributes.PHONE_NUMBER }
    class func message() -> String { return AnalyticsConstants.EventAttributes.MESSAGE }
}

