all:
	cd ../AProcessing && git reset --hard remotes/origin/main && cd ..
	cd ../AProcessing && git am < ../patches/0001-blitline-stripped.patch && cd ../patches
	cd ../AProcessing && git am < ../patches/0001-offbitplane-mem-into-bitplanes-fast.patch && cd ../patches
	cd ../AProcessing && git am < ../patches/0001-matrixreg-stripped.patch && cd ..