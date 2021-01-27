import UIKit

public extension UIAlertController {

	func show(over context: UIViewController) {
		context.present(self, animated: true)
	}

	func show(over context: UIView) {
		show(over: context.window!.rootViewController!)
	}
}
