//
//  ViewController.swift
//  FunctionalGenericProgramming
//
//  Created by Luca D'Alberti on 9/22/16.
//  Copyright © 2016 STRV. All rights reserved.
//

import UIKit
import SwiftHelpSet

enum ConnectionStatus<ValueType> {
    case loading
    case completed(Completion<ValueType>)
}

typealias Todo = AnyObject

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewModel.todosConnectionState.bind { state in
            
            switch state {
            case .loading: break
            // show loading indicator
            case .completed(let result):
                // Hide loading indicator
                switch result {
                case .failed(let error):
                    print(error)
                case .success(let todos):
                    print(todos)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func _setupButton() {
        let button = UIButton(frame: .zero)
        button.bind(.touchUpInside) {
            // do something
        }
    }
}

final class ViewModel {
    
    var todosConnectionState = Bindable< ConnectionStatus<[Todo]> >(value: .loading)
    
    func getTodos() {
        todosConnectionState.value = .loading
        // calls network layer
        // set todosState depending on the result
    }
    
    func getTodos(completion: (_ todos: [Todo]?, _ error: NSError?) -> ()) {
        let todos: [Todo]? = nil    // received from the API manager
        let error: NSError? = nil   // received from the API manager
        
        // If there is an error
        if let _error = error {
            
            // Call the completion with the error
            completion(nil, _error)
            
        // If there is a value
        } else if let _todos = todos {
            
            // Call the completion with the value
            completion(_todos, nil)
            
        // Otherwise...
        } else {
            
            // Something wrong happened
            completion(nil, .ConnectionGenericError)
        }
    }
}

extension NSError {
    static var ConnectionGenericError: NSError {
        return NSError(domain: "", code: 1, userInfo: nil)
    }
}
