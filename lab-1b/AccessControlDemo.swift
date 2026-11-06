
import Foundation

// MARK: - Access Control Demonstration

public class AccessControlDemo {

    // private: Accessible only within this enclosing declaration.
    private var privateMessage: String = "Private access"

    // fileprivate: Accessible anywhere within this source file.
    fileprivate var filePrivateMessage: String = "Fileprivate access"

    // internal: Accessible throughout this module.
    internal var internalMessage: String = "Internal access"

    // public: Accessible to callers outside the module.
    public var publicMessage: String = "Public access"

    public init() {}

    public func displayPrivateMessage() {
        print(privateMessage)
    }

    public func displayFilePrivateMessage() {
        print(filePrivateMessage)
    }
}

// Demonstrates fileprivate access within the same file.
func demonstrateFilePrivateAccess() {
    let demo = AccessControlDemo()
    print(demo.filePrivateMessage)
}
