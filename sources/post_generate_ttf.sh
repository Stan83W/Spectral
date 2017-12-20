for i in *.ttf; do
    python ../fix_weightcodes.py "$i"
    echo "Processing $i ..."
done
for i in *.ttf ; do mv $i ${i//#1/} ; done
for i in Spectral-Regular Spectral-Bold Spectral-Italic Spectral-BoldItalic; do
	ttfautohint -i -n -f latn -m ../hinting/$i.ctrl $i.ttf $i.hinted.ttf
  echo "Hinting $i ..."
done
for i in Spectral-ExtraBold Spectral-ExtraBoldItalic Spectral-ExtraLight Spectral-ExtraLightItalic Spectral-Light Spectral-LightItalic Spectral-Medium Spectral-MediumItalic Spectral-SemiBold Spectral-SemiBoldItalic; do
	ttfautohint -i -n -f latn $i.ttf $i.hinted.ttf
  echo "Hinting $i ..."
done
for i in *.ttf ; do mv $i ${i//.hinted/} ; done

# Update fsType
fontbakery fix-fstype *.ttf
rm *.ttf
for i in *.fix ; do mv $i $(basename -s .fix $i) ; done

# Add DSIG table
fontbakery fix-dsig *.ttf -a -f

# Add GASP table
fontbakery fix-gasp *.ttf --autofix
for i in *.fix ; do mv $i $(basename -s .fix $i) ; done