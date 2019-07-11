//
//  ViewController.swift
//  ImageDetection-JPO
//
//  Created by Robin Champsaur on 25/06/2018.
//  Copyright © 2018 Robin Champsaur. All rights reserved.
//

//TODO - Fix the zposition of the plane on very big images

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    let scenaryHandler = ScenaryHandler()
    let imgDictionnary = ImageDictionnary()
    
    let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! +
        ".serialSceneKitQueue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTracking(ressourceFolder: Constants.ARReference.folderName)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    func configureTracking(ressourceFolder: String) {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: ressourceFolder, bundle: nil) else {
            fatalError("Missing expected asset catalog resources")
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        sceneView.session.run(configuration, options: [])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let ref = imageAnchor.referenceImage
        updateQueue.async {
            //Triple check to see if the SKScene and the node can be created
            if let name = ref.name {
                if let dicoDescr = self.imgDictionnary.dictionnary[name] {
                    if !self.scenaryHandler.nodeHandler.onScreenNodes.contains(dicoDescr) {
                        self.scenaryHandler.runScenaryCoursPasteur(objectName: dicoDescr, sceneView: self.sceneView, ref: ref, node: node)
                        self.scenaryHandler.runScenary3IE(objectName: dicoDescr, sceneView: self.sceneView, ref: ref, node: node)
                    }
                }
            }
        }
    }
}
