extern "C" {
#include <avilib.h>
}
//step 3/5   add NDK-profile prof.h
#ifdef MY_ANDROID_NDK_PROFILER_ENABLED
#include <prof.h>
#endif

#include "Common.h"
#include "com_apress_aviplayer_AbstractPlayerActivity.h"

jlong Java_com_apress_aviplayer_AbstractPlayerActivity_open(
		JNIEnv* env,
		jclass clazz,
		jstring fileName)
{
	avi_t* avi = 0;

#ifdef MY_ANDROID_NDK_PROFILER_ENABLED
	// Start collecting the samples
	monstartup("libAVIPlayer.so");
#endif

	// Get the file name as a C string
	const char* cFileName = env->GetStringUTFChars(fileName, 0);
	if (0 == cFileName)
	{
		goto exit;
	}

	// Open the AVI file
	avi = AVI_open_input_file(cFileName, 1);

	// Release the file name
	env->ReleaseStringUTFChars(fileName, cFileName);

	// If AVI file cannot be opened throw an exception
	if (0 == avi)
	{
		ThrowException(env, "java/io/IOException", AVI_strerror());
	}

exit:
	return (jlong) avi;
}

jint Java_com_apress_aviplayer_AbstractPlayerActivity_getWidth(
		JNIEnv* env,
		jclass clazz,
		jlong avi)
{
	return AVI_video_width((avi_t*) avi);
}

jint Java_com_apress_aviplayer_AbstractPlayerActivity_getHeight(
		JNIEnv* env,
		jclass clazz,
		jlong avi)
{
	return AVI_video_height((avi_t*) avi);
}

jdouble Java_com_apress_aviplayer_AbstractPlayerActivity_getFrameRate(
		JNIEnv* env,
		jclass clazz,
		jlong avi)
{
	return AVI_frame_rate((avi_t*) avi);
}

void Java_com_apress_aviplayer_AbstractPlayerActivity_close(
		JNIEnv* env,
		jclass clazz,
		jlong avi)
{
	AVI_close((avi_t*) avi);

	//step 3/5
#ifdef MY_ANDROID_NDK_PROFILER_ENABLED
	// Store the collected data
	moncleanup();
#endif
}
