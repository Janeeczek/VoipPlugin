mport CallKit

@objc(VoipPlugin)
class VoipPlugin : CDVPlugin, CXProviderDelegate {
    var calbackID:String = ""
    var actualCall: UUID = UUID()
    var myProvider: CXProvider = CXProvider(configuration: CXProviderConfiguration(localizedName: "TODO"))
    func providerDidReset(_ provider: CXProvider) {
        
    }
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK,messageAs: "callAccepted")
        action.fulfill()
        //myProvider.reportCall(with: action.callUUID, endedAt: Date()+1, reason: .failed)
        //myProvider.invalidate()
        let controller = CXCallController()
        let transaction = CXTransaction(action: CXEndCallAction(call: action.callUUID))
        controller.request(transaction,completion: { error in })
        pluginResult?.keepCallback = false
        commandDelegate.send(pluginResult, callbackId:calbackID)
        return
    }

    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK,messageAs: "callRejected")
        action.fulfill()
        //myProvider.invalidate()
        pluginResult?.keepCallback = false
        commandDelegate.send(pluginResult, callbackId:calbackID)
        return
    }
    
    override func pluginInitialize() {
        super.pluginInitialize()
        print("VoipPlugin :: Inizjalizacja")
        myProvider = CXProvider(configuration: CXProviderConfiguration(localizedName: "TODO"))
        myProvider.configuration.supportedHandleTypes = [.phoneNumber]
        myProvider.setDelegate(self, queue: nil)
    }
    @objc(receiveCall:)
    func receiveCall( command: CDVInvokedUrlCommand) {
        print("VoipPlugin :: startCall is called")
        calbackID = command.callbackId
        let param = command.arguments[0] as? String
        var callerName = ""
        if param != nil {
            callerName = param!
        }
        if callerName.isEmpty == true {
            callerName = "DOMYŚLNY"
        }
        
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: callerName)
        
        myProvider.reportNewIncomingCall(with: UUID(), update: update, completion: { error in })
        
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK,messageAs: "callStarted")
        pluginResult?.keepCallback = true
        commandDelegate.send(pluginResult, callbackId:command.callbackId)
    }
}
