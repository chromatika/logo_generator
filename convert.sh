input=chromatika.png
inputWE="${input%.*}"


sizes="120x120 144x144 152x152 16x16 192x192 256x256 32x32 36x36 48x48 512x512 60x60 72x72 76x76 96x96"

for i in $sizes
do
  echo $i
  convert $input -resize $i ${inputWE}_${i}.png
done

