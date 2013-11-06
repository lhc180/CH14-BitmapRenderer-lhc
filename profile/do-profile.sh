echo " =========="
echo "do profile with arm-linux-androideabi-gprof"


echo "get gmon.out form /sdcard/"


#index=`date +%d%H`
#adb pull /sdcard/gmon.out ./gmon.out-$index
#$NDK/toolchains/arm-linux-androideabi-4.6/prebuilt/windows/bin/arm-linux-androideabi-gprof.exe ../obj/local/armeabi-v7a/libAVIPlayer.so gmon.out-$index


echo " $NDK/toolchains/arm-linux-androideabi-4.6/prebuilt/windows/bin/arm-linux-androideabi-gprof.exe ../obj/local/armeabi-v7a/libAVIPlayer.so gmon.out"
$NDK/toolchains/arm-linux-androideabi-4.6/prebuilt/windows/bin/arm-linux-androideabi-gprof.exe ../obj/local/armeabi-v7a/libAVIPlayer.so gmon.out

echo " save profile to profile.txt"
$NDK/toolchains/arm-linux-androideabi-4.6/prebuilt/windows/bin/arm-linux-androideabi-gprof.exe ../obj/local/armeabi-v7a/libAVIPlayer.so gmon.out >profile.txt

echo " =========="
echo " =========="