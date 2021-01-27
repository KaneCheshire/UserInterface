import UIKit
import FoundationExtension

public final class PanGesture: UIPanGestureRecognizer {

	private let onStateChanged: Closure<State>

	public init(_ onStateChanged: @escaping Closure<State>) {
		self.onStateChanged = onStateChanged
		super.init(target: nil, action: nil)
		addTarget(self, action: #selector(on))
	}

	@objc private func on(_ gesture: UIPanGestureRecognizer) {
		let velocity = gesture.velocity(in: nil)
		let translation = gesture.translation(in: nil)
		switch gesture.state {
		case .began, .changed, .possible:
			onStateChanged(.panning(translation: translation, velocity: velocity))
		case .ended, .failed, .cancelled:
			onStateChanged(.stopped(translation: translation, velocity: velocity))
		@unknown default: break
		}
	}
}

public extension PanGesture {

	enum State {

		case stopped(translation: CGPoint, velocity: CGPoint)
		case panning(translation: CGPoint, velocity: CGPoint)
	}
}
