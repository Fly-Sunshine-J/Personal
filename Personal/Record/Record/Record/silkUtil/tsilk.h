#ifndef _TSILK_HEADER_FILE_
#define _TSILK_HEADER_FILE_

#ifdef _cplusplus
extern "C" {
#endif

/*
	src     : in audio
	src_len : in audio length
	dst     : out audio space
	dst_len : dst space size
	hz      : sampling rate
	return  : ==0 : faild, >0 : if return>dst_len then not enough space else success.
*/
int tsilk_encode(const void * src, int src_len, void * dst, int dst_len, int hz);

/*
	src     : in audio
	src_len : in audio length
	dst     : out audio space
	dst_len : dst space size
	hz      : sampling rate
	return  : ==0 : faild, >0 : if return>dst_len then not enough space else success.
*/
int tsilk_decode(const void * src, int src_len, void * dst, int dst_len, int hz);

/*
	src     : in audio
	src_len : in audio length
	dst     : out audio space
	dst_len : dst space size
	hz      : sampling rate, 8000 or 16000
	level   : [0, 10]
	return  : ==0 : faild, >0 : if return>dst_len then not enough space else success.
*/
int tsilk_encode_vcyber(const void * src, int src_len, void * dst, int dst_len, int hz, int level);

/*
	src     : in audio
	src_len : in audio length
	dst     : out audio space
	dst_len : dst space size
	hz      : sampling rate, 8000 or 16000
	return  : ==0 : faild, >0 : if return>dst_len then not enough space else success.
*/
int tsilk_decode_vcyber(const void * src, int src_len, void * dst, int dst_len, int hz);

#ifdef _cplusplus
}
#endif

#ifndef TSILK_EXPORT
#	ifdef _WIN64
#		ifdef _DEBUG
#			pragma comment(lib, "d64/tsilk.lib")
#		else
#			pragma comment(lib, "r64/tsilk.lib")
#		endif
#	else
#		ifdef _DEBUG
#			pragma comment(lib, "d32/tsilk.lib")
#		else
#			pragma comment(lib, "r32/tsilk.lib")
#		endif
#	endif
#endif

#endif
