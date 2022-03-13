all:
	rm -f bombjack_result.raw && rm -f bombjack_result.pal && ilbm2raw bombjack_result.iff bombjack_result.raw -p bombjack_result.pal
	rm -f "tiles/sanddown.raw" && rm -f "tiles/sanddown.pal" && ilbm2raw "tiles/sanddown.iff" "tiles/sanddown.raw" -p "tiles/sanddown.pal"
	rm -f "tiles/sandtop.raw" && rm -f "tiles/sandtop.pal" && ilbm2raw "tiles/sandtop.iff" "tiles/sandtop.raw" -p "tiles/sandtop.pal"
	rm -f "tiles/full.raw" && rm -f "tiles/full.pal" && ilbm2raw "tiles/full.iff" "tiles/full.raw" -p "tiles/full.pal"
	rm -f "tiles/rightslope.raw" && rm -f "tiles/rightslope.pal" && ilbm2raw "tiles/rightslope.iff" "tiles/rightslope.raw" -p "tiles/rightslope.pal"

	rm -f "brush/pyramidtop112x54.raw" && rm -f "brush/pyramidtop112x54.pal" && ilbm2raw "brush/pyramidtop112x54.brush" "brush/pyramidtop112x54.raw" -p "brush/pyramidtop112x54.pal"
	rm -f "brush/platform16x5.raw" && rm -f "brush/platform16x5.pal" && ilbm2raw "brush/platform16x5.brush" "brush/platform16x5.raw" -p "brush/platform16x5.pal"


	# bombs
	rm -f bombs/1.raw && ilbm2raw  "bombs/1_risultato.iff" "bombs/1.raw"