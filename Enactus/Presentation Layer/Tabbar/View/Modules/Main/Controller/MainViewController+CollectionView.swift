import UIKit

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return actionSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actionSections[section].rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = actionSections[indexPath.section].rows[indexPath.row]
        let cell: ActionsViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(with: ActionsViewCellViewModel(row: row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = actionSections[indexPath.section].rows[indexPath.row]
        
        switch row {
        case .remittance:
            coordinator?.showRemittanceFlow()
        case .shop:
            coordinator?.showShopFlow()
        case .credits:
            coordinator?.showCreditlow()
        case .faq:
            coordinator?.showFaqFlow()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/4.4, height: collectionView.bounds.height/0.9935)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.bounds.width/33.167
    }
}
