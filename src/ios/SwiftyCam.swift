

@objc(SwiftyCam) class SwiftyCam : CDVPlugin, SwiftyCamViewControllerDelegate {
  @objc(echo:)
  func echo(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )
    
//    let sView = UIViewController !as SwiftyCamCameraViewController
//
//
//    self.presentViewController(navController, animated: true, completion: nil)
    let cameraView = UIStoryboard(name: "SwiftyCam", bundle: nil).instantiateInitialViewController() as! SwiftyCamViewController
    
    
    
    self.viewController.present(cameraView, animated: true, completion: nil)
    
    let msg = command.arguments[0] as? String ?? ""

    if msg.characters.count > 0 {
      let toastController: UIAlertController =
        UIAlertController(
          title: "",
          message: msg,
          preferredStyle: .alert
        )
      
      self.viewController?.present(
        toastController,
        animated: true,
        completion: nil
      )

      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        toastController.dismiss(
          animated: true,
          completion: nil
        )
      }
        
      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_OK,
        messageAs: msg
      )
    }

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }
}
