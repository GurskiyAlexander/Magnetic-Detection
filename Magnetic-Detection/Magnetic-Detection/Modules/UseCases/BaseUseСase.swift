import UIKit

public class BaseUsecase: NSObject {
    let unsecure: UnsecurePropertiesService

    init(
        unsecure: UnsecurePropertiesService
    ) {
        self.unsecure = unsecure
    }
}
