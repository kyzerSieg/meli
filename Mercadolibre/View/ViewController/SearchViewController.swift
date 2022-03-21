//
//  ViewController.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 18-03-22.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SearchViewController: UIViewController,UITableViewDelegate {
    private var viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    private var searchData = PublishSubject<Search>()
    @IBOutlet var tableView: UITableView!
    let viewLoader : Loader = Loader.createViewLoader()
    var textSearch: String?

    func hideLoading(){
        self.viewLoader.isHidden = true
        self.viewLoader.indicator.stopAnimating()
    }
    
    func showLoading(){
        self.viewLoader.isHidden = false
        self.viewLoader.indicator.startAnimating()
    }
    
    private func setUpBindings() {
        viewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        viewModel.searchData.observe(on: MainScheduler.instance).bind(to: self.searchData).disposed(by: disposeBag)
        tableView.separatorStyle = .singleLine
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegateVM = self
        self.setUpBindings()        
        viewModel.getFinder(textSearch: textSearch!)
        searchData.map({ $0.results }).bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: SearchTableViewCell.self)) { (index: Int, item: Result, cell: SearchTableViewCell) in
            cell.contentView.backgroundColor = UIColor.clear
            cell.row = index
            cell.item = item
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
          .subscribe(onNext: { [weak self] indexPath in
            let cell = self?.tableView.cellForRow(at: indexPath) as? SearchTableViewCell
            self!.viewModel.itemSelected.append((cell?.item)!)
            self!.performSegue(withIdentifier: "gotoDetail", sender: cell?.item)
          }).disposed(by: disposeBag)
         
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)        
        tableView.rowHeight = 132
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueName: String = segue.identifier!
        if (segueName == "gotoDetail") {
            self.navigationItem.title = ""
            let vc = segue.destination as? SearchDetailViewController
            vc?.item = (sender as! Result)
        }
    }
    
    @IBAction func unwindSearch(unwindSegue: UIStoryboardSegue){
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit{
        print("OS reclaimin memory for table view :P ...donkey!!")
    }
}

extension SearchViewController: SearchDelegate {
    func onError(error: Error) {
        showAlert(message: error.errorMessage)
        if(error.errorCode == 404){
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "unwindFinder", sender: self)
            }
        }
    }
}
