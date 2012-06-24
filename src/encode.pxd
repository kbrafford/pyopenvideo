
cdef extern from "OVEncode.h":
    ctypedef bint OVresult
    ctypedef bint OVE_BOOL
    ctypedef void *ove_handle
    ctypedef void *ove_session
    ctypedef void *OPContextHandle
    ctypedef void *OPMemHandle 
    ctypedef void *OPEventHandle
    ctypedef void *ove_handle
    ctypedef void *ove_event    
    ctypedef void *OVE_SURFACE_HANDLE

    ctypedef enum ovencode_profile:    
        OVE_H264_BASELINE_41 = 1
        OVE_H264_MAIN_41
        OVE_H264_HIGH_41
        OVD_VC1_SIMPLE
        OVD_VC1_MAIN		 
        OVD_VC1_ADVANCED
        OVD_MPEG2_VLD	 
        OVE_H264_BASELINE_51
        OVE_H264_MAIN_51
        OVE_H264_HIGH_51
        OVE_H264_STEREO_HIGH
     

    ctypedef struct ovencode_device_info:
       unsigned int		device_id
       unsigned int		encode_cap_list_size

    ctypedef enum ovencode_format:
        OVE_NV12_INTERLEAVED_AMD = 1
        OVE_YV12_INTERLEAVED_AMD

    ctypedef struct ovencode_cap:
        ovencode_profile profile
        ovencode_format  input_format

    ctypedef enum OVE_ENCODE_MODE: 
        OVE_MODE_NONE	 = 0
        OVE_AVC_FULL	 = 1
        OVE_AVC_ENTROPY  = 2 

    ctypedef enum OVE_ENCODE_TASK_PRIORITY:    
        OVE_ENCODE_TASK_PRIORITY_NONE   = 0
        OVE_ENCODE_TASK_PRIORITY_LEVEL1 = 1
        OVE_ENCODE_TASK_PRIORITY_LEVEL2 = 2

    ctypedef struct OVE_PROFILE_LEVEL:
        unsigned int   profile
        unsigned int   level

    ctypedef enum OVE_PICTURE_FORMAT:    
        OVE_PICTURE_FORMAT_NONE   = 0
        OVE_PICTURE_FORMAT_NV12   = 1

      #define OVE_MAX_NUM_PICTURE_FORMATS_H264		10
      #define OVE_MAX_NUM_PROFILE_LEVELS_H264     20 
      
    ctypedef struct OVE_ENCODE_CAPS_H264:    
        unsigned int                max_picture_size_in_MB
        unsigned int                min_picture_size_in_MB
        unsigned int                num_picture_formats
        #OVE_PICTURE_FORMAT          supported_picture_formats[OVE_MAX_NUM_PICTURE_FORMATS_H264]
        OVE_PICTURE_FORMAT          supported_picture_formats[10]
        unsigned int                num_Profile_level
        #OVE_PROFILE_LEVEL           supported_profile_level[OVE_MAX_NUM_PROFILE_LEVELS_H264]
        OVE_PROFILE_LEVEL           supported_profile_level[20]
        unsigned int                max_bit_rate
        unsigned int                min_bit_rate
        OVE_ENCODE_TASK_PRIORITY    supported_task_priority
    
    ctypedef struct OVE_ENCODE_CAPS_ENTROPY:
        OVE_ENCODE_TASK_PRIORITY    supported_task_priority
        unsigned int                max_task_queue_depth

    ctypedef union fake_caps:
        OVE_ENCODE_CAPS_H264	 *encode_cap_full
        OVE_ENCODE_CAPS_ENTROPY	 *encode_cap_entropy
        void					 *encode_cap

    ctypedef struct OVE_ENCODE_CAPS:
        OVE_ENCODE_MODE 		 EncodeModes
        #ovencode_profile_uvd    profile
        unsigned int			 encode_cap_size
        fake_caps              caps


    ctypedef struct OVE_CONFIG_PICTURE_CONTROL:    
        unsigned int                size                       
        unsigned int                useConstrainedIntraPred    
        unsigned int                cabacEnable                
        unsigned int                cabacIDC                   
        unsigned int                loopFilterDisable          
                                                               
        int                         encLFBetaOffset            
                                                                                                                              
        int                         encLFAlphaC0Offset         
                                                               
        unsigned int                encIDRPeriod
        unsigned int                encIPicPeriod              
                                                               
        #//unsigned int                encBPicPattern           
                                                               
        int                         encHeaderInsertionSpacing  
                                                               
        unsigned int                encCropLeftOffset
        unsigned int                encCropRightOffset
        unsigned int                encCropTopOffset
        unsigned int                encCropBottomOffset
        #//unsigned int                encFrameCroppingFlag

        unsigned int                encNumMBsPerSlice      
        unsigned int                encNumSlicesPerFrame   
        unsigned int                encForceIntraRefresh	

        unsigned int                encForceIMBPeriod       

        unsigned int                encInsertVUIParam       
        unsigned int                encInsertSEIMsg        
        #//unsigned int                encSliceMode     
        #//unsigned int                encSliceArgument
        #//unsigned char               picInterlace


    ctypedef struct OVE_CONFIG_RATE_CONTROL:    
        unsigned int                size
        unsigned int                encRateControlMethod
        unsigned int                encRateControlTargetBitRate
        unsigned int                encRateControlPeakBitRate
        unsigned int                encRateControlFrameRateNumerator
        unsigned int                encGOPSize   
        unsigned int                encRCOptions 

        unsigned int                encQP_I           
        unsigned int                encQP_P           
        unsigned int                encQP_B           
        unsigned int                encVBVBufferSize   
                                                       
        #//unsigned int                encResetVBVLevel 

        #//unsigned int                encVBVLevelValue                                                        
        unsigned int                encRateControlFrameRateDenominator
     

    ctypedef struct OVE_CONFIG_MOTION_ESTIMATION:    
        unsigned int                size             
        unsigned int                imeDecimationSearch
        unsigned int                motionEstHalfPixel 
        unsigned int                motionEstQuarterPixel
        unsigned int                disableFavorPMVPoint 
        unsigned int                forceZeroPointCenter 
        unsigned int                lsmVert
    #//    unsigned int                lsmVert5    
    #//    unsigned int                lsmVert3    
    #//    unsigned int                lsmVert1    
        unsigned int                encSearchRangeX 
        unsigned int                encSearchRangeY  
        unsigned int                encSearch1RangeX 
        unsigned int                encSearch1RangeY  
        unsigned int                disable16x16Frame1
        unsigned int                disableSATD       
        unsigned int                enableAMD          
        unsigned int                encDisableSubMode  
        unsigned int                encIMESkipX        
        unsigned int                encIMESkipY        
        unsigned int                encEnImeOverwDisSubm
        unsigned int                encImeOverwDisSubmNo
        unsigned int                encIME2SearchRangeX                                                         
        unsigned int                encIME2SearchRangeY 


    ctypedef struct OVE_CONFIG_RDO:
        unsigned int                size
        unsigned int                encDisableTbePredIFrame
        unsigned int                encDisableTbePredPFrame
        unsigned int                useFmeInterpolY
        unsigned int                useFmeInterpolUV
        unsigned int                enc16x16CostAdj
        unsigned int                encSkipCostAdj 
        unsigned char               encForce16x16skip
     
    ctypedef enum OVE_CONFIG_TYPE:
        OVE_CONFIG_TYPE_NONE                    = 0
        OVE_CONFIG_TYPE_PICTURE_CONTROL 		= 1
        OVE_CONFIG_TYPE_RATE_CONTROL		    = 2
        OVE_CONFIG_TYPE_MOTION_ESTIMATION       = 3
        OVE_CONFIG_TYPE_RDO                     = 4     

    ctypedef union fake_config:    
        OVE_CONFIG_PICTURE_CONTROL*    pPictureControl
        OVE_CONFIG_RATE_CONTROL*       pRateControl
        OVE_CONFIG_MOTION_ESTIMATION*  pMotionEstimation
        OVE_CONFIG_RDO*                pRDO

    ctypedef struct OVE_CONFIG:    
        OVE_CONFIG_TYPE                 configType
        fake_config                     config
     
    ctypedef enum OVE_PICTURE_STRUCTURE_H264:    
        OVE_PICTURE_STRUCTURE_H264_NONE 		    = 0
        OVE_PICTURE_STRUCTURE_H264_FRAME 		    = 1
        OVE_PICTURE_STRUCTURE_H264_TOP_FIELD	 	= 2
        OVE_PICTURE_STRUCTURE_H264_BOTTOM_FIELD     = 3
     

    ctypedef enum OVE_PICTURE_TYPE_H264:    
        OVE_PICTURE_TYPE_H264_NONE   = 0
        OVE_PICTURE_TYPE_H264_SKIP   = 1
        OVE_PICTURE_TYPE_H264_IDR    = 2
        OVE_PICTURE_TYPE_H264_I      = 3
        OVE_PICTURE_TYPE_H264_P      = 4
     

    ctypedef struct fake_flags:
        unsigned int            reserved

    ctypedef union OVE_PARAMETERS_FLAGS:    
        fake_flags       flags
        unsigned int     value

    ctypedef struct OVE_ENCODE_PARAMETERS_H264:    
        unsigned int                        size   
        OVE_PARAMETERS_FLAGS                flags                 
        OVE_BOOL                            insertSPS    
        OVE_PICTURE_STRUCTURE_H264          pictureStructure
        OVE_BOOL                            forceRefreshMap
        unsigned int                        forceIMBPeriod
        OVE_PICTURE_TYPE_H264               forcePicType
     

    ctypedef enum OVE_BUFFER_TYPE:
        OVE_BUFFER_TYPE_NONE                  = 0
        OVE_BUFFER_TYPE_PICTURE               = 2
        OVE_BUFFER_TYPE_INTRA_REFRESH_BITMAP  = 3
        OVE_BUFFER_TYPE_DIRTY_CLEAN_BITMAP    = 4
        OVE_BUFFER_TYPE_SLICE_HEADER          = 5
        OVE_BUFFER_TYPE_SLICE                 = 6

    ctypedef union fake_buffer:
        OVE_SURFACE_HANDLE          pPicture
        OVE_SURFACE_HANDLE          pIntraRefreshBitmap
        OVE_SURFACE_HANDLE          pDirtyCleanBitmap
        OVE_SURFACE_HANDLE          pSliceHeader
        OVE_SURFACE_HANDLE          pSlice

    ctypedef struct OVE_INPUT_DESCRIPTION:    
        OVE_BUFFER_TYPE                     bufferType
        fake_buffer                         buffer

    ctypedef enum OVE_TASK_STATUS:    
        OVE_TASK_STATUS_NONE                = 0
        OVE_TASK_STATUS_COMPLETE           	= 1
        OVE_TASK_STATUS_FAILED              = 2
     
    ctypedef struct OVE_OUTPUT_DESCRIPTION:
        unsigned int      size
        unsigned int      taskID
        OVE_TASK_STATUS   status
        unsigned int      size_of_bitstream_data
        void             *bitstream_data

        
    int         fnOVEncode()
    OVresult    OVEncodeGetDeviceInfo (unsigned int *num_device, ovencode_device_info *device_info)
    OVresult    OVEncodeGetDeviceCap (OPContextHandle platform_context, unsigned int device_id, unsigned int encode_cap_list_size, unsigned int *num_encode_cap, OVE_ENCODE_CAPS *encode_cap_list)
    ove_handle  OVCreateOVEHandleFromOPHandle (OPMemHandle platform_memhandle)
    OVresult    OVReleaseOVEHandle(ove_handle encode_handle)
    OVresult    OVEncodeAcquireObject (ove_session session, unsigned int num_handle, ove_handle *encode_handle, unsigned int num_event_in_wait_list, OPEventHandle *event_wait_list, OPEventHandle *event)
    OVresult    OVEncodeReleaseObject (ove_session session, unsigned int num_handle, ove_handle *encode_handle, unsigned int num_event_in_wait_list, OPEventHandle *event_wait_list, OPEventHandle *event)
    ove_event   OVCreateOVEEventFromOPEventHandle (OPEventHandle platform_eventhandle)
    OVresult    OVEncodeReleaseOVEEventHandle (ove_event ove_ev)
    ove_session OVEncodeCreateSession (OPContextHandle platform_context, unsigned int device_id, OVE_ENCODE_MODE encode_mode, OVE_PROFILE_LEVEL encode_profile, OVE_PICTURE_FORMAT encode_format, unsigned int encode_width, unsigned int encode_height, OVE_ENCODE_TASK_PRIORITY encode_task_priority)
    OVresult    OVEncodeDestroySession (ove_session session)
    OVresult    OVEncodeGetPictureControlConfig (ove_session session, OVE_CONFIG_PICTURE_CONTROL *pPictureControlConfig)
    OVresult    OVEncodeGetRateControlConfig (ove_session session, OVE_CONFIG_RATE_CONTROL *pRateControlConfig)
    OVresult    OVEncodeGetMotionEstimationConfig (ove_session session, OVE_CONFIG_MOTION_ESTIMATION *pMotionEstimationConfig)
    OVresult    OVEncodeGetRDOControlConfig (ove_session session, OVE_CONFIG_RDO *pRDOConfig)
    OVresult    OVEncodeSendConfig (ove_session session, unsigned int num_of_config_buffers, OVE_CONFIG *pConfigBuffers)
    OVresult    OVEncodeTask (ove_session session, unsigned int number_of_encode_task_input_buffers, OVE_INPUT_DESCRIPTION *encode_task_input_buffers_list, void *picture_parameter, unsigned int *pTaskID, unsigned int num_event_in_wait_list, ove_event *event_wait_list, ove_event *event)
    OVresult    OVEncodeQueryTaskDescription (ove_session session, unsigned int num_of_task_description_request, unsigned int *num_of_task_description_return, OVE_OUTPUT_DESCRIPTION  *task_description_list)
    OVresult    OVEncodeReleaseTask (ove_session session, unsigned int taskID)
