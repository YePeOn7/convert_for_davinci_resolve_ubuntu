QUALITY=30

# available codec can be checked by using "ffmpeg -encoders"
#========= Audio Codec Setting =========#
AUDIO_CODEC=pcm_s16be
# AUDIO_CODEC = pcm_f32be

#========= Video Codec Setting =========#
# VIDEO_CODEC=hevc_nvenc
# VIDEO_CODEC=nvenc_h264
# VIDEO_CODEC=nvenc
VIDEO_CODEC=copy

if [ ! -d transcoded ]; then
    mkdir transcoded
    echo "Creating transcoded folder..."
fi

if [ $VIDEO_CODEC != copy ]; then
    for i in *.mp4; do
    OUTPUT_FILE=transcoded/${i%.*}_${VIDEO_CODEC}.mov
	    if [ ! -f "$OUTPUT_FILE" ];then
            echo "ffmpeg -i \"$i\" -c:v ${VIDEO_CODEC} -rc vbr_hq -cq ${QUALITY} -c:a ${AUDIO_CODEC} \"$OUTPUT_FILE\""
            ffm.conpeg -i \"$i\" -c:v ${VIDEO_CODEC} -rc vbr_hq -cq ${QUALITY} -c:a ${AUDIO_CODEC} "$OUTPUT_FILE"
        fi
    done
else
    for i in *.mp4; do
        OUTPUT_FILE=transcoded/${i%.*}_${VIDEO_CODEC}.mov
	    if [ ! -f "$OUTPUT_FILE" ]; then
            echo "ffmpeg -i \"$i\" -c:v copy -c:a ${AUDIO_CODEC} \"$OUTPUT_FILE\""
            ffmpeg -i "$i" -c:v copy -c:a ${AUDIO_CODEC} "$OUTPUT_FILE"
        fi
    done
fi
