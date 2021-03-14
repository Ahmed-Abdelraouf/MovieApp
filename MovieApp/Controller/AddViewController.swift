//
//  AddViewController.swift
//  MovieApp
//
//  Created by Oufaa on 14/03/2021.
//

import UIKit

class AddViewController: UIViewController {
    var addProtocol:AddProtocol?
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var imageTextField: UITextField!
    
    @IBOutlet weak var ratingTextField: UITextField!
    
    @IBOutlet weak var realesTextField: UITextField!
    
    @IBOutlet weak var generTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func saveButton(_ sender: Any) {
        
        
        let addMovie = Movie(title: titleTextField.text!, image: imageTextField.text!, rating: Float(ratingTextField.text!) ?? 0.0, realeseYear: Int (realesTextField.text!)!, genre: [generTextField.text!])
//        https://images-na.ssl-images-amazon.com/images/I/71IH5WQD5wL._SY679_.jpg
        addProtocol?.saveMethod(movie: addMovie)
        navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
