import UIKit
import FoundationExtension
import Logging

public class IconButton: UIButton, Logger {

	private var handler: Block!

	public init(_ image: UIImage, _ handler: @escaping Block) {
		self.handler = handler
		super.init(frame: .zero)
		commonInit(image: image)
		addTarget(self, action: #selector(tapped), for: .primaryActionTriggered)
	}

	public init(_ image: UIImage, _ builderProvider: @escaping () -> UIMenu.Builder) {
		super.init(frame: .zero)
		commonInit(image: image)
		if #available(iOS 14.0, *) {
			self.showsMenuAsPrimaryAction = true
			self.menu = builderProvider().buildMenu()
		} else {
			self.handler = { [weak self] in
				let sheet = builderProvider().buildSheet()
				sheet.show(over: self!)
			}
			addTarget(self, action: #selector(tapped), for: .primaryActionTriggered)
		}
	}

	private func commonInit(image: UIImage) {
		setImage(image, for: .normal)
		tintColor = .label
		contentVerticalAlignment = .top
		contentHorizontalAlignment = .right
		constrainWidth(toAtLeast: .tapHeight)
		constrainHeight(toAtLeast: .tapHeight)
		setContentHuggingPriority(.required, for: .horizontal)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@objc private func tapped() {
		handler()
	}
}

public class Button: UIButton {

	public enum Style {
		case standard(fill: Bool), destructive

		var background: UIColor {
			switch self {
			case .standard: return .systemBlue
			case .destructive: return .systemRed
			}
		}
	}

	private var handler: Block!

	public convenience init(
		_ title: String,
		_ style: Style = .standard(fill: true),
		_ handler: @escaping Block
	) {
		self.init(type: .system)
		self.handler = handler
		switch style {
		case .standard(fill: let fill) where !fill:
			setTitleColor(.label, for: .normal)
		default:
			setTitleColor(.white, for: .normal)
			setBackgroundImage(UIImage(style.background), for: .normal)
		}
		titleLabel?.font = .preferredFont(for: .body, with: .bold)
		setTitle(title, for: .normal)
		addTarget(self, action: #selector(tapped), for: .primaryActionTriggered)
		cornerRadius = .cornerRadiusDefault
		cornerCurve = .continuous
		clipsToBounds = true
		heightAnchor.constraint(greaterThanOrEqualToConstant: .tapHeight).isActive = true
	}

	@objc private func tapped() {
		handler()
	}
}

extension UIImage {

	convenience init(_ color: UIColor) {
		let size = CGSize(width: 1, height: 1)
		UIGraphicsBeginImageContext(size)
		let ctx = UIGraphicsGetCurrentContext()!
		ctx.setFillColor(color.cgColor)
		ctx.fill(CGRect(origin: .zero, size: size))
		self.init(cgImage: UIGraphicsGetImageFromCurrentImageContext()!.cgImage!)
		UIGraphicsEndImageContext()
	}
}
