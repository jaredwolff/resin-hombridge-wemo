# resin-hombridge-wemo
Resin Docker container preconfigured for Wemo operation.

I'm currently running my setup on a Hummingboard but this can be adapted for any other type of board that they support. More info on what boards Resin supports and to download the image for the device you have go [here](https://resinos.io/#downloads).

## Resin OS Instructions

Resin's documentation is awesome. Feel free to look at it [here](https://resinos.io/docs/cubox-i/gettingstarted/). Otherwise see below:

1. Install dependencies. On Mac, *Node* is the only thing you may need to install. Homebrew works best here.

```
brew install node
```

1. Download and install the `resin-cli`:

```
npm install --global --production resin-cli
```

1. Download your image from the [download link](https://resinos.io/#downloads) if you haven't already.

1. Modify the image to your liking by using the cli.

```
$ sudo resin local configure ~/Downloads/resin.img
? Network SSID Wolff Den
? Network Key This is not our password.
? Do you want to set advanced settings? Yes
? Device Hostname resin
? Do you want to enable persistent logging? no
Done!
```

1. "Flash" the image to an SD card. Make sure you have a free device to write to!

```
$ sudo resin local flash ~/Downloads/resin.img
Password:
? Select drive (Use arrow keys)
❯ /dev/disk1 (32 GB) - RESIN
```

1. Wait for the process to complete and then eject the card. Pop it into the device you've configured the image for.

1. Once booted, you should be able to ping the device.

```
ping resin.local
PING resin.local (192.168.7.45): 56 data bytes
64 bytes from 192.168.7.45: icmp_seq=0 ttl=64 time=9.004 ms
64 bytes from 192.168.7.45: icmp_seq=1 ttl=64 time=6.411 ms
64 bytes from 192.168.7.45: icmp_seq=2 ttl=64 time=4.337 ms
64 bytes from 192.168.7.45: icmp_seq=3 ttl=64 time=4.374 ms
```

1. Modify the `config.json` file to your liking. Highly suggest changing the pin to something different as this is the one that Homebridge uses in their examples.

1. You can now push the included Homebridge Docker file and associated files directly to your embedded device.

```
sudo resin local push resin.local --source .
```

*Note: this will take several minutes as it will be building the docker image on the embedded device. This takes much less time using the Resin.io platoform as it builds on your local machine and then sent to the embedded device as a complete image*

1. Wait to see the output from Homebridge indicating it's running.

```
rdt push completed successfully!
* Streaming application logs..
*** WARNING *** The program 'node' uses the Apple Bonjour compatibility layer of Avahi.
*** WARNING *** Please fix your application to use the native API of Avahi!
*** WARNING *** For more information see <http://0pointer.de/avahi-compat?s=libdns_sd&e=node>
*** WARNING *** The program 'node' called 'DNSServiceRegister()' which is not supported (or only supported partially) in the Apple Bonjour compatibility layer of Avahi.
*** WARNING *** Please fix your application to use the native API of Avahi!
*** WARNING *** For more information see <http://0pointer.de/avahi-compat?s=libdns_sd&e=node&f=DNSServiceRegister>
[2017-11-2 02:09:43] Loaded plugin: homebridge-platform-wemo
[2017-11-2 02:09:43] Registering platform 'homebridge-platform-wemo.BelkinWeMo'
[2017-11-2 02:09:43] ---
[2017-11-2 02:09:43] Loaded config.json with 0 accessories and 1 platforms.
[2017-11-2 02:09:43] ---
[2017-11-2 02:09:43] Loading 1 platforms...
[2017-11-2 02:09:43] [WeMo Platform] Initializing BelkinWeMo platform...
Scan this code with your HomeKit App on your iOS device to pair with Homebridge:

    ┌────────────┐     
    │ 031-45-154 │     
    └────────────┘     

[2017-11-2 02:09:43] Homebridge is running on port 51826.
[2017-11-2 02:09:43] [WeMo Platform] Found: Master Den [123456789ABC]
[2017-11-2 02:09:43] [WeMo Platform] Found: Jarchel Den [123456789BAC]
[2017-11-2 02:09:43] [WeMo Platform] Found: Front Door Light [123456789CBA]
[2017-11-2 02:09:44] [WeMo Platform] Jarchel Den - Get state: On
```

1. Pop open your phone and look for an available acessory in Homekit. You will likely have to tap on "Don't Have a Code or Can't Scan?" and enter the number manually.

![Homekit - Add accessory](img/IMG_0154.png)
![Homekit - Nearby devices](img/IMG_0155.png)

1. Add your accessory by entering the passcode displayed earlier.

![Homekit - After passcode](img/IMG_0157.png)
![Homekit - Completed](img/IMG_0158.png)

1. Congrats! All your Wemo devices should show up now. Enjoy using Siri with your Wemo devices.

![Homekit - Success](img/IMG_0153.png)
