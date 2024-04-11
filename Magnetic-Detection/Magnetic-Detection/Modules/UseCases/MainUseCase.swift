import UIKit

protocol MainUseCase {
    var currentNetwork: String { get }
    var counterFindingDevices: Int { get set }

    func getCurrentNetwork() -> CurrentNetwork
    func getDevices() -> ResultModel
    func getDetailsInfo(with model: ResultCell.Model) -> DetailsModel
}

class MainUseCaseImpl: BaseUsecase {
    // MARK: Internal

    let secure: SecurePropertiesService

    // MARK: Lifecycle

    init(
        secure: SecurePropertiesService,
        unsecure: UnsecurePropertiesService
    ) {
        self.secure = secure
        super.init(unsecure: unsecure)
    }

    var currentNetwork = String()
    var counterFindingDevices = Int()
}

extension MainUseCaseImpl: MainUseCase {
    func getCurrentNetwork() -> CurrentNetwork {
        currentNetwork = "WIFI_Name"
        return CurrentNetwork(
            name: currentNetwork,
            cells: [
                ActionCell.Model(
                    type: .infrared,
                    image: UIImage(named: "infrared"),
                    title: "Infrared\nDetection"
                ),
                ActionCell.Model(
                    type: .bluetooth,
                    image: UIImage(named: "bluetooth"),
                    title: "Bluetooth\nDetection"
                ),
                ActionCell.Model(
                    type: .magnetic,
                    image: UIImage(named: "magnetic"),
                    title: "Magnetic\nDetection"
                ),
                ActionCell.Model(
                    type: .tips,
                    image: UIImage(named: "tips"),
                    title: "Antispy\nTips"
                )
            ]
        )
    }

    func getDevices() -> ResultModel {
        let models: [ResultCell.Model] = (0...counterFindingDevices).map {
            ResultCell.Model.init(
                networkImage: $0.isMultiple(of: 3) ? .networkNorm : .networkFail,
                name: "\($0) Chi-Chi",
                ipAddress: "192.168.1.1",
                isNorm: $0.isMultiple(of: 3)
            )
        }

        return ResultModel(
            currentNetworkName: currentNetwork,
            countDevices: counterFindingDevices,
            cellModels: models
        )
    }

    func getDetailsInfo(with model: ResultCell.Model) -> DetailsModel {
        return .init(
            currentNetworkName: model.name,
            isNorm: model.isNorm,
            ip: model.ipAddress,
            cellModels: [
                .init(title: "Connection Type", description: "Wifi"),
                .init(title: "IP Address", description: model.ipAddress),
                .init(title: "MAC Address", description: "Not Available"),
                .init(title: "Hostname", description: "gwpc-21141234.local")
            ]
        )
    }
}
