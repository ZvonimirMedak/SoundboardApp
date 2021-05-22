//
//  
//  HomeViewController.swift
//  SoundboardApp
//
//  Created by Zvonimir Medak on 22.05.2021..
//
//
import UIKit
import SnapKit
import RxSwift
class HomeViewController: UIViewController {
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        return tv
    }()
    
    let disposeBag = DisposeBag()
    let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        setupUI()
        bindViewModel()
        viewModel.loadDataSubject.onNext(())
    }
}

private extension HomeViewController{
    func setupUI() {
        view.addSubview(tableView)
        setupConstraints()
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bindViewModel() {
        disposeBag.insert(viewModel.bindViewModel())
        viewModel.personRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (_) in
                tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.personRelay.value.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.userInteractionSubject.onNext(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            fatalError("Cell does not exists in storyboard")
        }
        let currentItem = viewModel.personRelay.value[indexPath.row]
        cell.configureCell(with: currentItem.image)
        return cell
    }

}
