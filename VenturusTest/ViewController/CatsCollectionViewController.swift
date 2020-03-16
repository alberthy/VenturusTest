//
//  CatsCollectionViewController.swift
//  VenturusTest
//
//  Created by Albert Oliveira on 14/03/20.
//  Copyright © 2020 Albert Oliveira. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SDWebImage

class CatsCollectionViewController: UICollectionViewController {
    
    var cats = [Cat]()
    var catService = CatService()
    
    let backGroundImageView = UIImageView()
    
    private let sectionInsets = UIEdgeInsets(top: 30.0, left: 5.0, bottom: 30.0, right: 5.0)
   
   private let itemsPerRow: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyBackground()
        self.fetchData()
    }
    
    func applyBackground(){

        backGroundImageView.image = UIImage(named: "background")
        
        collectionView.backgroundView = backGroundImageView
        
    }
    
    // realizar a consulta na api em busca da lista de cats
    func fetchData(){
        
        self.catService.fetchCats().responseData { (response) in
 
            let decoder = JSONDecoder()
            
            let responseSuccess: Swift.Result<ResponseData, Error> = decoder.decodeResponse(from: response)
            
            let responseData = try! responseSuccess.get()
            
            self.cats = responseData.cats ?? [Cat]()
            
            self.collectionView.reloadData()
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cats.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCollectionViewCell", for: indexPath) as! CatCollectionViewCell

        cell.cat = self.cats[indexPath.row]
        
        return cell
        
    }
    
}

class CatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var cat: Cat! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        
        // captura a primeira image do gato
        let link = cat.images?[0].link ?? ""
        
        // define a imagem no item ou o placeholder caso ocorra a2lgo.
        imageView.sd_setImage(with: URL(string: link), placeholderImage: UIImage(named: "place_holder.png"))
        
        // aplica a decoração
        imageView.layer.cornerRadius = 5.0
        imageView.layer.borderWidth = 0.2
        	
    }
    
}

extension JSONDecoder {
    
    func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> Swift.Result<T, Error> {
        
        // verifica se ocorreu algum erro
        guard response.error == nil else {
            print(response.error!)
            return .failure(response.error!)
        }
        
        // verifica se existe algum dado
        guard let responseData = response.data else {
            print("Nenhum resultado encontrado!")
            return .failure(response.error!)
        }
        
        do {
            let item = try decode(T.self, from: responseData)
            return .success(item)
        } catch {
            print("Ocorreu um erro ao realizar a decodificação(parser)")
            print(error)
            return .failure(error)
        }
    }
}

// Extension para definir items por linha
extension CatsCollectionViewController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow

    return CGSize(width: widthPerItem, height: widthPerItem)
    
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
    
    
}
