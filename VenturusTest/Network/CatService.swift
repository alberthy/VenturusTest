//
//  CatService.swift
//  VenturusTest
//
//  Created by Albert Oliveira on 14/03/20.
//  Copyright © 2020 Albert Oliveira. All rights reserved.
//

import Alamofire

class CatService {
    
    let path: String = Bundle.main.path(forResource: "imgurdb", ofType: "plist")!
    let connection: NSDictionary
    
    var headers: HTTPHeaders
    var api: String
    
    // configura o header com o content-type e chave de autorização para realizar a requisição
    init() {
        
        connection = NSDictionary(contentsOfFile: path)!
        headers = [
          "Content-Type": connection.object(forKey: "CONTENT_TYPE") as! String,
          "Authorization": connection.object(forKey: "CLIENT_ID") as! String
        ]
        
        api = connection.object(forKey: "API") as! String
        
    }
    
    /*
     * Retorna a lista de gatos
     */
    func fetchCats() -> DataRequest {
        return AF.request("\(api)/gallery/search/?q=cats", method: .get, headers: headers)
    }
    
}
