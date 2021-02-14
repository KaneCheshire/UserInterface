import UIKit

public extension NotificationCenter {
    
    var sceneWillConnectPublisher: Publisher {
        publisher(for: UIScene.willConnectNotification, object: nil)
    }
    
    func sceneWillConnectPublisher(for scene: UIScene) -> Publisher {
        publisher(for: UIScene.willConnectNotification, object: scene)
    }
}

public extension NotificationCenter {
    
    var sceneWillEnterForegroundPublisher: Publisher {
        publisher(for: UIScene.willEnterForegroundNotification, object: nil)
    }
    
    func sceneWillEnterForegroundPublisher(for scene: UIScene) -> Publisher {
        publisher(for: UIScene.willEnterForegroundNotification, object: scene)
    }
}

public extension NotificationCenter {
    
    var sceneDidActivatePublisher: Publisher {
        publisher(for: UIScene.didActivateNotification, object: nil)
    }
    
    func sceneDidActivatePublisher(for scene: UIScene) -> Publisher {
        publisher(for: UIScene.didActivateNotification, object: scene)
    }
}

public extension NotificationCenter {
    
    var sceneWillDeactivatePublisher: Publisher {
        publisher(for: UIScene.willDeactivateNotification, object: nil)
    }
    
    func sceneWillDeactivatePublisher(for scene: UIScene) -> Publisher {
        publisher(for: UIScene.willDeactivateNotification, object: scene)
    }
}

public extension NotificationCenter {
    
    var sceneDidEnterBackgroundPublisher: Publisher {
        publisher(for: UIScene.didEnterBackgroundNotification, object: nil)
    }
    
    func sceneDidEnterBackgroundPublisher(for scene: UIScene) -> Publisher {
        publisher(for: UIScene.didEnterBackgroundNotification, object: scene)
    }
}

public extension NotificationCenter {
    
    var sceneDidDisconnectPublisher: Publisher {
        publisher(for: UIScene.didDisconnectNotification, object: nil)
    }
    
    func sceneDidDisconnectPublisher(for scene: UIScene) -> Publisher {
        publisher(for: UIScene.didDisconnectNotification, object: scene)
    }
}
