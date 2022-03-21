//
//  SearchDetail.swift
//  Mercadolibre
//
//  Created by Mauricio Pacheco on 19-03-22.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SearchDetailViewController: UIViewController {
    private var viewModel = SearchDetailViewModel()
    private let disposeBag = DisposeBag()
    private var detailData = PublishSubject<Detail?>()
    let viewLoader : Loader = Loader.createViewLoader()
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var cellDetail: UICollectionView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblBefor: UILabel!
    @IBOutlet var lblNow: UILabel!
    @IBOutlet var lblDiscount: UILabel!
    @IBOutlet var lblQuantity: UILabel!
    var  item: Result?
    
    
    private func setUpBindings() {
        viewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        viewModel.detailData.observe(on: MainScheduler.instance).bind(to: self.detailData).disposed(by: disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        navigationController!.navigationBar.barTintColor = UIColor.formHex(4260459264)
        viewModel.delegateVM = self
        self.setUpBindings()
        viewModel.getDetail(item: item!)
        detailData.map({ $0!.pictures })
            .filter{ [unowned self] (images) -> Bool in
                self.pageControl.numberOfPages = images.count
                return images.count > 0
            }
            .bind(to: cellDetail.rx.items(cellIdentifier: "Cell", cellType: CellDetailViewController.self)){
                [unowned self] (row, element, cell) in
                cell.productImage.loadImage(urlStr: element.secure_url)
                self.pageControl.currentPage = row
            }.disposed(by: disposeBag)
        
        detailData.map({ $0!.title }).bind(to:lblTitle.rx.text).disposed(by: disposeBag)
        detailData.map({ $0!.price.toPrice() }).bind(to: lblNow.rx.text).disposed(by: disposeBag)
        detailData.map({ if($0!.original_price != nil) {
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: $0!.original_price!.toPrice())
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributedString.length))
            return attributedString
        }else{
            return NSMutableAttributedString(string: "")
        }
        }).bind(to: lblBefor.rx.attributedText).disposed(by: disposeBag)
        detailData.map({ ($0!.original_price != nil) ? ((100 - (($0!.price * 100)/$0!.original_price!)) as Double).toDiscount() : "" }).bind(to: lblDiscount.rx.text).disposed(by: disposeBag)
        detailData.map({ "  Cantidad: 1 (\($0!.sold_quantity) disponibles)"  }).bind(to: lblQuantity.rx.text).disposed(by: disposeBag)
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    @IBAction func unwind(unwindSegue: UIStoryboardSegue){
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit{
        print("OS reclaimin memory for page control or image view :P ...donkey!!")
    }
}

extension SearchDetailViewController: SearchDetailDelegate {
    func onError(error: Error) {
        showAlert( message: error.errorMessage)
        if(error.errorCode == 404){
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "unwindSearch", sender: self)
            }
        }
    }
}
