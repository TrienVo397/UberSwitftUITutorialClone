//
//  UberMapViewRepresentable.swift
//  UberSwitftUITutorial
//
//  Created by kiet on 14/09/2023.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable{
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    func makeUIView(context: Context) -> some UIView {//A context structure containing information about the current state of the system.

        mapView.delegate = context.coordinator 
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
       return mapView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)// self refers to the current instance of UberMapViewRepresentable, cannot put UberMapViewRepresentable
    }
    
}

extension UberMapViewRepresentable{// the coordinate itself
    class MapCoordinator: NSObject, MKMapViewDelegate{// a middleman between swiftUI view and UIKit functionality
        let parent : UberMapViewRepresentable
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {// tell the delegate that the location of the user was updated
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)//The MKCoordinateSpan represents the amount of map to display for a specific region. It is defined by the latitudeDelta and longitudeDelta properties, which determine the zoom level or visible area on the map.
                
            )
            parent.mapView.setRegion(region, animated: true)
            
        }
    }
}
/*why do the coder make extension, cant he just put everything under the struct UberMapViewRepresentable
 
 
 The decision to use an extension in this case is a matter of code organization and separation of concerns. By placing the MapCoordinator class in an extension, the code author is separating the coordinator functionality from the main UberMapViewRepresentable struct.
 There are several reasons why one might choose to use an extension instead of including everything within the main struct:
 Clarity and Readability: Separating the coordinator code into an extension helps improve the clarity and readability of the main struct. It allows developers to focus on the primary purpose of the struct without being distracted by auxiliary functionality.
 Modularity and Reusability: Placing the coordinator in an extension promotes modularity and reusability. The coordinator can be easily reused in other parts of the codebase or for other map-related views, independent of the UberMapViewRepresentable struct.
 Separation of Concerns: By separating the coordinator functionality into its own class, the code author can isolate the responsibilities and concerns of each component. The UberMapViewRepresentable struct can focus on its role as a UIViewRepresentable wrapper, while the coordinator handles the delegate methods and coordination specific to the map view.
 Code Organization: Using an extension allows for better organization of code files. It keeps related functionality grouped together, making it easier to find and maintain specific sections of code.
 While it is possible to include everything within the main struct, using extensions can help improve code organization, modularity, and maintainability. It promotes the principle of separation of concerns, making the codebase more manageable and easier to understand.
 
 
 In Swift, super.init() is a mechanism used to call the designated initializer of a superclass during the initialization of a subclass. It ensures that the superclass's initialization code is executed before the subclass's initialization code.
 When a subclass is initialized, it must initialize its inherited properties and fulfill any additional requirements specified by its own initializer. To ensure that the superclass's initialization is performed first, the super.init() statement is used within the subclass's initializer.
 Here's an example to illustrate the usage of super.init():
 swift
 Copy
 class Vehicle {
     var numberOfWheels: Int

     init(numberOfWheels: Int) {
         self.numberOfWheels = numberOfWheels
     }
 }

 class Car: Vehicle {
     var color: String

     init(numberOfWheels: Int, color: String) {
         self.color = color
         super.init(numberOfWheels: numberOfWheels)
     }
 }
 In this example:
 The Vehicle class is the superclass, which has a stored property numberOfWheels and an initializer that initializes that property.
 The Car class is a subclass of Vehicle and introduces an additional stored property color. It has its own initializer that initializes color and calls super.init(numberOfWheels:) to initialize the numberOfWheels property inherited from Vehicle.
 By calling super.init(numberOfWheels:), the Car class ensures that the numberOfWheels property is initialized by the Vehicle superclass before performing any additional initialization required by the Car class.
 This mechanism allows for the correct initialization of inherited properties and the establishment of the class hierarchy during the initialization process.
 kinda like constructor in Java
 */