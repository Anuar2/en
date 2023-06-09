import UIKit

final class ProfileViewController: UIViewController {
    
    let sections: [Profile] = [.init(section: .info , rows: [.first,.second,.third]), .init(section: .button, rows: [.first,.third])]
    
    var viewModel: ProfileViewModel?
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.backgroundColor = .black
        imageView.image = .init(named: "AppIcon")
        return imageView
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "profileBackground")
        return imageView
    }()
    
    private lazy var signOutAlert: UIAlertController = {
        
        let alertController = UIAlertController(title: "Выйти?", message: "Вы уверены что хотите выйти?", preferredStyle: .alert)
       //alert action
        let yesAction = UIAlertAction(title: "Да", style: .default) { (action) in
            self.viewModel?.signOut()
        }
        let noAction = UIAlertAction(title: "Нет", style: .default) { (action) in

        }
       
       alertController.addAction(yesAction)
       alertController.addAction(noAction)

        return alertController
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Mulish", size: 24)
        label.text = (profileInfo.name ?? "") + " " + (profileInfo.surname ?? "")
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = AuthorizationService.shared.authorizationModel.email
        
        label.font = UIFont(name: "Mulish", size: 16)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellClass: InfoTableViewCell.self)
        tableView.register(cellClass: ButtonTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        nameLabel.text = (profileInfo.name ?? "") + " " + (profileInfo.surname ?? "")
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
        setupColors()
        setupNavController()
    }
    
    private func setupColors() {
        view.backgroundColor = .enWhite
    }
    
    private func setupSubviews() {
        [backgroundImage, avatarImageView, nameLabel,
         emailLabel, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        avatarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupNavController() {
        let barButton = UIBarButtonItem(image: .init(named: "pencil"), style: .done, target: self, action: #selector(editProfile))
        barButton.tintColor = .black
        navigationItem.rightBarButtonItem = barButton
    }
    @objc func nextPage(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        switch indexPath.row {
        case 0:
            viewModel?.moveToWallet()
        case 1:
            present(signOutAlert, animated: true)
        case 2:
            print("gg") 
        default:
            return
        }
    }
    
    @objc func editProfile() {
        viewModel?.moveToEdit()
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func updateViewData() {
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let row = sections[indexPath.section].rows[indexPath.row]
            let cell: InfoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = ProfileInfoTableViewCellViewModel(row: row)
            cell.configure(with: cell.viewModel!)
            return cell
        } else {
            let row = sections[indexPath.section].rows[indexPath.row]
            let cell: ButtonTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.button.tag = indexPath.row
            cell.button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
            cell.configure(with: ProfileButtonTableViewCellViewModel(row: row))
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 12
        } else {
            return 8
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        " "
    }
    
    
}

