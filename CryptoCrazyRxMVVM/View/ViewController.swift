//
//  ViewController.swift
//  CryptoCrazyRxMVVM
//
//  Created by Onur Bulut on 24.09.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate
//                        ,UITableViewDataSource
{
  
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    let cryptoVM = CryptoViewModel()
    let disposeBag = DisposeBag()
    
    var cryptoList = [Crypto]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // tableView.delegate = self
        // tableView.dataSource = self
        view.backgroundColor = .black
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        setupBindings()
        cryptoVM.requestData()
        
        
        
  
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    private func setupBindings(){
        
        cryptoVM.loading
            .bind(to: self.indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        
        
         cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        
        
      /*  cryptoVM.cryptos.observe(on: MainScheduler.asyncInstance)
            .subscribe { cryptos in
                self.cryptoList = cryptos
                self.tableView.reloadData()
            }.disposed(by: disposeBag)*/
        
        cryptoVM.cryptos
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: "CryptoCell", cellType: CryptoTableViewCell.self)) { row, item, cell in
            cell.item = item
            
            
        }.disposed(by: disposeBag)
        
        
       
    }
    
    
  /*  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        content.text = cryptoList[indexPath.row].currency
        content.secondaryText = cryptoList[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }*/
    
}

