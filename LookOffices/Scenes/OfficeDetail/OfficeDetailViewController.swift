//
//  OfficeDetailViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 3.08.2022.
//

import UIKit

protocol OfficeDetailDisplayLogic: AnyObject {
    func detailOffice(viewModel: OfficeDetail.FetchOfficeDetail.ViewModel.OfficeDetail)
    func showAlert(error: String)
}

final class OfficeDetailViewController: UIViewController {
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    var interactor: OfficeDetailBusinessLogic?
    var router: (OfficeDetailRoutingLogic & OfficeDetailDataPassing)?
    
    var detailOffice: OfficeDetail.FetchOfficeDetail.ViewModel.OfficeDetail?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override func viewDidLoad() {
        interactor?.fetchOffices()
        navigationController?.setNavigationBarHidden(false, animated: true)
        detailCollectionView.register(UINib(nibName: OfficeDetailCell.identifier, bundle: nil)
                                      , forCellWithReuseIdentifier: OfficeDetailCell.identifier)
        detailCollectionView.register(UINib(nibName: OfficeDetailDataCell.identifier, bundle: nil)
                                      , forCellWithReuseIdentifier: OfficeDetailDataCell.identifier)
    }
    
    private func setupUI () {
        DispatchQueue.main.async { [weak self] in
            self?.detailCollectionView.dataSource = self
            self?.detailCollectionView.delegate = self
            self?.detailCollectionView.setCollectionViewLayout(self?.createLayout() ?? UICollectionViewLayout(), animated: true)
            self?.detailCollectionView.reloadData()
        }
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = OfficeDetailInteractor()
        let presenter = OfficeDetailPresenter()
        let router = OfficeDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension OfficeDetailViewController: OfficeDetailDisplayLogic {
    
    func detailOffice(viewModel: OfficeDetail.FetchOfficeDetail.ViewModel.OfficeDetail) {
        detailOffice = viewModel
        setupUI()
        
    }
    
    func showAlert(error: String) {
        let alert = AppConstants.alertError(Error: error)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}

extension OfficeDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = sections(rawValue: section) else { return 0 }
        switch section {
        case .detailData:
           return 1
        case .image:
            guard let imageCount = detailOffice?.officeDetailimages.count else { return 0 }
            return imageCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionCell = sections(rawValue: indexPath.section)
        else { return UICollectionViewCell() }
        
        switch sectionCell {
        case .image:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OfficeDetailCell.identifier, for: indexPath)
                    as? OfficeDetailCell else { return UICollectionViewCell()}
            cell.configure(image: (detailOffice?.officeDetailimages[indexPath.row]))
            return cell
            
        case .detailData:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OfficeDetailDataCell.identifier, for: indexPath)
                    as? OfficeDetailDataCell else { return UICollectionViewCell()}
            cell.clickWebSiteDelegate  = self  //Officesin web sitesine gitmek için butona basıldığını haber veriyoruz
            guard let model = detailOffice else { return UICollectionViewCell() }
            cell.configureData(Model: model)
            return cell
        }
    }
}

extension OfficeDetailViewController {
    func makeHorizontalLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection (group: group)
        section.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func makeVerticalLayout () -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize (widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createLayout () -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                return self.makeHorizontalLayout()
            }
            else {
               return self.makeVerticalLayout()
            }
        }
    }
}


extension OfficeDetailViewController : clickWebSiteOpenClick {
    func buttonClick() {
        router?.openOfficeWebSite()
    }
    
    
}
