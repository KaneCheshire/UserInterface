import UIKit
import Combine

open class BaseViewController: UIViewController {

	public var cancellables: Set<AnyCancellable> = []

	public init() {
		super.init(nibName: nil, bundle: nil)
	}

    @available(*, unavailable)
    convenience public required init?(coder: NSCoder) { fatalError("Unavailable") }

	open override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
	}
}

open class BaseNavController: UINavigationController {

	public override init(rootViewController: UIViewController) {
		super.init(rootViewController: rootViewController)
		navigationBar.prefersLargeTitles = true
		additionalSafeAreaInsets.bottom = .defaultPeekHeight
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
