#!/bin/sh

echo "Unpacking source..."
rpm -Uvh ~/src/${RPM}
echo "Tagging the kernel.."
sed -i 's/# define buildid .local/%define buildid _e1z0_mbp/g' ~/rpmbuild/SPECS/kernel.spec
echo "Preparing the patch..."
cp ~/src/${PATCH} ~/rpmbuild/SOURCES/linux-kernel-test.patch
cd ~/rpmbuild/SPECS
echo "Extracting the kernel tree..."
rpmbuild -bp kernel.spec
echo "Building the kernel..."
time rpmbuild -bb \
  --without debug --without doc --without tools --without debuginfo \
  --without kdump --without bootwrapper --without cross_headers \
  --nocheck --noclean --noprep \
  --target=x86_64 kernel.spec 2>&1 | tee ~/rpm-out
echo "Copying rpm to out directory..."
cp ~/rpmbuild/RPMS/x86_64/* ~/${OUTDIR}/
echo "Build finished!"
