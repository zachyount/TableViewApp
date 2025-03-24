//
//  ViewController.swift
//  TableStory
//
//  Created by Yount, Zach on 3/17/25.
//

import UIKit

import MapKit


//array objects of our data.
let data = [
    Item(name: "Lunch Protein Bowl", neighborhood: "Downtown", desc: "this meal has a mixture of eggs, potatoes, avocado , rice , and veggies with a side of watermelon and carrots.", lat: 30.273320, long: -97.753550, imageName: "meal1"),
    Item(name: "Oatmeal Breakfast Bowl", neighborhood: "Hyde Park", desc: "This bowl has a mixture of oats , bananas, strawberries, and mangos.", lat: 30.313960, long: -97.719760, imageName: "meal2"),
    Item(name: "Breakfast Protein Bowl", neighborhood: "Mueller", desc: "This meal has sausage , eggs , and avocados.", lat: 30.2962244, long: -97.7079799, imageName: "meal3"),
    Item(name: "Fish Bowl", neighborhood: "UT", desc: "This meal has fish , rice , veggies , and ranch. ", lat: 30.295190, long: -97.736540, imageName: "meal4"),
    Item(name: "Shrimp Spaghetti", neighborhood: "Hyde Park", desc: "This meal has pasta , tomato sauce , shrimp , and spinach.", lat: 30.304890, long: -97.726220, imageName: "meal5")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        let item = data[indexPath.row]
        cell?.textLabel?.text = item.name
        
        //Add image references
                      let image = UIImage(named: item.imageName)
                      cell?.imageView?.image = image
                      cell?.imageView?.layer.cornerRadius = 10
                      cell?.imageView?.layer.borderWidth = 5
                      cell?.imageView?.layer.borderColor = UIColor.white.cgColor
        
        return cell!
    }
        
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }
 
    
    
    // add this function to original ViewController
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "ShowDetailSegue" {
                  if let selectedItem = sender as? Item, let detailviewcontrollerViewController = segue.destination as? DetailviewcontrollerViewController {
                      // Pass the selected item to the detail view controller
                      detailviewcontrollerViewController.item = selectedItem
                  }
              }
          }
          
              
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        theTable.delegate = self
        theTable.dataSource = self
        
        
        //add this code in viewDidLoad function in the original ViewController, below the self statements

           //set center, zoom level and region of the map
               let coordinate = CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.7444)
               let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
               mapView.setRegion(region, animated: true)
               
            // loop through the items in the dataset and place them on the map
                for item in data {
                   let annotation = MKPointAnnotation()
                   let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                   annotation.coordinate = eachCoordinate
                       annotation.title = item.name
                       mapView.addAnnotation(annotation)
                       }

        
    }


    
    
}

