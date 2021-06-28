//
//  FilmViewController.swift
//  StarWarsDeck
//
//  Created by ReisDev on 24/04/21.
//

import UIKit
import RxSwift

class FilmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public var filmURL: String = "";
    var disposeBag = DisposeBag()
    var film: BehaviorSubject<Film> = BehaviorSubject(value: Film());
    var viewModel: FilmViewModel?;
    var cellReuseIdentifier = "cell"
    
    @IBOutlet var charactersList: UITableView!;
    @IBOutlet var crawlingButton: UIButton!;
    @IBOutlet var movieTitle: UILabel!;
    @IBOutlet var director: UILabel!;
    @IBOutlet var producer: UILabel!;
    @IBOutlet var year: UILabel!;
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)!
        
        self.viewModel = FilmViewModel(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.crawlingButton!.isUserInteractionEnabled = false
        self.viewModel?.loadFilm()
        
        self.film.subscribe(onNext: { film in
            DispatchQueue.main.async {
                self.movieTitle.text = film.title
                self.year.text = film.releaseYear
                
                self.director.text = film.director
                self.producer.text = film.producer
                
                self.crawlingButton.isUserInteractionEnabled = true
                self.movieTitle.sizeToFit()
                self.director.sizeToFit()
                self.producer.sizeToFit()
                self.year.sizeToFit()
                self.charactersList.reloadData()
            }
        }).disposed(by: self.disposeBag)
        
        // Register the table view cell class and its reuse id
        self.charactersList.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        self.charactersList.backgroundColor = UIColor.black
        self.charactersList.tintColor = UIColor.systemYellow

        charactersList.delegate = self
        charactersList.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is OpeningCrawlingViewController {
            if let vc = (segue.destination as? OpeningCrawlingViewController) {
                do {
                    let film = try self.film.value()
                    vc.crawlingText = film.openingCrawl
                } catch(let error){
                    debugPrint(error)
                }
            }
        }
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try self.film.value().characters.count
        } catch {
            return 0
        }
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (self.charactersList.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        
        cell.contentView.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.systemYellow
        
        cell.selectedBackgroundView?.backgroundColor = UIColor.systemYellow
        
        do {
            APIService.shared.get(try self.film.value().characters[indexPath.row]).subscribe(onNext: { (character: People) in
                cell.textLabel?.text = character.name
            }).disposed(by: disposeBag)
        }
        catch {
            cell.textLabel?.text = ""
        }
        return cell
    }
}

