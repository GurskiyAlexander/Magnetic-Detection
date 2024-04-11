import UIKit

// MARK: - MainCoordinator

final class MainCoordinator: BaseCoordinator {
    private weak var assembly: MainAssembly?

    init(assembly: MainAssembly) {
        self.assembly = assembly

        super.init(navigationController: assembly.rootAssembly.rootNavigation)
    }

    override func start() {
        guard let item = self.assembly?.makeMain(output: self) else { return }
        navigationController.setViewControllers([item], animated: true)
    }
}

extension MainCoordinator: MainScreenOutputInterface { 
    func openMagneticScreen() {
        guard let item = self.assembly?.makeMagnetic(output: self) else { return }
        navigationController.pushViewController(item, animated: true)
    }

    func openScanScreen() {
        guard let item = self.assembly?.makeScan(output: self) else { return }
        navigationController.pushViewController(item, animated: true)
    }

    func openResultScreen() {
        guard
            let result = self.assembly?.makeResult(output: self),
            let main = self.assembly?.makeMain(output: self),
            !(navigationController.topViewController is ResultScreenViewController)
        else { return }
        
        navigationController.setViewControllers([main, result], animated: true)
    }

    func openDetailsScreen(model: ResultCell.Model) {
        guard let item = self.assembly?.makeDetails(output: self, model: model) else { return }
        navigationController.pushViewController(item, animated: true)
    }

    func closeScreen() {
        navigationController.popViewController(animated: true)
    }
}

extension MainCoordinator: MagneticScreenOutputInterface { }
extension MainCoordinator: ScanScreenOutputInterface { }
extension MainCoordinator: ResultScreenOutputInterface { }
extension MainCoordinator: DetailsScreenOutputInterface { }


