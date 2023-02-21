import UIKit
import Flutter
import Flow
import FCL

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    initFCL()
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let deviceChannel = FlutterMethodChannel(name: "flowflutternftcatalog.beyonders/iOS",
                                                       binaryMessenger: controller.binaryMessenger)
    prepareMethodHandler(deviceChannel: deviceChannel)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    func initFCL() {
        let accountProof = FCL.Metadata.AccountProofConfig(appIdentifier: "Flow Catalog v(0.0)")
                
                let metadata = FCL.Metadata(appName: "Flow Catalog",
                                            appDescription: "Native Version of the Flow Catalog!",
                                            appIcon: URL(string: "https://placekitten.com/g/200/200")!,
                                            location: URL(string: "https://flow.org")!,
                                            accountProof: accountProof)

                fcl.config(metadata: metadata,
                           env: .mainnet,
                           provider: fcl.currentProvider ?? .lilico)
    }
    
    private func prepareMethodHandler(deviceChannel: FlutterMethodChannel) {
            deviceChannel.setMethodCallHandler({
                (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                if call.method == "getCatalog" {
                    Task{
                        await self.getCatalog(result: result)
                    }
                } else if(call.method == "sendTransaction") {
                }
                else {
                    result(FlutterMethodNotImplemented)
                    return
                }
                
            })
    }
    
    
    var getCatalogScript: String =
            """
            import NFTCatalog from 0x49a7cda3a1eecc29

            pub fun main(): {String : NFTCatalog.NFTCatalogMetadata} {
                
                       let catalog = NFTCatalog.getCatalog()
                        let keys = catalog.keys.slice(from: 0, upTo: 10)
                        let collections: {String: NFTCatalog.NFTCatalogMetadata} = {}

                        for key in keys {
                            collections[key] = catalog[key]
                        }

                        return collections
            
            }
            """
    private func getCatalog(result: FlutterResult) async {
        do{
            let response = try await fcl.query {
                            cadence {
                                getCatalogScript
                            }
            }.decode()
            print(response)
            result(response)
        }catch {
            print(error)
            result(error.localizedDescription)
        }
    }
    
    
    
    
}
