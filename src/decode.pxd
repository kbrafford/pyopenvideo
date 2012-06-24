
cdef extern from "OVDecode.h":
    ctypedef bint OVresult
    ctypedef void *ov_handle
    ctypedef void *ov_session
    ctypedef unsigned char *ovd_bitstream_data
    ctypedef  void * OPContextHandle
    ctypedef void * OPMemHandle 
    ctypedef  void * OPEventHandle

    ctypedef struct ovdecode_device_info:
        unsigned int    device_id
        unsigned int    max_decode_stream
        unsigned int    decode_cap_size

    ctypedef enum ovdecode_profile:
        OVD_H264_BASELINE_41 = 1
        OVD_H264_MAIN_41
        OVD_H264_HIGH_41
        OVD_VC1_SIMPLE
        OVD_VC1_MAIN
        OVD_VC1_ADVANCED
        OVD_MPEG2_VLD
        OVD_H264_BASELINE_51
        OVD_H264_MAIN_51
        OVD_H264_HIGH_51
        OVD_H264_STEREO_HIGH

    ctypedef enum ovdecode_format:
        OVD_NV12_INTERLEAVED_AMD = 1
        OVD_YV12_INTERLEAVED_AMD

    ctypedef struct ovdecode_cap:
        ovdecode_profile    profile
        ovdecode_format     output_format

    ctypedef struct ovd_picture_parameter:
        unsigned int    codec_type
        unsigned int    profile
        unsigned int    level
        unsigned int    width_in_mb
        unsigned int    height_in_mb
        unsigned int    decode_flag
        void           *reserved_reference[16]
        unsigned int    reserved[15]

    ctypedef struct ovd_slice_data_control:
        unsigned int    SliceBitsInBuffer
        unsigned int    SliceDataLocation
        unsigned int    SliceBytesInBuffer
        unsigned int    reserved[5]

    ctypedef struct ovd_qm_data:
        unsigned char     bScalingLists4x4[6][16]
        unsigned char     bScalingLists8x8[2][64]

    ctypedef struct mvcElement_t:
        unsigned short    viewOrderIndex
        unsigned short    viewID
        unsigned short    numOfAnchorRefsInL0
        unsigned short    viewIDofAnchorRefsInL0[15]
        unsigned short    numOfAnchorRefsInL1
        unsigned short    viewIDofAnchorRefsInL1[15]
        unsigned short    numOfNonAnchorRefsInL0
        unsigned short    viewIDofNonAnchorRefsInL0[15]
        unsigned short    numOfNonAnchorRefsInL1
        unsigned short    viewIDofNonAnchorRefsInL1[15]

    ctypedef struct fake_264_sps_flag:
        unsigned int    residual_colour_transform_flag	
        unsigned int    delta_pic_always_zero_flag		
        unsigned int    gaps_in_frame_num_value_allowed_flag
        unsigned int    frame_mbs_only_flag		
        unsigned int    mb_adaptive_frame_field_flag	
        unsigned int    direct_8x8_inference_flag		
        unsigned int    sps_reserved		

    ctypedef union fake_264_sps_info:
        fake_264_sps_flag sps_flag
        unsigned int  flag

    ctypedef struct fake_264_pps_flag:
        unsigned int    entropy_coding_mode_flag
        unsigned int    pic_order_present_flag		
        unsigned int    weighted_pred_flag		
        unsigned int    weighted_bipred_idc		
        unsigned int    deblocking_filter_control_present_flag	
        unsigned int    constrained_intra_pred_flag		
        unsigned int    redundant_pic_cnt_present_flag	
        unsigned int    transform_8x8_mode_flag		
        unsigned int    pps_reserved		

    ctypedef union fake_264_pps_info:
        fake_264_pps_flag pps_flag
        unsigned int  flag

    ctypedef struct fake_mvc:
        unsigned int	numViews
        unsigned int	viewID0
        mvcElement_t	mvcElements [1]
        
    ctypedef struct H264_picture_parameter_2:
        fake_264_sps_info sps_info
        fake_264_pps_info pps_info
        
        unsigned int    picture_structure
        unsigned char   chroma_format
        unsigned char   bit_depth_luma_minus8
        unsigned char   bit_depth_chroma_minus8
        unsigned char   log2_max_frame_num_minus4

        unsigned char   pic_order_cnt_type
        unsigned char   log2_max_pic_order_cnt_lsb_minus4
        unsigned char   num_ref_frames
        unsigned char   reserved_8bit
        char            pic_init_qp_minus26
        char            pic_init_qs_minus26
        char            chroma_qp_index_offset
        char            second_chroma_qp_index_offset

        unsigned char	num_slice_groups_minus1
        unsigned char	slice_group_map_type
        unsigned char	num_ref_idx_l0_active_minus1
        unsigned char	num_ref_idx_l1_active_minus1
        
        unsigned short	slice_group_change_rate_minus1
        unsigned short	reserved_16bit
        
        unsigned char	scaling_lists_4x4[6][16]
        unsigned char	scaling_lists_8x8[2][64]
        
        unsigned int	frame_num
        unsigned int	frame_num_list[16]
        int		curr_field_order_cnt_list[2]
        int		field_order_cnt_list[16][2]

        int		intra_flag
        int		reference
        
        fake_mvc mvc
        unsigned int	reserved[128]


    ctypedef struct fake_vc1_sps_flag:
        unsigned int postprocflag
        unsigned int pulldown
        unsigned int interlace
        unsigned int tfcntrflag
        unsigned int finterpflag
        unsigned int sps_reserved1
        unsigned int psf
        unsigned int second_field
        unsigned int sps_reserved2

    ctypedef union fake_vc1_sps_info:
        fake_vc1_sps_flag sps_flag
        unsigned int flag

    ctypedef struct fake_vc1_pps_flag:
        unsigned int	panscan_flag		
        unsigned int	refdist_flag		
        unsigned int	loopfilter		    
        unsigned int	fastuvmc			
        unsigned int	extended_mv		    
        unsigned int	dquant			    
        unsigned int	vstransform		    
        unsigned int	overlap			    
        unsigned int	quantizer			
        unsigned int	extended_dmv		
        unsigned int	maxbframes		   
        unsigned int	rangered		
        unsigned int	syncmarker		   
        unsigned int	multires			
        unsigned int	reserved			
        unsigned int	range_mapy_flag		
        unsigned int	range_mapy		   
        unsigned int	range_mapuv_flag	
        unsigned int	range_mapuv		    
        unsigned int	vc1_pps_reserved

    ctypedef union fake_vc1_pps_info:
        fake_vc1_pps_flag pps_flag
        unsigned int	  flag
        
    ctypedef struct VC1_picture_parameter_2:
        fake_vc1_sps_info   sps_info
        fake_vc1_pps_info   pps_info        
        unsigned int        picture_structure
        unsigned int        chroma_format
        unsigned int        reserved [128]

        

    ctypedef struct fake_1_fields:
        unsigned short  fcode11 
        unsigned short  fcode10 
        unsigned short  fcode01 
        unsigned short  fcode00 

    ctypedef union fake_FCodes:
        fake_1_fields     fields
        unsigned short      value        

    ctypedef struct fake_2_fields:
        unsigned short  reservedBits        
        unsigned short  progressiveFrame    
        unsigned short  chroma420Type       
        unsigned short  repeatFirstField    
        unsigned short  alternateScan       
        unsigned short  intraVLCFormat      
        unsigned short  quantScaleType      
        unsigned short  concealmentMVs      
        unsigned short  frameDCTPrediction  
        unsigned short  topFieldFirst       
        unsigned short  picStructure        
        unsigned short  intraDCPrecision

    ctypedef union fake_BistreamPCElements:
        fake_2_fields    fields
        unsigned short   value  
        
    ctypedef struct MPEG2_picture_parameter_2:
        unsigned short    DecodedPictureIndex
        unsigned short    DeblockedPictureIndex
        unsigned short    ForwardRefPictureIndex
        unsigned short    BackwardRefPictureIndex

        unsigned short    picWidthInMBminus1
        unsigned short    picHeightInMBminus1

        unsigned char     macroblockWidthMinus1
        unsigned char     macroblockHeightMinus1
        unsigned char     blockWidthMinus1
        unsigned char     blockHeightMinus1

        unsigned char     bppminus1
        unsigned char     picStructure
        unsigned char     secondField
        unsigned char     picIntra

        unsigned char     picBackwardPrediction
        unsigned char     bidirectionalAveragingMode
        unsigned char     mvprecisionAndChromaRelation
        unsigned char     chromaFormat

        unsigned char     picScanFixed
        unsigned char     picScanMethod
        unsigned char     picReadbackRequests
        unsigned char     rcontrol

        unsigned char     picSpatialResid8
        unsigned char     picOverflowBlocks
        unsigned char     picExtrapolation
        unsigned char     picDeblocked

        unsigned char     picDeblockConfined
        unsigned char     pic4MVallowed
        unsigned char     picOBMC
        unsigned char     picBinPB

        unsigned char     mvRPS
        unsigned char     reservedBits

        fake_FCodes             FCodes
        fake_BistreamPCElements BistreamPCElements

        unsigned char       bitstreamConcealmentNeed
        unsigned char       bitstreamConcealmentMethod 
       
        unsigned char	scaling_lists_8x8[4][64]

        unsigned int    picture_coding_type
        unsigned int	reserved[128]

    int        fnOVDecode()
    OVresult   OVDecodeGetDeviceInfo (unsigned int *num_device, ovdecode_device_info *device_info)
    OVresult   OVDecodeGetDeviceCap (unsigned int  device_id, unsigned int  num_of_decode_cap, ovdecode_cap *decode_cap_list)
    ov_handle  OVCreateOVDHandleFromOPHandle (OPMemHandle  platform_memhandle)
    OVresult   OVReleaseOVDHandle (ov_handle decode_handle)
    OVresult   OVAcquireObject (ov_session session, unsigned int num_handle, ov_handle *decode_handle, unsigned int num_event_in_wait_list, OPEventHandle *event_wait_list, OPEventHandle *event)
    OVresult   OVReleaseObject (ov_session session, unsigned int  num_handle, ov_handle *decode_handle, unsigned int num_event_in_wait_list, OPEventHandle *event_wait_list, OPEventHandle *event)
    ov_session OVDecodeCreateSession (OPContextHandle platform_context, unsigned int device_id, ovdecode_profile profile,        ovdecode_format  output_format, unsigned int output_width, unsigned int output_height)
    OVresult   OVDecodePicture (ov_session session, ovd_picture_parameter  *picture_parameter_1, void *picture_parameter_2, unsigned int picture_parameter_2_size, ovd_bitstream_data *bitstream_data,unsigned int bitstream_data_size, ovd_slice_data_control *slice_data_control, unsigned int slice_data_control_size, OPMemHandle output_handle, unsigned int  num_event_in_wait_list, OPEventHandle *event_wait_list,OPEventHandle *event, unsigned int picture_id)
    OVresult   OVDecodeDestroySession (ov_session session)
