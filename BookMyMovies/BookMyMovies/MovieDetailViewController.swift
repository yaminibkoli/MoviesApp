//
//  MovieDetailViewController.swift
//  BookMyMovies
//
//  Created by Kunal Malve on 19/03/20.
//  Copyright © 2020 Kunal Malve. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
     var image:String?
    var Title:String?
    var RatingM: Double?
    var ReleaseDateM: String?
    override func viewDidLoad() {
        super.viewDidLoad()
         lblTitle.text = Title
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        lblTitle.text = Title
        lblRating.text =  "\(RatingM!)"
        lblReleaseDate.text = ReleaseDateM
        var path = image
        let url = URL(string: path!)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        ImageView.image  = UIImage(data: data!)
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
