//
//  ViewController.swift
//  Mapkit and GoogleMap
//
//  Created by Rasyid Respati Wiriaatmaja on 05/02/20.
//  Copyright © 2020 rasyidrw. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapKit: MKMapView!
    @IBOutlet weak var lblJarak: UILabel!
    @IBOutlet weak var lblWaktu: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapKit.delegate = self
        
        //tentukan lokasi awal dan tujuan
        let awal = CLLocationCoordinate2D(latitude: -6.195303, longitude: 106.7926616)
        let tujuan = CLLocationCoordinate2D(latitude: -6.2074058, longitude: 106.7952495)
        
        //convert coordinate ke place marker
        let placeAwal = MKPlacemark(coordinate: awal)
        let placeTujuan = MKPlacemark(coordinate: tujuan)
        
        //convert dari place marker ke map item
        let itemAwal = MKMapItem(placemark: placeAwal)
        let itemTujuan = MKMapItem(placemark: placeTujuan)
        
        //eksekusi di map
        let mkRequest = MKDirections.Request()
        mkRequest.source = itemAwal
        mkRequest.destination = itemTujuan
        mkRequest.transportType = .automobile
        
        //bikin rute
        let direction = MKDirections(request: mkRequest)
        
        direction.calculate { (getRute, error) in
            
            let jarak = getRute?.routes[0].distance
            self.lblJarak.text = String(jarak!)
            
            let waktu = getRute?.routes[0].expectedTravelTime
            self.lblWaktu.text = String(waktu!)
            
            let rute = getRute?.routes[0].polyline
            self.mapKit.addOverlay(rute!, level: .aboveRoads)
        }
        
        //pin awal
        let pinAwal = MKPointAnnotation()
        pinAwal.title = "lokasi awal"
        pinAwal.coordinate = awal
        
        //pin tujuan
        let pinTujuan = MKPointAnnotation()
        pinTujuan.title = "lokasi tujuan"
        pinTujuan.coordinate = tujuan
        
        //set pin ke map
        mapKit.showAnnotations([pinAwal, pinTujuan], animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let garisRute = MKPolylineRenderer(overlay: overlay)
        garisRute.lineWidth = 3
        garisRute.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return garisRute
    }
    
    
}

