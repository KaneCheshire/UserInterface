import Foundation
import Combine
import Logging

open class BaseViewModel<State, NavRequest>: Logger {

	@Published public private(set) var state: State
	@Published public private(set) var navRequest: NavRequest?

	public var cancellables: Set<AnyCancellable> = []

	public init(initialState: State) {
		self.state = initialState
	}

	public func set(_ state: State) {
		self.state = state
	}

	public func request(_ navRequest: NavRequest) {
		self.navRequest = navRequest
	}
}
