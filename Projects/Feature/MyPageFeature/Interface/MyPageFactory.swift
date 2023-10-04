// This is for Tuist
import UIKit

public protocol MyPageFactory {
    func makeView() -> UIViewController
}

public protocol MyPageContentFactory {
    func makeView() -> UIViewController
}
