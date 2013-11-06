LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := AVIPlayer
LOCAL_SRC_FILES := \
	Common.cpp \
	com_apress_aviplayer_AbstractPlayerActivity.cpp \
	com_apress_aviplayer_BitmapPlayerActivity.cpp

# Add NEON optimized version on armeabi-v7a
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
	LOCAL_SRC_FILES += BrightnessFilter.cpp.neon
	LOCAL_STATIC_LIBRARIES += cpufeatures
else
	LOCAL_SRC_FILES += BrightnessFilter.cpp
endif

# Use AVILib static library 
LOCAL_STATIC_LIBRARIES += avilib_static

#step 1/5 add NDK-profile
#################################
LOCAL_CFLAGS += -pg
# Android NDK Profiler enabled
MY_ANDROID_NDK_PROFILER_ENABLED := true

# If Android NDK Profiler is enabled
ifeq ($(MY_ANDROID_NDK_PROFILER_ENABLED),true)

# Show message
$(info GNU Profiler is enabled)

# Enable the monitor functions
LOCAL_CFLAGS += -DMY_ANDROID_NDK_PROFILER_ENABLED

#OK;;$NDK/source/android-ndk-profiler/jni/Android.mk
#LOCAL_STATIC_LIBRARIES += andprof

#OK;;$NDK/source/android-ndk-profiler/libandroid-ndk-profiler.a
LOCAL_STATIC_LIBRARIES += android-ndk-profiler


endif

#################################

# Link with JNI graphics
LOCAL_LDLIBS += -ljnigraphics

include $(BUILD_SHARED_LIBRARY)

#step 1/5 add NDK-profile
#################################
# If Android NDK Profiler is enabled
ifdef MY_ANDROID_NDK_PROFILER_ENABLED

#OK;$NDK/source/android-ndk-profiler/jni
#$(call import-module, android-ndk-profiler/jni)

#OK;$NDK/source/android-ndk-profiler
$(call import-module, ndk-profiler)
endif
#################################

# Add CPU features on armeabi-v7a
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
# Import Android CPU features
$(call import-module, android/cpufeatures)
endif



# Import AVILib library module
$(call import-module, transcode-115/avilib)

#//step 4/5   add NDK-profile cmd
#use cmd
#%ANDROID_NDK_HOME%\toolchains\arm-linux-androideabi-4.6\prebuilt\windows\bin\arm- 
#linux-androideabi-gprof.exe obj\local\armeabi-v7a\libAVIPlayer.so gmon.out


