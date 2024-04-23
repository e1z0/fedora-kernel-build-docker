# Fedora kernel build (dockerized)

Docker image that contains all required tools to patch the Fedora kernel source and build the kernel.
I have designed this especially to automate the build process of the kernel for my retro era MacBook Pro 2006 Late. Which requires the patched radeon graphics driver to load vbios.bin firmware. Full documentation about it can be found [here](https://www.andreasbaumann.cc/blog/archlinux-macbook-a1211/). Because my old MacBook is too slow for building kernel locally, I can use much more powerful remote machine for this type of task.

# Usage

You just need to download kernel **[SRPM](https://koji.fedoraproject.org/koji/packageinfo?packageID=8)** image (that contains kernel source code tree and all necessary Fedora patches with build rules).

```
make prepare    # build docker image
make enter      # enter build environment (if necessary)
make            # build kernel that is defined in the .env file
```

# .env File

Before building please redefine **RPM** and **PATCH** variables in **.env** file, these are necessary

* **PATCH** -> Is filename in the src directory which is patch, created by diff tool. Example.: radeon_vbios_fix.patch
* **RPM** -> Is fedora kernel rpm source, usually its around 140-150mb in size. Example.: kernel-6.8.7-200.fc39.src.rpm
* **OUTDIR** -> Is the output directory, in which complete kernel builds will be finally copied.
