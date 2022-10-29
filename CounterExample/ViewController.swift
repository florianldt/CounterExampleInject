//
//  ViewController.swift
//  CounterExample
//
//  Created by Colin Eberhardt on 04/08/2016.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import UIKit
import ReSwift


class ViewController: UIViewController, StoreSubscriber {
    typealias StoreSubscriberStateType = AppState

    let decreaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("-", for: .normal)
        return button
    }()
    
    let increaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        return button
    }()

    let counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            decreaseButton,
            counterLabel,
            increaseButton
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 20
        view.alignment = .fill
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        decreaseButton.addTarget(self, action: #selector(downTouch), for: .touchUpInside)
        increaseButton.addTarget(self, action: #selector(upTouch), for: .touchUpInside)
        mainStore.subscribe(self)
    }
    
    func newState(state: AppState) {
        // when the state changes, the UI is updated to reflect the current state
        counterLabel.text = "\(mainStore.state.counter)"
    }
    
    // when either button is tapped, an action is dispatched to the store
    // in order to update the application state
    @objc private func downTouch() {
        mainStore.dispatch(CounterActionDecrease());
    }

    @objc private func upTouch() {
        mainStore.dispatch(CounterActionIncrease());
    }

}

