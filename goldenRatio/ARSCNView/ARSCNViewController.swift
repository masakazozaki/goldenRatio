//
//  ARSCNViewController.swift
//  goldenRatio
//
//  Created by Masakaz Ozaki on 2018/06/23.
//  Copyright © 2018 Masakazu Ozaki. All rights reserved.
//


import ARKit
import UIKit

class ARSCNViewController: UIViewController {

    let goldenRatio = (1.0 + sqrt(5.0)) / 2

    private var startNode: SCNNode?
    private var endNode: SCNNode?
    private var lineNode: SCNNode?

    @IBOutlet var sceneView: ARSCNView! {
        didSet {
            sceneView.delegate = self
            sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
            sceneView.scene = SCNScene()
        }
    }

    @IBOutlet private weak var calculatorButton: UIButton! {
        didSet {
            calculatorButton.layer.cornerRadius = 16
            calculatorButton.layer.cornerCurve = .continuous

        }
    }

    @IBOutlet var statusLabel: UILabel! {
        didSet {
            statusLabel.layer.masksToBounds = true
            statusLabel.layer.cornerRadius = 16
            statusLabel.layer.cornerCurve = .continuous
        }
    }

    @IBOutlet var resetButton: UIButton! {
        didSet {
            resetButton.layer.cornerRadius = 16
            resetButton.layer.cornerCurve = .continuous
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView.session.run()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    private func reset() {
        startNode?.removeFromParentNode()
        startNode = nil
        endNode?.removeFromParentNode()
        endNode = nil
        statusLabel.text = "Mapping Space..."
    }

    private func putSphere(at pos: SCNVector3, color: UIColor) -> SCNNode {
        let node = SCNNode.sphereNode(color: color)
        sceneView.scene.rootNode.addChildNode(node)
        node.position = pos
        return node
    }

    private func drawLine(from: SCNNode, to: SCNNode, length: Float) -> SCNNode {
        //        let lineNode = SCNNode.lineNode(length: CGFloat(length), color: UIColor.red)
        //        from.addChildNode(lineNode)
        //        lineNode.position = SCNVector3Make(0, 0, -length / 2)
        //        from.look(at: to.position)
        //        return lineNode
        
        let node = SCNNode()

        let goldenRect = SCNBox(width: CGFloat(Double(length) * goldenRatio), height: 0.01, length: CGFloat(length), chamferRadius: 0)
        node.geometry = goldenRect

        from.addChildNode(node)
        node.position = SCNVector3Make(-Float(Double(length) * goldenRatio) / 2, 0, -length / 2)
        from.look(at: to.position)

        let texture = UIImage(named: "goldenRatioAR")
        let material = SCNMaterial()
        material.diffuse.contents = texture

        let white = SCNMaterial()
        white.diffuse.contents = UIColor.white
        node.geometry?.materials = [white, white, white, white, material, white]

        return node
    }

    private func hitTest(_ pos: CGPoint) {
        let results = sceneView.hitTest(pos, types: [.existingPlane])
        guard let result = results.first else {return}
        let hitPos = result.worldTransform.position()

        if let startNode = startNode {
            endNode = putSphere(at: hitPos, color: UIColor.green)
            guard let endNode = endNode else {fatalError()}
            let distance = (endNode.position - startNode.position).length()
            print("distance: \(distance) [m]")
            lineNode = drawLine(from: startNode, to: endNode, length: distance)
            statusLabel.text = String(format: "a: %.2f [m]", distance)
        } else {
            startNode = putSphere(at: hitPos, color: UIColor.arBlue)
            statusLabel.text = "Tap an end point"
        }
    }

    // MARK: - Touch Handlers
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let pos = touch.location(in: sceneView)

        if let endNode = endNode {
            endNode.removeFromParentNode()
            lineNode?.removeFromParentNode()
        }
        hitTest(pos)
    }

    // MARK: - Actions
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        reset()
    }
}

extension ARSCNViewController: ARSCNViewDelegate {
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let frame = sceneView.session.currentFrame else {return}
        DispatchQueue.main.async(execute: {
            if !(frame.anchors.count > 0) {
                self.statusLabel.text = "Mapping Space..."
            } else if self.startNode == nil {
                self.statusLabel.text = "Tap a start point"
            }
        })
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {fatalError()}
        planeAnchor.addPlaneNode(on: node, contents: UIColor.arBlue.withAlphaComponent(0.1))
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {fatalError()}
        planeAnchor.updatePlaneNode(on: node)
    }

    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        print("\(self.classForCoder)/" + #function)
    }

    // MARK: - ARSessionObserver
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        print("trackingState: \(camera.trackingState)")
//        trackingStateLabel.text = camera.trackingState.description

    }
}
