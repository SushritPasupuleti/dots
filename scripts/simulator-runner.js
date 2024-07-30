const args = process.argv;

const util = require('util');
const exec = util.promisify(require('child_process').exec);

if (args.length < 3) {
	console.error('No device name provided');
	return;
}

const deviceName = args[2];

async function parseOutput(deviceName) {
	const {
		stdout,
		stderr
	} = await exec('xcrun simctl list devices available -j');

	if (stderr) {
		console.error('stderr:', stderr);
		return;
	}

	let devices = JSON.parse(stdout).devices;
	let deviceList = [];
	for (let [key, value] of Object.entries(devices)) {
		for (let device of value) {
			deviceList.push(device);
		}
	}
	// console.log(deviceList);

	if (deviceList.length === 0) {
		console.error('No devices found');
		return;
	}

	//find uuid of device by name

	for (let device of deviceList) {
		if (device.name === deviceName) {
			console.log("Found: ", device.udid);
			try {
				await exec('open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/');
			} catch (e) { }
			try {
				//will throw an exception if the given device is already running
				await exec('xcrun simctl boot ' + device.udid);
			} catch (e) { }
			return;
		}
	}

	// console.log('stdout:', JSON.parse(stdout));
	// console.error('stderr:', stderr);
}

parseOutput(deviceName);

