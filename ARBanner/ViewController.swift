//
//  ViewController.swift
//  ARBanner
//
//  Created by Firoz Khursheed on 18/11/17.
//  Copyright © 2017 Firoz Khursheed. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
  
  @IBOutlet var sceneView: ARSCNView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let text = SCNText(string: "Awesome Banner", extrusionDepth: 1.0)
    
    let material = SCNMaterial()
    material.diffuse.contents = UIColor.blue
    text.materials = [material]
    
    let node = SCNNode()
    node.position = SCNVector3(-0.3, 0.0, -0.3)
    node.scale = SCNVector3(0.01, 0.01, 0.01)
    node.geometry = text
    
    sceneView.scene.rootNode.addChildNode(node)
    sceneView.automaticallyUpdatesLighting = true

  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Create a session configuration
    let configuration = ARWorldTrackingConfiguration()
    
    // Run the view's session
    sceneView.session.run(configuration)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    sceneView.session.pause()
  }
}
