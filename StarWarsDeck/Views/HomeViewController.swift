//
//  HomeViewController.swift
//  StarWarsDeck
//
//  Created by ReisDev on 25/04/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is FilmViewController {
            if let vc = segue.destination as? FilmViewController {
                vc.viewModel.filmURL = "https://swapi.dev/api/films/1/"
            }
        }
    }
}
