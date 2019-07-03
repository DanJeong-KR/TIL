//
//  ViewController.swift
//  AlamofireExample
//
//  Created by chang sic jung on 07/06/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit // SystemFramework 우선 - > 3rd Party 는 A -> Z 선
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        let urlString = "https://jsonplaceholder.typicode.com/todos/1"
        let req = AF.request(urlString)
        
        req
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    @IBAction func postAction(_ sender: Any) {
        let urlString = "https://jsonplaceholder.typicode.com/todos"
        let params: Parameters = [
            "title" : "MyTitle",
            "userId" : 1,
        ]
        
        let req = AF.request(urlString, method: .post, parameters: params)
        
        req
            .responseJSON { (response) in
                print(try? response.result.get())
                print(response.response?.statusCode)
        }
    }


}

