del uniflash.zip

SET ZIP="c:\program files\7-zip\7z.exe"
%ZIP% a -tzip -r -x!.svn -x!makeZip.bat uniflash.zip *.*

haxelib submit uniflash.zip
