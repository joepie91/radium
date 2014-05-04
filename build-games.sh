for f in gemswap/source/*.svg
do
  name=${f%%.*}
  name=${name##*/}
  echo "Processing $f..."
  inkscape --export-png=gemswap/assets/images/$name.png $f
done
