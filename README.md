# sieve-rig
XMRig for Android Phones

Right now you can use the XMRig from MoneroOcean
[https://github.com/MoneroOcean/xmrig](https://github.com/MoneroOcean/xmrig)

Or the one we host
[https://github.com/protomens/xmrig](https://github.com/protomens/xmrig)

The only different between the two is that **protomens** xmrig will be purposely kept back several commits from the **MoneroOcean** one. This is due to testing the new commits on Android Phones which can be time consuming. It is unlikely we will be making any changes to the code, but it could happen to create compatability with Android for new versions of xmrig. Just be mindful to check where each one is at on the branch. 

#### Why do I have to use Monero Ocean XMRig?
Easy answer. Because of the algo-switching mechanisms, you'll contribute significantly more shares to the pool, hence receive more payments, then you would if you were to use the traditional XMRig on an Android phone. 

#### What is sieve-rig?
Really just XMRig. This repository just includes setup configs and any additional information to get sieve-rig (XMRig on Android) to work at it's optimal performance for the chipset. 

## Usage
Download your choice of config file. Precomipiled phone ones i.e., *Pixel3a_config.json* or the standard *config.json* which will perform benchmarking for your device. It is recommended to use the precompiled version if you have the same device as this includes optimal settings for the rig. If a precompiled version doesn't exist use the traidtional *config.json* and go through the benchmarking.

Begin by running the following:

```
$ git clone https://github.com/zetakov/sieve-rig
$ cd sieve-rig && chmod +x *
$ ./editconfig.sh <MoneroAddress> <WorkerName> <config.json>
$ mv <config.json> config.json (if necessary)
```

Be sure to include quotes in the **WorkerName** of it contains spaces. That's it. Start your xmrig instance and it will either do benchmarking or begin mining right away. 

# Donation


We are three strong minded individuals who developed SIEVE of Eratosthenes Technology - an all-encompassing Monero project. If you would like to support our cause, please donate to the following Monero Address. Any amount is welcomed!

![https://www.getmonero.org](https://i.imgur.com/0x11LkT.png)

**8AVHiEq9tpnTycu3uXwCBA4qjTfMvLq7RSqV2egbDu2K6z7VasBq8M7Ljg9F9uHy2DVScyF8cQouVedUMHbkowjVA7Gsp6N**


