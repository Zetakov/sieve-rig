# sieve-rig
XMRig for Android Phones

Right now you can use the XMRig from MoneroOcean
[https://github.com/MoneroOcean/xmrig](https://github.com/MoneroOcean/xmrig)

Or the one we host
[https://github.com/protomens/xmrig](https://github.com/protomens/xmrig)

The only different between the two is that **protomens** xmrig will be purposely kept back several commits from the **MoneroOcean** one. This is due to testing the new commits on Android Phones which can be time consuming. It is unlikely we will be making any changes to the code, but it could happen to create compatability with Android for new versions of xmrig. Just be mindful to check where each one is at on the branch. 

**Note** androidxmrig.sh will give you the option to use the MoneroOcean xmrig or the one we have tested. We have not made any modifications at this time. 

#### Why do I have to use Monero Ocean XMRig?
Easy answer. Because of the algo-switching mechanisms, you'll contribute significantly more shares to the pool, hence receive more payments, then you would if you were to use the traditional XMRig on an Android phone. 

#### What is sieve-rig?
Really just XMRig. This repository just includes setup configs and any additional information to get sieve-rig (XMRig on Android) to work at it's optimal performance for the ARM chipset. It also automates compiling and installing dependencies for xmrig within termux. Use of **termux-zetakov** is strongly recommended. 

## Usage

Download your choice of config file. Precomipiled phone ones i.e., *Pixel3a_config.json* or the standard *config.json* which will perform benchmarking for your device. It is recommended to use the precompiled version if you have the same device as this includes optimal settings for the rig. If a precompiled version doesn't exist use the traidtional *config.json* and go through the benchmarking. **Note** androidxmrig.sh will choose a generic config file and perform benchmarking for your specific device. 

First copy `androidxmrig.sh` to your phone. Then in termux run the following:

```
$ chmod +x androidxmrig.sh && ./androidxmrig.sh
```

The run: `./androidxmrig.sh -h` which outputs the options menu:

```
 AndroidXmrig-mo v0.3.0  (Burt Bacharach)
  
 Usage:
       ./androidxmrig.sh [options]
  
 Options: 
           --update,    Update to the newsest stable release of xmrig-mo.
           --mo,        Update to the newest and untested xmrig-mo release from MoneroOcean.
           -h|--help,   This help screen.
  
```

Run without any options, this will perform a fresh install on your phone. If you use the `--mo` flag this will git the MoneroOcean repo. Just note, this has not been tested by our crew and so we are unsure if it will compile on your phone. If you want a tried and tested **xmrig-mo** exclude the *--mo* flag. 

If you already have compiled **xmrig** on your phone and would like to update to the newest version (tested or MoneroOcean) append the *--update* flag to the end of the command and this will rebuild **xmrig-mo** on your phone. 

### Note (Fresh Install)

This will install all necesary dependencies and compile **hwloc** and **xmrig-mo** on your phone. Follow the instructions and enter the necessary information when presented with a prompt.

Easy peasy lemon squeezy. 


## Phone specific config files

Please note that we have taken the time to upload configuration files that have successfully worked on various phones. **androidxmrig.sh** will create a generic configuration file and do a benchmarking test to find the optimal configuration. If you would like to submit your configuration file to us to host on this repository, don't hesitate to make a pull request or send the file direction to sieve [at] eratosthen.es

### Note

If you run into xmrig quitting on you on a regular basis, it is advised that you find what algorithm your phone is optimized for (just look at the xmrig output), and append **~algoirthm** to the end of your **WorkerName** (which is the **pass** field in the configuration file)

# Donation


We are three strong minded individuals who developed SIEVE of Eratosthenes Technology - an immersive Monero project. If you would like to support our cause, as we are a donation only enterprise, please donate to the following Monero Address. Any amount is welcomed!

![https://www.getmonero.org](https://i.imgur.com/0x11LkT.png)

**8AVHiEq9tpnTycu3uXwCBA4qjTfMvLq7RSqV2egbDu2K6z7VasBq8M7Ljg9F9uHy2DVScyF8cQouVedUMHbkowjVA7Gsp6N**


