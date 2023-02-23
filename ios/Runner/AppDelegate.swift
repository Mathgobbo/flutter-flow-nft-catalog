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
        
        initFCL(network: .mainnet)
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let deviceChannel = FlutterMethodChannel(name: "flowflutternftcatalog.beyonders/iOS",
                                                 binaryMessenger: controller.binaryMessenger)
        prepareMethodHandler(deviceChannel: deviceChannel)
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    /**
     Method to parse the method called by the Flutter application and resolve one of the following funtions
     **/
    private func prepareMethodHandler(deviceChannel: FlutterMethodChannel) {
        deviceChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == "getCatalog" {
                Task{
                    await self.getCatalog(result: result, call: call)
                }
            } else if(call.method == "getCatalogLength") {
                Task {
                    await self.getCatalogLength(result: result)
                }
            } else if(call.method == "changeToMainnet") {
                if(fcl.currentEnv != .mainnet){
                    self.initFCL(network: .mainnet)
                    result(nil);
                }
            } else if(call.method == "changeToTestnet") {
                if(fcl.currentEnv != .testnet){
                    self.initFCL(network: .testnet)
                    result(nil)
                }
            }else if(call.method == "getCurrentUser"){
                self.getCurrentUser(result: result);
            }else if(call.method == "authenticate") {
                Task {
                    await self.authenticateUser(result:result);
                }
            }else if(call.method == "unauthenticate") {
                Task {
                    await self.unauthenticate(result:result);
                }
            } else {
                result(FlutterMethodNotImplemented)
                return
            }
            
        })
    }
    
    /**
     Method to confiure FCL
     @param network receives the desired network to start the FCL
     **/
    func initFCL(network: Flow.ChainID) {
        let accountProof = FCL.Metadata.AccountProofConfig(appIdentifier: "Flow Catalog v(0.0)")
        let walletConnect = FCL.Metadata.WalletConnectConfig(urlScheme: "flowCatalog://", projectID: "c284f5a3346da817aeca9a4e6bc7f935")
        let metadata = FCL.Metadata(appName: "Flow Catalog",
                                    appDescription: "Native Version of the Flow Catalog!",
                                    appIcon: URL(string: "https://placekitten.com/g/200/200")!,
                                    location: URL(string: "https://flow.org")!,
                                    accountProof: accountProof,
                                    walletConnectConfig: walletConnect)
        
        fcl.config(metadata: metadata,
                   env: network,
                   provider: fcl.currentProvider ?? .lilico)
        if(network == .mainnet){
            fcl.config.put("0xNFTCatalog", value: "0x49a7cda3a1eecc29")
        }else if (network == .testnet){
            fcl.config.put("0xNFTCatalog", value: "0x324c34e1c517e4db")
        }
    }
    
    
    /* Script to get Catalog in batches */
    var getCatalogScript: String =
            """
            import NFTCatalog from 0xNFTCatalog
            
                        pub fun main(batch : [UInt64]?): {String : NFTCatalog.NFTCatalogMetadata} {
                            if(batch == nil){
                                return NFTCatalog.getCatalog()
                            }
                            let catalog = NFTCatalog.getCatalog()
                            let catalogIDs = catalog.keys
                            var data : {String : NFTCatalog.NFTCatalogMetadata} = {}
                            var i = batch![0]
                            while i < batch![1] {
                                data.insert(key: catalogIDs[i], catalog[catalogIDs[i]]!)
                                i = i + 1
                            }
                            return data
                        }
            """
    /* Funtion to get Catalog in batches */
    private func getCatalog(result: FlutterResult, call: FlutterMethodCall) async {
        do{
            let args = call.arguments as! Dictionary<String, Any>
            let firstBatch = args["firstBatch"] as! Int
            let secondBatch = args["secondBatch"] as! Int
            
            let response = try await fcl.query {
                cadence {
                    getCatalogScript
                }
                arguments {
                    [.array([.uint64(UInt64(firstBatch)), .uint64(UInt64(secondBatch))])]
                }
            }.decode()
            result(response)
        }catch {
            print(error)
            result(error.localizedDescription)
        }
    }
    
    /**
     Functions to Get total of collections in catalog
     */
    private func getCatalogLength(result: FlutterResult) async {
        do{
            let response = try await fcl.query {
                cadence {
                    """
                    import NFTCatalog from 0xNFTCatalog
                    
                    pub fun main(): Int {
                        let catalog = NFTCatalog.getCatalog()
                        let catalogIDs = catalog.keys
                        return catalogIDs.length
                    }
                    """
                }
            }.decode()
            result(response)
        }catch {
            print(error)
            result(error.localizedDescription)
        }
    }
    
    /**
     Method to get FCL Current user
     */
    private func getCurrentUser(result: FlutterResult) {
        do {
            let response  = fcl.currentUser
            let jsonResponse = try response?.json()
            result(jsonResponse)
        }catch {
            print(error)
            result(error.localizedDescription)
        }
    }
    
    /**
     Method to Authenticate FCL user!
     */
    private func authenticateUser(result: FlutterResult) async {
        do {
            let response = try await fcl.authenticate()
            result(response.addr.description)
        }catch {
            print(error);
            result(error.localizedDescription)
        }
    }
    
    /**
     Method to Log out FCL user!
     */
    private func unauthenticate(result: FlutterResult) async {
        do {
            try await fcl.unauthenticate()
        }catch{
            print(error)
            result(error.localizedDescription)
        }
    }
    
}
