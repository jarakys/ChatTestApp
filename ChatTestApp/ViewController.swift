//
//  ViewController.swift
//  ChatTestApp
//
//  Created by Kyrylo Chernov on 25.01.2024.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var chatCollectionView: UICollectionView!
    
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var viewModel: ChatViewModel = {
        ChatViewModel(service: MockChatService())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func bind() {
        viewModel.errorSender.sink(receiveValue: { [weak self] error in
            guard let self else { return }
        }).store(in: &cancellable)
        
        viewModel.eventSender.sink(receiveValue: { [weak self] event in
            guard let self else { return }
        }).store(in: &cancellable)
    }

    @IBAction func sendDidTap(_ sender: Any) {
        viewModel.sendDidTap()
    }
}
