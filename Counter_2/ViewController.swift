//
//  ViewController.swift
//  Counter_2
//
//  Created by Rodion Kim on 25/05/2024.
//

import UIKit

class ViewController: UIViewController {
    
//    Инициализация аутлетов
    @IBOutlet private weak var incrementButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    @IBOutlet private weak var decrementButton: UIButton!
    
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var counterInfoTextView: UITextView!
    
//    инициализация значения переменной значения счетчика
    private var counter: Int = 0

//    инициализация начального состояния приложения
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counterInfoTextView.isEditable = false
        
        resetButton.setTitle("Reset", for: .normal)
        decrementButton.setTitle("-", for: .normal)
        incrementButton.setTitle("+", for: .normal)
        counterInfoTextView.text = "История изменений:"
        
        renewCounter()
    }
    
//    функции, описывающие логику работы приложения
    private func currentDateTime() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let formattedDate = dateFormatter.string(from: currentDate)
        
        return formattedDate
    }
    
    private func renewCounter() {
        counterLabel.text = "Значение счетчика: \(String(counter))"
    }
    
    private func logAction(action: String){
        counterLabel.text = "Значение счетчика: \(String(counter))"
        
        counterInfoTextView.text += "\n[\(currentDateTime())] \(action)"
        
        let contentHeight = counterInfoTextView.contentSize.height
        let visibleHeight = counterInfoTextView.bounds.height
        let bottomInset = counterInfoTextView.contentInset.bottom
        
        if contentHeight > visibleHeight {
            let bottomOffset = CGPoint(x: 0, y: contentHeight - visibleHeight + bottomInset)
            counterInfoTextView.setContentOffset(bottomOffset, animated: true)
        }
    }
    
    private func counterAction(_ action: String) {
        renewCounter()
        logAction(action: action)
    }
    
//    экшены кнопок
    @IBAction private func decrementAction(_ sender: Any) {
        if (counter > 0) {
            counter -= 1
            counterAction("Значение изменено на -1")
        } else {
            counterAction("Попытка уменьшить значение счётчика ниже 0")
        }
    }
    
    @IBAction private func incrementAction(_ sender: Any) {
        counter += 1
        counterAction("Значение изменено на +1")
    }
    
    @IBAction private func resetAction(_ sender: Any) {
        if counter > 0 {
            counter = 0
            counterAction("Значение сброшено")
        }
    }
}

