import UIKit
import FoundationExtension

public protocol FloatConvertable {

	init(_ float: Float)
	var floatValue: Float { get }
}

extension FloatConvertable where Self: BinaryInteger {

	public var floatValue: Float { Float(self) }
}

extension Int: FloatConvertable {}

public final class Slider<T: FloatConvertable>: UISlider {

	public var formattedValue: T {
		get {
			T(value)
		}
		set {
			value = newValue.floatValue
		}
	}

	public var onValueChanged: Closure<T>
	public var onTouchUp: Closure<T>
	private let increments: Float

	public init(
		_ range: ClosedRange<Float> = 0 ... 100,
		increments: Float = 1,
		minimumTrackTintColor: UIColor = .systemGreen,
		onValueChanged: @escaping Closure<T> = { _ in },
		onTouchUp: @escaping Closure<T> = { _ in }
	) {
		self.increments = increments
		self.onValueChanged = onValueChanged
		self.onTouchUp = onTouchUp
		super.init(frame: .zero)
		self.minimumTrackTintColor = minimumTrackTintColor
		minimumValue = range.lowerBound
		maximumValue = range.upperBound
		addTarget(self, action: #selector(valueChanged), for: [.valueChanged])
		addTarget(self, action: #selector(touchUp), for: [.touchUpOutside, .touchUpInside])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@objc private func touchUp() {
		onTouchUp(T(value))
	}

	@objc private func valueChanged() {
		value = ceil(value / increments) * increments
		onValueChanged(T(value))
	}
}

public final class TitledSwitch: UIView {

	public var title: String? {
		get { label.text }
		set { label.text = newValue }
	}

	private let label: UILabel
	private let toggle: Switch

	public var isOn: Bool {
		get { toggle.isOn }
		set { toggle.isOn = newValue }
	}

	public var handler: Closure<Bool> {
		get { toggle.handler }
		set { toggle.handler = newValue }
	}

	public init(_ title: String? = nil, _ handler: @escaping Closure<Bool> = { _ in }) {
		self.label = UILabel(.body, title, numberOfLines: 1)
		self.toggle = Switch(handler)
		super.init(frame: .zero)
		let stack = UIStackView(
			label,
			toggle,
			axis: .horizontal
		)
		pin(subview: stack)
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	public func setAnimated(isOn: Bool) { toggle.setOn(isOn, animated: true) }
}

public final class Switch: UISwitch {

	public var handler: Closure<Bool>

	public init(
		_ handler: @escaping Closure<Bool>
	) {
		self.handler = handler
		super.init(frame: .zero)
		addTarget(self, action: #selector(actionTriggered), for: [.primaryActionTriggered])
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	@objc private func actionTriggered() {
		handler(isOn)
	}
}
