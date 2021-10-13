//
//  Themes.swift
//  diary
//
//  Created by 김부성 on 2021/08/30.
//

import RxSwift
import RxTheme
import Rswift
import UIKit

protocol Theme {
    var mainColor: UIColor { get }
    var subColor: UIColor { get }
    var thirdColor: UIColor { get }
    var diaryDisableColor: UIColor { get }
    var mainIllustration: UIImage { get }
    var systemWhiteColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var clearColor: UIColor { get }
    var clearButtonColor: UIColor { get }
    var tableViewCellColor: UIColor { get }
}

extension Theme {
    var diaryDisableColor: UIColor { R.color.diaryDisabledColor()! }
    var systemWhiteColor: UIColor { R.color.systemWhiteColor()! }
    var backgroundColor: UIColor { .systemBackground }
    var clearColor: UIColor { .clear }
    var clearButtonColor: UIColor { R.color.clearButtonColor()! }
    var tableViewCellColor: UIColor { R.color.tableViewCellColor()! }
}

struct GreenTheme: Theme {
    let mainColor: UIColor = R.color.greenThemeMainColor()!
    let subColor: UIColor = R.color.greenThemeSubColor()!
    let thirdColor: UIColor = R.color.greenThemeThirdColor()!
    let mainIllustration: UIImage = R.image.mainIconGreenTheme()!
}

struct BlueTheme: Theme {
    let mainColor: UIColor = R.color.blueThemeMainColor()!
    let subColor: UIColor = R.color.blueThemeSubColor()!
    let thirdColor: UIColor = R.color.blueThemeThirdColor()!
    let mainIllustration: UIImage = R.image.mainIconBlueTheme()!
}

enum ThemeType: ThemeProvider {
    case green, blue
    var associatedObject: Theme {
        switch self {
        case .green:
            return GreenTheme()
        case .blue:
            return BlueTheme()
        }
    }
}

let themeService = ThemeType.service(initial: .green)
func themed<T>(_ mapper: @escaping ((Theme) -> T)) -> Observable<T> {
  return themeService.attrStream(mapper)
}
