//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 16 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `BlueThemeMainColor`.
    static let blueThemeMainColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "BlueThemeMainColor")
    /// Color `BlueThemeSubColor`.
    static let blueThemeSubColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "BlueThemeSubColor")
    /// Color `BlueThemeThirdColor`.
    static let blueThemeThirdColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "BlueThemeThirdColor")
    /// Color `CalendarHeaderColor`.
    static let calendarHeaderColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "CalendarHeaderColor")
    /// Color `CalendarTitleDefaultColor`.
    static let calendarTitleDefaultColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "CalendarTitleDefaultColor")
    /// Color `CalendarTitlePlaceHolderColor`.
    static let calendarTitlePlaceHolderColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "CalendarTitlePlaceHolderColor")
    /// Color `DiaryButtonDisabled`.
    static let diaryButtonDisabled = Rswift.ColorResource(bundle: R.hostingBundle, name: "DiaryButtonDisabled")
    /// Color `DrawerButtonColor`.
    static let drawerButtonColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "DrawerButtonColor")
    /// Color `GreenThemeMainColor`.
    static let greenThemeMainColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "GreenThemeMainColor")
    /// Color `GreenThemeSubColor`.
    static let greenThemeSubColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "GreenThemeSubColor")
    /// Color `GreenThemeThirdColor`.
    static let greenThemeThirdColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "GreenThemeThirdColor")
    /// Color `MainColor`.
    static let mainColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "MainColor")
    /// Color `MainViewSeparatorColor`.
    static let mainViewSeparatorColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "MainViewSeparatorColor")
    /// Color `TextFieldSeparatorColor`.
    static let textFieldSeparatorColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "TextFieldSeparatorColor")
    /// Color `WeekdayTextColor`.
    static let weekdayTextColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "WeekdayTextColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "BlueThemeMainColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func blueThemeMainColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.blueThemeMainColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "BlueThemeSubColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func blueThemeSubColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.blueThemeSubColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "BlueThemeThirdColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func blueThemeThirdColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.blueThemeThirdColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "CalendarHeaderColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func calendarHeaderColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.calendarHeaderColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "CalendarTitleDefaultColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func calendarTitleDefaultColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.calendarTitleDefaultColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "CalendarTitlePlaceHolderColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func calendarTitlePlaceHolderColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.calendarTitlePlaceHolderColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "DiaryButtonDisabled", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func diaryButtonDisabled(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.diaryButtonDisabled, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "DrawerButtonColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func drawerButtonColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.drawerButtonColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "GreenThemeMainColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func greenThemeMainColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.greenThemeMainColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "GreenThemeSubColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func greenThemeSubColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.greenThemeSubColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "GreenThemeThirdColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func greenThemeThirdColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.greenThemeThirdColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "MainColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func mainColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.mainColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "MainViewSeparatorColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func mainViewSeparatorColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.mainViewSeparatorColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "TextFieldSeparatorColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func textFieldSeparatorColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.textFieldSeparatorColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "WeekdayTextColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func weekdayTextColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.weekdayTextColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "BlueThemeMainColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func blueThemeMainColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.blueThemeMainColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "BlueThemeSubColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func blueThemeSubColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.blueThemeSubColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "BlueThemeThirdColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func blueThemeThirdColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.blueThemeThirdColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "CalendarHeaderColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func calendarHeaderColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.calendarHeaderColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "CalendarTitleDefaultColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func calendarTitleDefaultColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.calendarTitleDefaultColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "CalendarTitlePlaceHolderColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func calendarTitlePlaceHolderColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.calendarTitlePlaceHolderColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "DiaryButtonDisabled", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func diaryButtonDisabled(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.diaryButtonDisabled.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "DrawerButtonColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func drawerButtonColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.drawerButtonColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "GreenThemeMainColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func greenThemeMainColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.greenThemeMainColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "GreenThemeSubColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func greenThemeSubColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.greenThemeSubColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "GreenThemeThirdColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func greenThemeThirdColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.greenThemeThirdColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "MainColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func mainColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.mainColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "MainViewSeparatorColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func mainViewSeparatorColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.mainViewSeparatorColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "TextFieldSeparatorColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func textFieldSeparatorColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.textFieldSeparatorColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "WeekdayTextColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func weekdayTextColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.weekdayTextColor.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 8 images.
  struct image {
    /// Image `CalendarAsset`.
    static let calendarAsset = Rswift.ImageResource(bundle: R.hostingBundle, name: "CalendarAsset")
    /// Image `CalendarBackButton`.
    static let calendarBackButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "CalendarBackButton")
    /// Image `CalendarFrontButton`.
    static let calendarFrontButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "CalendarFrontButton")
    /// Image `DiarySideMenuButton`.
    static let diarySideMenuButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "DiarySideMenuButton")
    /// Image `DismissButton`.
    static let dismissButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "DismissButton")
    /// Image `LoginIllustration`.
    static let loginIllustration = Rswift.ImageResource(bundle: R.hostingBundle, name: "LoginIllustration")
    /// Image `MainIllustration`.
    static let mainIllustration = Rswift.ImageResource(bundle: R.hostingBundle, name: "MainIllustration")
    /// Image `ThemeButton`.
    static let themeButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "ThemeButton")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "CalendarAsset", bundle: ..., traitCollection: ...)`
    static func calendarAsset(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.calendarAsset, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "CalendarBackButton", bundle: ..., traitCollection: ...)`
    static func calendarBackButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.calendarBackButton, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "CalendarFrontButton", bundle: ..., traitCollection: ...)`
    static func calendarFrontButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.calendarFrontButton, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "DiarySideMenuButton", bundle: ..., traitCollection: ...)`
    static func diarySideMenuButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.diarySideMenuButton, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "DismissButton", bundle: ..., traitCollection: ...)`
    static func dismissButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.dismissButton, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "LoginIllustration", bundle: ..., traitCollection: ...)`
    static func loginIllustration(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.loginIllustration, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "MainIllustration", bundle: ..., traitCollection: ...)`
    static func mainIllustration(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.mainIllustration, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ThemeButton", bundle: ..., traitCollection: ...)`
    static func themeButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.themeButton, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.infoPlist` struct is generated, and contains static references to 1 localization keys.
    struct infoPlist {
      /// en translation: Someday
      ///
      /// Locales: en, ko
      static let cfBundleDisplayName = Rswift.StringResource(key: "CFBundleDisplayName", tableName: "InfoPlist", bundle: R.hostingBundle, locales: ["en", "ko"], comment: nil)

      /// en translation: Someday
      ///
      /// Locales: en, ko
      static func cfBundleDisplayName(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("CFBundleDisplayName", tableName: "InfoPlist", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "InfoPlist", preferredLanguages: preferredLanguages) else {
          return "CFBundleDisplayName"
        }

        return NSLocalizedString("CFBundleDisplayName", tableName: "InfoPlist", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
