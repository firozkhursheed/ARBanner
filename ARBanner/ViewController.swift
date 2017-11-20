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
    
    let textNode = addTextNode(text: "Awesome \n Banner")
    let planeNode = addPlaneNode(parentNode: textNode)
    
    textNode.addChildNode(planeNode)
    
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

  private func addTextNode(text: String) -> SCNNode {
    let text = SCNText(string: text, extrusionDepth: 1.0)
    
    let colorMaterial = SCNMaterial()
    colorMaterial.diffuse.contents = UIColor.lightText
    text.materials = [colorMaterial]
    
    let textNode = SCNNode()
    textNode.position = SCNVector3(-0.3, 0.0, -0.6)
    textNode.scale = SCNVector3(0.01, 0.01, 0.01)
    textNode.geometry = text
    
    sceneView.scene.rootNode.addChildNode(textNode)
    
    return textNode
  }

  private func addPlaneNode(parentNode: SCNNode) -> SCNNode {
    let textNodeContainerSize = parentNode.boundingBox
    let textNodeWidth = (textNodeContainerSize.max.x - textNodeContainerSize.min.x) * 2
    let textNodeHeight = (textNodeContainerSize.max.y - textNodeContainerSize.min.y) * 3
    let textNodeDepth = textNodeContainerSize.max.z - textNodeContainerSize.min.z

    let plane = SCNPlane(width: CGFloat(textNodeWidth), height: CGFloat(textNodeHeight))
    
    let backgroundMaterial = SCNMaterial()
    backgroundMaterial.diffuse.contents = #imageLiteral(resourceName: "RedBanner") // souce: https://gallery.yopriceville.com/Free-Clipart-Pictures/Ribbons-and-Banners-PNG/Red_Banner_PNG_Clipart_Picture
    plane.materials = [backgroundMaterial]
    
    let planeNode = SCNNode()
    planeNode.position = SCNVector3(textNodeWidth / 4, textNodeHeight / 8, -(textNodeDepth / 2))
    planeNode.geometry = plane
    
    return planeNode
  }
}
