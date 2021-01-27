import UIKit

public class SimpleLoadingView: UIView {

	public var isLoading: Bool = false {
		didSet { isLoading ? setLoading() : setNotLoading() }
	}

	private let spinner = UIActivityIndicatorView(style: .medium)

	public init() {
		super.init(frame: .zero)
		backgroundColor = .secondarySystemBackground
		center(subview: spinner)
		setNotLoading()
	}

	public required init?(coder: NSCoder) { fatalError() }

	private func setLoading() {
		spinner.startAnimating()
		isHidden = false
	}

	private func setNotLoading() {
		spinner.stopAnimating()
		isHidden = true
	}
}
