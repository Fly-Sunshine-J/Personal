#include "tsilk.h"
#include "SKP_Silk_SDK_API.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_BYTES_PER_FRAME_E   250
#define MAX_BYTES_PER_FRAME_D   1024
#define MAX_INPUT_FRAMES        5
#define FRAME_LENGTH_MS         20
#define MAX_API_FS_KHZ          48
#define MAX_LBRR_DELAY          2

#define g_free(x) do{if(*(x)){free(*(x));*(x)=0;}}while(0)

int tsilk_encode(const void * x_vSrc, int x_nSrcLen, void * x_vDst, int x_nDstLen, int x_nHz)
{
	if(x_nHz!=8000 && x_nHz!=12000 && x_nHz!=16000 && x_nHz!=24000 && x_nHz!=32000 && x_nHz!=44100 && x_nHz!=48000)
	{
		return 0;
	}

	if(x_vSrc==NULL || x_nSrcLen < x_nHz * 3 / 50)
	{
		return 0;
	}

	const char * pSrc = (const char *)x_vSrc;
	const int nSrcLen = x_nSrcLen;
	const int nHz = x_nHz;

	int err = 0;
	int rt = 0;
	SKP_int32 nEncSize = 0;
	void * hEnc = NULL;
	SKP_SILK_SDK_EncControlStruct tEnc;
	SKP_int16 * audio_in = NULL;
	SKP_uint8 * audio_out = NULL;
	SKP_int16 in_len = 960;
	SKP_int16 out_len = 1250;
	const int in_size = FRAME_LENGTH_MS * MAX_API_FS_KHZ * MAX_INPUT_FRAMES * sizeof(SKP_int16);
	const int out_size = MAX_BYTES_PER_FRAME_E * MAX_INPUT_FRAMES * sizeof(SKP_uint8);
	int nl = 0;
	int nr = 0;
	char * buf = NULL;

	buf = (char *)malloc(nSrcLen);
	if(buf==NULL)
	{
		goto lab_err;
	}

	audio_in = (SKP_int16 *)malloc(in_size);
	if(audio_in==NULL)
	{
		goto lab_err;
	}

	audio_out = (SKP_uint8 *)malloc(out_size);
	if(audio_out==NULL)
	{
		goto lab_err;
	}

	rt = SKP_Silk_SDK_Get_Encoder_Size(&nEncSize);
	if(rt)
	{
		goto lab_err;
	}

	hEnc = malloc(nEncSize);
	if(hEnc==NULL)
	{
		goto lab_err;
	}

	rt = SKP_Silk_SDK_InitEncoder(hEnc, &tEnc);
	if(rt)
	{
		goto lab_err;
	}

	tEnc.API_sampleRate        = nHz;
	tEnc.maxInternalSampleRate = 24000;
	tEnc.packetSize            = nHz * 3 / 50;
	tEnc.bitRate               = nHz;
	tEnc.packetLossPercentage  = 0;
	tEnc.complexity            = 0;
	tEnc.useInBandFEC          = 0;
	tEnc.useDTX                = 0;

	while(1)
	{
		if(in_len>=nSrcLen-nl)
		{
			break;
		}

		memcpy(audio_in, pSrc + nl, in_len);
		nl += in_len;
		out_len = out_size;

		rt = SKP_Silk_SDK_Encode(hEnc, &tEnc, audio_in, in_len / 2, audio_out, &out_len);
		if(rt)
		{
			goto lab_err;
		}

		memcpy(buf + nr, &out_len, sizeof(SKP_int16));
		nr += sizeof(SKP_int16);

		memcpy(buf + nr, audio_out, out_len);
		nr += out_len;
	}

	if(x_vDst!=NULL && x_nDstLen>=nr)
	{
		memcpy(x_vDst, buf, nr);
	}

	err = nr;

	lab_err:
	g_free(&hEnc);
	g_free(&audio_in);
	g_free(&audio_out);
	g_free(&buf);
	return err;
}

int tsilk_decode(const void * x_vSrc, int x_nSrcLen, void * x_vDst, int x_nDstLen, int x_nHz)
{
	if(x_nHz!=8000 && x_nHz!=12000 && x_nHz!=16000 && x_nHz!=24000 && x_nHz!=32000 && x_nHz!=44100 && x_nHz!=48000)
	{
		return 0;
	}

	if(x_vSrc==NULL || x_nSrcLen<=0)
	{
		return 0;
	}

	const char * pSrc = (const char *)x_vSrc;
	const int nSrcLen = x_nSrcLen;
	const int nHz = x_nHz;

	int err = 0;
	int rt = 0;
	SKP_int32 nDecSize = 0;
	void * hDec = NULL;
	short in_len = 0;
	short out_len = 0; 
	int nl = 0;
	int nr = 0;
	int nk = 0;
	SKP_SILK_SDK_DecControlStruct tDec;
	char * buf = NULL;
	int buf_size = nSrcLen * 32;
	SKP_uint8 * audio_in = NULL;
	SKP_int16 * audio_out = NULL;
	const int in_size = MAX_BYTES_PER_FRAME_D * MAX_INPUT_FRAMES * (MAX_LBRR_DELAY + 1) * sizeof(SKP_uint8);
	const int out_size = FRAME_LENGTH_MS * MAX_API_FS_KHZ * MAX_INPUT_FRAMES * 2;

	buf = (char *)malloc(buf_size);
	if(buf==NULL)
	{
		goto lab_err;
	}

	audio_in = (SKP_uint8 *)malloc(in_size);
	if(audio_in==NULL)
	{
		goto lab_err;
	}

	audio_out = (SKP_int16 *)malloc(out_size * sizeof(SKP_int16));
	if(audio_out==NULL)
	{
		goto lab_err;
	}

	rt = SKP_Silk_SDK_Get_Decoder_Size(&nDecSize);
	if(rt)
	{
		goto lab_err;
	}

	hDec = malloc(nDecSize);
	if(hDec==NULL)
	{
		goto lab_err;
	}

	rt = SKP_Silk_SDK_InitDecoder(hDec);
	if(rt)
	{
		goto lab_err;
	}

	tDec.API_sampleRate = nHz;
	tDec.frameSize = 0;
	tDec.framesPerPacket = 1;
	tDec.moreInternalDecoderFrames = 0;
	tDec.inBandFECOffset = 0;

	while(1)
	{
		if(nSrcLen-nl<sizeof(SKP_int16))
		{
			break;
		}

		memcpy(&in_len, pSrc + nl, sizeof(SKP_int16));
		nl += sizeof(SKP_int16);

		if(in_len<=0)
		{
			continue;
		}

		if(in_size<in_len || in_len>nSrcLen-nl)
		{
			break;
		}

		memcpy(audio_in, pSrc + nl, in_len);
		nl += in_len;

		nk = 0;
		do
		{
			out_len = out_size - nk;
			rt = SKP_Silk_SDK_Decode(hDec, &tDec, 0, audio_in, in_len, audio_out + nk, &out_len);
			if(rt)
			{
				goto lab_err;
			}
			nk += out_len;
		}while(tDec.moreInternalDecoderFrames);
		nk *= sizeof(SKP_int16);

		if(nk>buf_size-nr)
		{
			void * pt = realloc(buf, buf_size - nr + nk);
			if(pt==NULL)
			{
				goto lab_err;
			}
			buf = (char *)pt;
			buf_size = buf_size - nr + nk;
		}

		memcpy(buf+nr, audio_out, nk);
		nr += nk;
	}

	if(x_vDst!=NULL && x_nDstLen>=nr)
	{
		memcpy(x_vDst, buf, nr);
	}

	err = nr;

	lab_err:
	g_free(&hDec);
	g_free(&audio_in);
	g_free(&audio_out);
	g_free(&buf);
	return err;
}

int tsilk_encode_vcyber(const void * x_vSrc, int x_nSrcLen, void * x_vDst, int x_nDstLen, int x_nHz, int x_nLevel)
{
	if(x_vSrc==NULL || (x_nHz!=8000 && x_nHz!=16000) || x_nSrcLen < x_nHz * 3 / 50 || x_nLevel<0 || x_nLevel>10)
	{
		return 0;
	}

	const char * pSrc = (const char *)x_vSrc;
	const int nSrcLen = x_nSrcLen;
	const int nHz = x_nHz;
	const int nLevel = x_nLevel;

	int err = 0;
	int rt = 0;
	SKP_int32 nEncSize = 0;
	void * hEnc = NULL;
	SKP_SILK_SDK_EncControlStruct tEnc;
	SKP_int16 * audio_in = NULL;
	SKP_uint8 * audio_out = NULL;
	SKP_int16 in_len = 960;
	SKP_int16 out_len = 1250;
	const int in_size = FRAME_LENGTH_MS * MAX_API_FS_KHZ * MAX_INPUT_FRAMES * sizeof(SKP_int16);
	const int out_size = MAX_BYTES_PER_FRAME_E * MAX_INPUT_FRAMES * sizeof(SKP_uint8);
	int nl = 0;
	int nr = 0;
	char * buf = NULL;

	buf = (char *)malloc(nSrcLen);
	if(buf==NULL)
	{
		goto lab_err;
	}

	audio_in = (SKP_int16 *)malloc(in_size);
	if(audio_in==NULL)
	{
		goto lab_err;
	}

	audio_out = (SKP_uint8 *)malloc(out_size);
	if(audio_out==NULL)
	{
		goto lab_err;
	}

	rt = SKP_Silk_SDK_Get_Encoder_Size(&nEncSize);
	if(rt)
	{
		goto lab_err;
	}

	hEnc = malloc(nEncSize);
	if(hEnc==NULL)
	{
		goto lab_err;
	}

	rt = SKP_Silk_SDK_InitEncoder(hEnc, &tEnc);
	if(rt)
	{
		goto lab_err;
	}

	tEnc.API_sampleRate        = nHz==8000 ? 12000 : 24000;
	tEnc.maxInternalSampleRate = 24000;
	tEnc.packetSize            = nHz * 3 / 50;
	tEnc.bitRate               = nHz + nHz/10 * nLevel;
	tEnc.packetLossPercentage  = 0;
	tEnc.complexity            = 0;
	tEnc.useInBandFEC          = 0;
	tEnc.useDTX                = 0;

	while(1)
	{
		if(in_len>=nSrcLen-nl)
		{
			break;
		}

		memcpy(audio_in, pSrc + nl, in_len);
		nl += in_len;
		out_len = out_size;

		rt = SKP_Silk_SDK_Encode(hEnc, &tEnc, audio_in, in_len / 2, audio_out, &out_len);
		if(rt)
		{
			goto lab_err;
		}

		if(out_len<=0)
		{
			continue;
		}

		memcpy(buf + nr, &out_len, sizeof(SKP_int16));
		nr += sizeof(SKP_int16);

		memcpy(buf + nr, audio_out, out_len);
		nr += out_len;
//        printf("%d  %d %d %d\n", in_len, nl, out_len, nr);
	}

	if(x_vDst!=NULL && x_nDstLen>=nr)
	{
		memcpy(x_vDst, buf, nr);
	}

	err = nr;

	lab_err:
	g_free(&hEnc);
	g_free(&audio_in);
	g_free(&audio_out);
	g_free(&buf);
	return err;
}

int tsilk_decode_vcyber(const void * x_vSrc, int x_nSrcLen, void * x_vDst, int x_nDstLen, int x_nHz)
{
	if(x_nHz!=8000 && x_nHz!=16000)
	{
		return 0;
	}

	if(x_vSrc==NULL || x_nSrcLen<=0)
	{
		return 0;
	}

	const char * pSrc = (const char *)x_vSrc;
	const int nSrcLen = x_nSrcLen;
	const int nHz = x_nHz;

	int err = 0;
	int rt = 0;
	SKP_int32 nDecSize = 0;
	void * hDec = NULL;
	short in_len = 0;
	short out_len = 0; 
	int nl = 0;
	int nr = 0;
	int nk = 0;
	SKP_SILK_SDK_DecControlStruct tDec;
	char * buf = NULL;
	int buf_size = nSrcLen * 32;
	SKP_uint8 * audio_in = NULL;
	SKP_int16 * audio_out = NULL;
	const int in_size = MAX_BYTES_PER_FRAME_D * MAX_INPUT_FRAMES * (MAX_LBRR_DELAY + 1) * sizeof(SKP_uint8);
	const int out_size = FRAME_LENGTH_MS * MAX_API_FS_KHZ * MAX_INPUT_FRAMES * 2;

	buf = (char *)malloc(buf_size);
	if(buf==NULL)
	{
		goto lab_err;
	}

	audio_in = (SKP_uint8 *)malloc(in_size);
	if(audio_in==NULL)
	{
		goto lab_err;
	}

	audio_out = (SKP_int16 *)malloc(out_size * sizeof(SKP_int16));
	if(audio_out==NULL)
	{
		goto lab_err;
	}

	rt = SKP_Silk_SDK_Get_Decoder_Size(&nDecSize);
	if(rt)
	{
		goto lab_err;
	}

	hDec = malloc(nDecSize);
	if(hDec==NULL)
	{
		goto lab_err;
	}

	rt = SKP_Silk_SDK_InitDecoder(hDec);
	if(rt)
	{
		goto lab_err;
	}

	tDec.API_sampleRate = nHz==8000 ? 12000 : 24000; //nHz
	tDec.frameSize = 0;
	tDec.framesPerPacket = 1;
	tDec.moreInternalDecoderFrames = 0;
	tDec.inBandFECOffset = 0;

	while(1)
	{
		if(nSrcLen-nl<sizeof(SKP_int16))
		{
			break;
		}

		memcpy(&in_len, pSrc + nl, sizeof(SKP_int16));
		nl += sizeof(SKP_int16);

		if(in_len<=0)
		{
			continue;
		}

		if(in_size<in_len || in_len>nSrcLen-nl)
		{
			break;
		}

		memcpy(audio_in, pSrc + nl, in_len);
		nl += in_len;

		nk = 0;
		do
		{
			out_len = out_size - nk;
			rt = SKP_Silk_SDK_Decode(hDec, &tDec, 0, audio_in, in_len, audio_out + nk, &out_len);
			if(rt)
			{
				goto lab_err;
			}
			nk += out_len;
		}while(tDec.moreInternalDecoderFrames);
		nk *= sizeof(SKP_int16);

		if(nk>buf_size-nr)
		{
			void * pt = realloc(buf, buf_size - nr + nk);
			if(pt==NULL)
			{
				goto lab_err;
			}
			buf = (char *)pt;
			buf_size = buf_size -nr + nk;
		}

		memcpy(buf+nr, audio_out, nk);
		nr += nk;
	}

	if(x_vDst!=NULL && x_nDstLen>=nr)
	{
		memcpy(x_vDst, buf, nr);
	}

	err = nr;

	lab_err:
	g_free(&hDec);
	g_free(&audio_in);
	g_free(&audio_out);
	g_free(&buf);
	return err;
}

