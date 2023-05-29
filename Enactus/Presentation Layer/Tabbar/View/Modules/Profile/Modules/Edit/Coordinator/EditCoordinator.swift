import UIKit

final class EditCoordinator: BaseCoordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let editController = EditProfileViewController()
        editController.viewModel = EditProfileViewModel()
        navigationController.pushViewController(editController, animated: true)
    }
}
