import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
	override func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
		let datePickerChannel = FlutterMethodChannel(name: "date_picker", binaryMessenger: controller.binaryMessenger)

		datePickerChannel.setMethodCallHandler {
			(call: FlutterMethodCall, result: @escaping FlutterResult) in
			if call.method == "pickDate" {
				self.pickDate(call, result: result)
			} else {
				result(FlutterMethodNotImplemented)
			}
		}

		GeneratedPluginRegistrant.register(with: self)

		return super.application(application, didFinishLaunchingWithOptions: launchOptions)
	}

	@objc func dateChanged(datePicker: UIDatePicker) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		let selectedDate = dateFormatter.string(from: datePicker.date)
		// You can use the selectedDate here, for example, send it back to Flutter
		print(selectedDate)
	}

	private func pickDate(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
		let datePicker = UIDatePicker()
		datePicker.datePickerMode = .date
		datePicker.maximumDate = Date()

		


		datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
	}
}
