# sieve-rig
XMRig for Android Phones

Right now you can use the XMRig from MoneroOcean, C3 or the original xmrig
[https://github.com/MoneroOcean/xmrig](https://github.com/MoneroOcean/xmrig)

[https://github.com/xmrig/xmrig](https://github.com/xmrig/xmrig)


**Note** androidxmrig.sh will give you the option to use the MoneroOcean xmrig, C3Pool xmrig, or the og xmrig. Please apply the necessary flags when first installing and when updating. 

#### Why do I have to use Monero Ocean XMRig?
Easy answer. Because of the algo-switching mechanisms, you'll contribute significantly more shares to the pool, hence receive more payments, then you would if you were to use the traditional XMRig on an Android phone. 

#### What is sieve-rig?
Really just XMRig. This repository just includes setup configs and any additional information to get sieve-rig (XMRig on Android) to work at it's optimal performance for the ARM chipset. It also automates compiling and installing dependencies for xmrig within termux. Use of **termux-zetakov** is strongly recommended. 

## Usage

Download your choice of config file. Precomipiled phone ones i.e., *Pixel3a_config.json* or the standard *config.json* which will perform benchmarking for your device. It is recommended to use the precompiled version if you have the same device as this includes optimal settings for the rig. If a precompiled version doesn't exist use the traidtional *config.json* and go through the benchmarking. **Note** androidxmrig.sh will choose a generic config file and perform benchmarking for your specific device. 

First copy `androidxmrig.sh` to your phone. Then in termux run the following:

```shell
$ chmod +x androidxmrig.sh
```

The run: `./androidxmrig.sh -h` which outputs the options menu:

```shell
$ ./androidxmrig.sh --help


         AndroidXmrig-mo v0.5.1  (Maimonides)
         
         Usage:
               ./androidxmrig.sh [options]
          
         Options: 
                   --update,     Update to the newsest stable release of xmrig (pass --mo, --c3 as well for those versions of xmrig).
                   --update-all, Update to the newsest release of xmrig and its dependencies.
                   --mo,         Update (or install) to the newest and untested xmrig-mo release from MoneroOcean.
                   --c3,         Update (or install) the newest xmrig-C3 from C3pool.  
                   -h|--help,    This help screen.

        Note: Not passing any flags will download original xmrig and will be unable to algo-switch on MO.
        Please use --mo flag if you are using this on MoneroOcean or --c3 if you are on C3Pool.

        
$ 
```

Run without any options, this will perform a fresh install on your phone. If you use the `--mo` flag this will git the MoneroOcean repo, same for `--c3`. Just note, this has not been tested by our crew and so we are unsure if it will compile on your phone. Please create an issue if you the script terminates or does not run through the benchmarking process. 

If you already have compiled **xmrig** on your phone and would like to update to the newest version (tested or MoneroOcean) append the *--update*  or *--update-all* flag to the end of the command and this will rebuild **xmrig** on your phone. 

### Note (Fresh Install)

This will install all necesary dependencies and compile **hwloc** and **xmrig** on your phone. Follow the instructions and enter the necessary information when presented with a prompt.

You may have to press enter twice as the phone uses `apt` to update dependecies and it requires permissions. 

Easy peasy lemon squeezy. 


## Phone specific config files

Please note that we have taken the time to upload configuration files that have successfully worked on various phones. **androidxmrig.sh** will create a generic configuration file and do a benchmarking test to find the optimal configuration. If you would like to submit your configuration file to us to host on this repository, don't hesitate to make a pull request or send the file direction to sieve [at] eratosthen.es

### Note (Algorithm Switching)

Some phones with < 6GB ram can and do have trouble when it algo-switches. If you notice your phone's xmrig quitting on you on a regular basis, you can append `~algo` to the end of the *pass* filed in the config file. This setting is your worker name and it will use the algo of your choosing.

Some efficieint MO algorithms are:
```
cn-pico
cn-heavy
astrobwt
```

They may not all get the same pay hashrate, but you can do the testing to find out what works best for you and your phone(s). 

# Donation


We are three strong minded individuals who developed SIEVE of Eratosthenes Technology - an immersive Monero project. If you would like to support our cause, as we are a donation only enterprise, please donate to the following Monero Address. Any amount is welcomed!

![https://www.getmonero.org](https://i.imgur.com/0x11LkT.png)

**8AVHiEq9tpnTycu3uXwCBA4qjTfMvLq7RSqV2egbDu2K6z7VasBq8M7Ljg9F9uHy2DVScyF8cQouVedUMHbkowjVA7Gsp6N**


