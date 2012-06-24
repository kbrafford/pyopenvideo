# -*- coding: latin-1 -*-
"""
.. module:: pyopenvideo
   :platform: Windows
   :synopsis: A Python wrapper for the AMD's OpenVideo API

.. moduleauthor:: Keith Brafford
"""
from libc.stdlib cimport malloc, free
import time      

class OVDecodeProfile(object):
    H264_BASELINE_41  = 1
    H264_MAIN_41      = 2 
    H264_HIGH_41      = 3
    VC1_SIMPLE        = 4
    VC1_MAIN          = 5
    VC1_ADVANCED      = 6
    MPEG2_VLD         = 7
    H264_BASELINE_51  = 8
    H264_MAIN_51      = 9
    H264_HIGH_51      = 10
    H264_STEREO_HIGH  = 11

class OVDecodeFormat(object):
    NV12_INTERLEAVED_AMD = 1
    YV12_INTERLEAVED_AMD = 2

