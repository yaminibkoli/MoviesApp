//
//  ViewController.swift
//  BookMyMovies
//
//  Created by Kunal Malve on 18/03/20.
//  Copyright © 2020 Kunal Malve. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate{
    private let spacing:CGFloat = 16.0
    @IBOutlet weak var CollectionView: UICollectionView!
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var txtSortBy: UITextField!
    var indexkey:String = ""
    var row:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonParsingFromURL()
        SetCollectionItem()
        CollectionView.delegate = self
        CollectionView.dataSource = self
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .crossDissolve
       
      
        txtSearch.delegate = self as! UITextFieldDelegate
       
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
         txtSortBy.resignFirstResponder()
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
          modalPresentationStyle = .fullScreen
           modalTransitionStyle = .crossDissolve
    }
  //pasring funtion to parse
   func jsonParsingFromURL () {
       let url = NSURL(string: "https://api.themoviedb.org/3/discover/movie?api_key=a6f3c06992e5612755f1003897ee65a7&sort_by=popularity.desc&with_genres=28&page=2")
       let request = NSURLRequest(url: url! as URL)
       NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) {(response, data, error) in
           self.startParsing(data: data! as NSData)
       }
   }
   func startParsing(data :NSData)
   {
       //fetching all data
       let dict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
       
       //fetching data which present in results
       let results = dict["results"]
       
       //fetching titles from result & bind the data to cell accordingly
       for i in results as! [AnyObject]{
           var title = i["original_title"] as! String
           ModelData.shared.Title.append(title)
        var imageUrl =   i["poster_path"]as! String
        ModelData.shared.Image.append(imageUrl)
       let rating = i["vote_average"]as! Double
        ModelData.shared.Rating.append(rating)
        var releasedate = i["release_date"]as! String
        ModelData.shared.ReleaseDate.append(releasedate)
           CollectionView.reloadData()
       }
   }
   
    func SetCollectionItem(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.CollectionView?.collectionViewLayout = layout
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 16

        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row

        if let collection = self.CollectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ModelData.shared.Title.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath as IndexPath)as! MoviesCollectionViewCell
        cell.lblTitle.text = ModelData.shared.Title[indexPath.row]
       
        var path = "https://image.tmdb.org/t/p/w500/" + ModelData.shared.Image[indexPath.row]
       
      let url = URL(string: path)
      let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
      cell.ImageView.image  = UIImage(data: data!)

      //  cell.ImageView.image = UIImage(contentsOfFile: path)
           
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
               //cell.myLabel.text = self.items[indexPath.item]
              // cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.5
        cell.layer.cornerRadius = 8
       
               return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

           // let controller =  DetailController()
            //OR

        //Add the storyboard identifier of your view controller - "DetailController"
         row = indexPath.row
               indexkey = ModelData.shared.Title[indexPath.row]
                performSegue(withIdentifier: "SegueID", sender: self)

       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         var vc = segue.destination as! MovieDetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
              if let indexPath = self.CollectionView.indexPathsForSelectedItems {
                  let controller = segue.destination as! MovieDetailViewController
                vc.Title  =  ModelData.shared.Title[row]
                vc.RatingM = ModelData.shared.Rating[row]
                vc.ReleaseDateM = ModelData.shared.ReleaseDate[row]
                vc.image =  "https://image.tmdb.org/t/p/w500/" + ModelData.shared.Image[row]
                     
                
              }
    }
}




  
