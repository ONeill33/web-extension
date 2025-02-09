#!/bin/bash

rm -R ./dist
mkdir ./dist

MANIFEST_FILE_NAME="manifest.json"
CSS_FILE_NAME="global.css"
MAIN_JS_FILE_NAME="main.js"
CONTENT_JS_FILE_NAME="ogkush.js"
BG_JS_FILE_NAME="background.js"

cleancss -o dist/$CSS_FILE_NAME $CSS_FILE_NAME 
echo "$CSS_FILE_NAME minified"

terser $MAIN_JS_FILE_NAME > ./dist/$MAIN_JS_FILE_NAME
echo "$MAIN_JS_FILE_NAME minified"
terser $CONTENT_JS_FILE_NAME > ./dist/$CONTENT_JS_FILE_NAME
echo "$CONTENT_JS_FILE_NAME minified"
terser $BG_JS_FILE_NAME > ./dist/$BG_JS_FILE_NAME
echo "$BG_JS_FILE_NAME  minified"


echo "Minification complete!"

cp -r res/ dist/res
cp -r util/ dist/util
cp -r libs/ dist/libs
cp  $MANIFEST_FILE_NAME ./dist/$MANIFEST_FILE_NAME

cd ./dist
sed -i "s/12345/$1/g" "$MANIFEST_FILE_NAME"

zip -qr -X "ogi-chrome.zip" * 
echo "Packing zip for chrome complete!"

# Modifing chrome-extension:// to moz-extension://
sed -i "s/chrome/moz/g" "$CSS_FILE_NAME"
zip -qrm -X "ogi-firefox.zip" * -x "ogi-chrome.zip"
echo "Packing zip for firefox complete!"
