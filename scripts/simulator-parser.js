const util = require('util');
const exec = util.promisify(require('child_process').exec);
const fs = require('fs');
const path = require('path');

async function parseOutput() {
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

	//print simplified list of devices

	let _devicesList = [];

	for (let device of deviceList) {
		console.log(device.name);
		_devicesList.push(device.name);
	}

	// let path1=path.join('__dirname');

	fs.writeFile(__dirname + '/devices.txt', _devicesList.join('\n'), { encoding: 'utf8', flag: 'w' }, function(err) {
		if (err) throw err;
		// console.log('Saved!');
	});

	// console.log('stdout:', JSON.parse(stdout));
	// console.error('stderr:', stderr);
}
parseOutput();
