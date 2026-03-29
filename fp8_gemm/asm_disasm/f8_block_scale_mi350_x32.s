
/usr/local/lib/python3.12/dist-packages/aiter_meta/hsa/gfx950/f8_block_scale_mi350_x32.co:	file format elf64-amdgpu

Disassembly of section .text:

0000000000002900 <f8_block_scale_mi350_x32>:
	s_and_b32 s1, s1, 0xffff
	s_load_dwordx2 s[8:9], s[0:1], 0x0
	s_load_dwordx2 s[20:21], s[0:1], 0x10
	s_load_dwordx2 s[24:25], s[0:1], 0x20
	s_load_dwordx2 s[28:29], s[0:1], 0x40
	s_load_dwordx2 s[32:33], s[0:1], 0x50
	s_mov_b32 s75, 0
	s_load_dword s60, s[0:1], 0x90
	s_load_dword s61, s[0:1], 0xa0
	s_load_dword s62, s[0:1], 0xb0
	s_load_dword s63, s[0:1], 0xc0
	s_load_dword s64, s[0:1], 0xd0
	s_load_dword s65, s[0:1], 0xe0
	s_load_dword s66, s[0:1], 0xf0
	s_load_dword s74, s[0:1], 0x140
	s_load_dword s75, s[0:1], 0x150
	v_lshrrev_b32_e32 v1, 10, v0
	v_lshrrev_b32_e32 v2, 10, v1
	v_and_b32_e32 v2, 0x3ff, v2
	v_and_b32_e32 v1, 0x3ff, v1
	v_and_b32_e32 v0, 0x3ff, v0
	v_lshrrev_b32_e32 v3, 6, v0
	v_and_b32_e32 v0, 63, v0
	s_mov_b32 s2, s2
	s_mov_b32 s3, s3
	s_mov_b32 s4, s4
	v_readfirstlane_b32 s7, v3
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s46, s62
	s_and_b32 s9, s9, 0xffff
	s_mul_i32 s52, s62, s64
	s_mul_i32 s53, s62, 4
	s_mov_b32 s22, s52
	s_mul_i32 s52, s60, s61
	s_mov_b32 s26, s52
	s_mov_b32 s30, s53
	s_mov_b32 s10, -16
	s_lshr_b32 s52, s60, 7
	s_mul_i32 s53, s52, 4
	s_lshr_b32 s52, s61, 7
	s_mul_i32 s52, s52, s53
	s_mov_b32 s34, s52
	s_mov_b32 s23, 0x20000
	s_mov_b32 s27, 0x20000
	s_mov_b32 s31, 0x20000
	s_mov_b32 s35, 0x20000
	s_mov_b32 s11, 0x20000
	s_and_b32 s21, s21, 0xffff
	s_and_b32 s25, s25, 0xffff
	s_and_b32 s29, s29, 0xffff
	s_and_b32 s33, s33, 0xffff
	s_or_b32 s21, s21, 0x40000
	s_or_b32 s25, s25, 0x40000
	s_or_b32 s29, s29, 0x40000
	s_or_b32 s33, s33, 0x40000
	v_accvgpr_write_b32 a63, 0
	v_mov_b32_e32 v67, 0
	s_waitcnt lgkmcnt(0)
	s_mul_i32 s52, s3, 32
	s_cmp_lt_i32 s52, s46
	s_cbranch_scc0 label_09FF
	s_mov_b32 s70, 0
	s_lshr_b32 s71, s60, s74
	s_mul_i32 s52, s3, 32
	v_and_b32_e32 v4, 15, v0
	v_add_u32_e64 v24, v4, s52
	v_add_u32_e32 v4, 16, v4
	v_add_u32_e64 v25, v4, s52
	v_add_u32_e32 v4, 16, v4
	v_lshlrev_b32_e32 v4, 2, v0
	v_add_u32_e32 v4, s7, v4
	v_add_u32_e32 v4, s52, v4
	v_mov_b32_e32 v3, v4
	s_lshr_b32 s53, s7, 1
	s_mul_i32 s53, s53, 8
	s_add_u32 s52, s53, s52
	s_and_b32 s53, s7, 1
	s_mul_i32 s53, s53, 2
	s_add_u32 s52, s53, s52
	v_lshrrev_b32_e32 v4, 3, v0
	v_mul_u32_u24_e32 v7, 32, v4
	v_and_b32_e32 v4, 7, v0
	v_lshrrev_b32_e32 v4, 2, v4
	v_mul_u32_u24_e32 v4, 16, v4
	v_add_u32_e32 v7, v7, v4
	v_and_b32_e32 v4, 3, v0
	v_lshrrev_b32_e32 v4, 1, v4
	v_mul_u32_u24_e32 v4, 4, v4
	v_add_u32_e32 v7, v7, v4
	v_and_b32_e32 v4, 1, v0
	v_add_u32_e32 v7, v7, v4
	v_add_u32_e32 v7, s52, v7
	v_mov_b32_e32 v35, v7
	v_mov_b32_e32 v36, 0
	v_mov_b32_e32 v52, 0
	v_mov_b32_e32 v37, 0
	v_mov_b32_e32 v53, 0
	v_mov_b32_e32 v38, 0
	v_mov_b32_e32 v54, 0
	v_mov_b32_e32 v39, 0
	v_mov_b32_e32 v55, 0
	v_mov_b32_e32 v40, 0
	v_mov_b32_e32 v56, 0
	v_mov_b32_e32 v41, 0
	v_mov_b32_e32 v57, 0
	v_mov_b32_e32 v42, 0
	v_mov_b32_e32 v58, 0
	v_mov_b32_e32 v43, 0
	v_mov_b32_e32 v59, 0
	v_mov_b32_e32 v44, 0
	v_mov_b32_e32 v60, 0
	v_mov_b32_e32 v45, 0
	v_mov_b32_e32 v61, 0
	v_mov_b32_e32 v46, 0
	v_mov_b32_e32 v62, 0
	v_mov_b32_e32 v47, 0
	v_mov_b32_e32 v63, 0
	v_mov_b32_e32 v48, 0
	v_mov_b32_e32 v64, 0
	v_mov_b32_e32 v49, 0
	v_mov_b32_e32 v65, 0
	v_mov_b32_e32 v50, 0
	v_mov_b32_e32 v66, 0
	v_mov_b32_e32 v51, 0
	v_mov_b32_e32 v67, 0
	s_mul_i32 s52, s2, 0x200
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 1, 2
	s_mul_i32 s52, s52, s53
	s_mov_b32 s80, s8
	s_mov_b32 s81, s9
	s_add_u32 s8, s52, s8
	s_addc_u32 s9, 0, s9
	v_lshrrev_b32_e32 v4, 4, v0
	v_mul_lo_u32 v16, 34, v4
	v_and_b32_e32 v4, 15, v0
	v_mul_lo_u32 v5, 2, v4
	v_add_u32_e32 v16, v5, v16
	s_mul_i32 s52, s7, 0x88
	v_add_u32_e32 v16, s52, v16
	v_lshlrev_b32_e32 v16, 2, v16
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	v_mul_lo_u32 v17, 34, v4
	v_lshrrev_b32_e32 v4, 5, v0
	v_mul_lo_u32 v4, 8, v4
	v_add_u32_e32 v17, v17, v4
	v_and_b32_e32 v5, 1, v0
	v_add_u32_e32 v17, v5, v17
	s_mul_i32 s52, s7, 2
	v_add_u32_e32 v17, s52, v17
	v_lshlrev_b32_e32 v17, 2, v17
	s_mul_i32 s52, s7, 0x420
	s_add_u32 s46, 0, s52
	s_add_u32 s47, 0x1080, s46
	v_and_b32_e32 v4, 15, v0
	v_lshrrev_b32_e32 v5, 3, v4
	v_mul_i32_i24_e32 v5, 2, v5
	v_and_b32_e32 v4, 3, v0
	v_lshrrev_b32_e32 v6, 1, v4
	v_add_u32_e32 v4, v5, v6
	v_mul_i32_i24_e32 v2, 0x420, v4
	v_and_b32_e32 v4, 7, v0
	v_lshrrev_b32_e32 v5, 2, v4
	v_mul_i32_i24_e32 v5, 0x100, v5
	v_and_b32_e32 v4, 1, v0
	v_mul_i32_i24_e32 v6, 0x80, v4
	v_add_u32_e32 v2, v5, v2
	v_add_u32_e32 v2, v6, v2
	v_lshrrev_b32_e32 v4, 4, v0
	v_mul_i32_i24_e32 v4, 16, v4
	v_add_u32_e32 v2, v4, v2
	s_waitcnt lgkmcnt(0)
	s_mul_i32 s52, s2, 0x100
	s_mul_i32 s52, s52, s65
	s_add_u32 s24, s52, s24
	s_addc_u32 s25, 0, s25
	s_lshr_b32 s52, s60, s74
	s_mul_i32 s52, s4, s52
	s_lshr_b32 s52, s52, 7
	s_mul_i32 s52, s52, 0x800
	s_add_u32 s24, s52, s24
	s_addc_u32 s25, 0, s25
	s_lshr_b32 s52, s65, s74
	s_mul_i32 s52, s4, s52
	s_add_u32 s20, s52, s20
	s_addc_u32 s21, 0, s21
	s_mul_i32 s52, s7, 16
	s_mul_i32 s52, s52, s65
	v_lshlrev_b32_e32 v33, 4, v0
	v_add_u32_e32 v33, s52, v33
	s_mul_i32 s52, 64, s65
	v_add_u32_e32 v34, s52, v33
	s_mov_b32 s76, s24
	s_mov_b32 s77, s25
	s_mov_b32 s78, s26
	s_mov_b32 s79, s27
	s_lshl_b32 s52, s65, 7
	s_add_u32 s76, s52, s76
	s_addc_u32 s77, 0, s77
	s_lshr_b32 s52, s60, 7
	s_mul_i32 s53, s52, 4
	v_and_b32_e32 v18, 0, v0
	v_mul_lo_u32 v18, v18, s53
	s_lshr_b32 s52, s60, 7
	s_mul_i32 s52, s52, 4
	v_add_u32_e64 v19, v18, s52
	s_mul_i32 s52, s2, 2
	s_mul_i32 s52, s52, s53
	s_add_u32 s32, s52, s32
	s_addc_u32 s33, 0, s33
	s_lshr_b32 s52, s60, 7
	s_lshr_b32 s52, s52, s74
	s_mul_i32 s52, s4, s52
	s_mul_i32 s53, s52, 4
	s_add_u32 s32, s53, s32
	s_addc_u32 s33, 0, s33
	s_lshl_b32 s54, s62, 2
	s_mul_i32 s54, s52, s54
	s_add_u32 s28, s54, s28
	s_addc_u32 s29, 0, s29
	s_mov_b32 s4, 4
	s_mov_b32 s57, 0x80
	s_mov_b32 s58, 0x800
	s_lshl_b32 s73, s65, 7
	s_mov_b32 m0, s46
	s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
	s_mov_b32 s54, -1
	s_mov_b32 s55, -1
	s_mov_b32 s16, 0
	s_mov_b32 s17, 0
	v_readlane_b32 s72, v35, 0
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 0
	s_mov_b32 s17, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v32, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v35, 1
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v32, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v35, 2
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v32, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v35, 3
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v32, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v35, 4
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 0
	s_mov_b32 s16, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v32, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v35, 5
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v32, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v35, 6
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v32, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v35, 7
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v32, s52
	s_mov_b64 exec, s[54:55]
	v_and_b32_e64 v4, v0, 7
	v_lshlrev_b32_e32 v4, 4, v4
	v_add_u32_e32 v32, v32, v4
	v_lshlrev_b32_e32 v24, 2, v24
	v_lshlrev_b32_e32 v25, 2, v25
	s_lshl_b32 s6, s62, 2
	buffer_load_dwordx4 v32, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s47
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	buffer_load_dword v26, v24, s[28:31], 0 offen
	buffer_load_dword v27, v25, s[28:31], 0 offen
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	buffer_load_dwordx4 v32, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s46
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	buffer_load_dword v28, v24, s[28:31], 0 offen
	buffer_load_dword v29, v25, s[28:31], 0 offen
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	buffer_load_dword v20, v18, s[32:35], 0 offen
	buffer_load_dwordx4 a[32:35], v33, s[24:27], 0 offen
	buffer_load_dwordx4 a[36:39], v33, s[24:27], 0 offen offset:1024
	buffer_load_dwordx4 a[40:43], v34, s[24:27], 0 offen
	buffer_load_dwordx4 a[44:47], v34, s[24:27], 0 offen offset:1024
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_waitcnt vmcnt(10)
	s_barrier
	ds_read_b128 a[0:3], v2
	ds_read_b128 a[4:7], v2 offset:64
	ds_read_b128 a[8:11], v2 offset:512
	ds_read_b128 a[12:15], v2 offset:576
	s_cmp_lt_i32 s7, 2
	s_cbranch_scc0 label_05CA

0000000000002f48 <label_0192>:
	s_waitcnt vmcnt(2) lgkmcnt(0)
	s_barrier
	v_mov_b32_e32 v30, v26
	v_mov_b32_e32 v31, v27
	v_mul_f32_dpp v4, v20, v30 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[32:39], a[0:7], 0
	buffer_load_dword v23, v19, s[32:35], 0 offen
	v_mul_f32_dpp v6, v20, v31 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[32:39], a[8:15], 0
	buffer_load_dwordx4 a[48:51], v33, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v36, v8, v4, v36
	v_fma_f32 v37, v9, v4, v37
	v_fma_f32 v38, v10, v4, v38
	v_fma_f32 v39, v11, v4, v39
	s_waitcnt vmcnt(2)
	v_mul_f32_dpp v4, v20, v30 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[40:47], a[0:7], 0
	s_add_u32 s52, 0x80, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s73, s73, 0
	s_cselect_b32 s4, s4, 0
	s_nop 5
	v_fma_f32 v40, v12, v6, v40
	v_fma_f32 v41, v13, v6, v41
	v_fma_f32 v42, v14, v6, v42
	v_fma_f32 v43, v15, v6, v43
	v_mul_f32_dpp v6, v20, v31 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[40:47], a[8:15], 0
	buffer_load_dwordx4 a[52:55], v33, s[76:79], 0 offen offset:1024
	s_add_u32 s32, s4, s32
	s_addc_u32 s33, 0, s33
	s_nop 5
	v_fma_f32 v44, v8, v4, v44
	v_fma_f32 v45, v9, v4, v45
	v_fma_f32 v46, v10, v4, v46
	v_fma_f32 v47, v11, v4, v47
	s_nop 5
	v_fma_f32 v48, v12, v6, v48
	v_fma_f32 v49, v13, v6, v49
	v_fma_f32 v50, v14, v6, v50
	v_fma_f32 v51, v15, v6, v51
	buffer_load_dwordx4 a[56:59], v34, s[76:79], 0 offen
	buffer_load_dwordx4 a[60:63], v34, s[76:79], 0 offen offset:1024
	buffer_load_dwordx4 v32, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s47
	buffer_load_dword v26, v24, s[28:31], 0 offen
	buffer_load_dword v27, v25, s[28:31], 0 offen
	s_waitcnt vmcnt(3)
	v_mul_f32_dpp v4, v23, v30 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[48:55], a[0:7], 0
	buffer_load_dword v20, v18, s[32:35], 0 offen
	ds_read_b128 a[16:19], v2 offset:4224
	ds_read_b128 a[20:23], v2 offset:4288
	s_add_u32 s76, s73, s24
	s_addc_u32 s77, 0, s77
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[56:63], a[0:7], 0
	buffer_load_dwordx4 a[32:35], v33, s[24:27], 0 offen
	s_add_u32 s52, 0x180, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s57, s57, 0
	s_cselect_b32 s6, s6, 0
	s_nop 5
	v_fma_f32 v52, v8, v4, v52
	v_fma_f32 v53, v9, v4, v53
	v_fma_f32 v54, v10, v4, v54
	v_fma_f32 v55, v11, v4, v55
	v_mul_f32_dpp v6, v23, v31 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[48:55], a[8:15], 0
	ds_read_b128 a[24:27], v2 offset:4736
	ds_read_b128 a[28:31], v2 offset:4800
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	s_nop 5
	v_fma_f32 v60, v12, v4, v60
	v_fma_f32 v61, v13, v4, v61
	v_fma_f32 v62, v14, v4, v62
	v_fma_f32 v63, v15, v4, v63
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[56:63], a[8:15], 0
	buffer_load_dwordx4 a[36:39], v33, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v56, v8, v6, v56
	v_fma_f32 v57, v9, v6, v57
	v_fma_f32 v58, v10, v6, v58
	v_fma_f32 v59, v11, v6, v59
	s_nop 5
	v_fma_f32 v64, v12, v6, v64
	v_fma_f32 v65, v13, v6, v65
	v_fma_f32 v66, v14, v6, v66
	v_fma_f32 v67, v15, v6, v67
	buffer_load_dwordx4 a[40:43], v34, s[24:27], 0 offen
	buffer_load_dwordx4 a[44:47], v34, s[24:27], 0 offen offset:1024
	s_add_u32 s52, 0x100, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s58, s58, 0
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_addk_i32 s70, 0x80
	s_cmp_lt_i32 s70, s71
	s_cbranch_scc0 label_02E3
	s_waitcnt vmcnt(2) lgkmcnt(0)
	s_barrier
	v_mov_b32_e32 v30, v28
	v_mov_b32_e32 v31, v29
	v_mul_f32_dpp v4, v20, v30 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[32:39], a[16:23], 0
	buffer_load_dword v23, v19, s[32:35], 0 offen
	v_mul_f32_dpp v6, v20, v31 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[32:39], a[24:31], 0
	buffer_load_dwordx4 a[48:51], v33, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v36, v8, v4, v36
	v_fma_f32 v37, v9, v4, v37
	v_fma_f32 v38, v10, v4, v38
	v_fma_f32 v39, v11, v4, v39
	s_waitcnt vmcnt(2)
	v_mul_f32_dpp v4, v20, v30 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[40:47], a[16:23], 0
	s_add_u32 s52, 0x80, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s73, s73, 0
	s_cselect_b32 s4, s4, 0
	s_nop 5
	v_fma_f32 v40, v12, v6, v40
	v_fma_f32 v41, v13, v6, v41
	v_fma_f32 v42, v14, v6, v42
	v_fma_f32 v43, v15, v6, v43
	v_mul_f32_dpp v6, v20, v31 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[40:47], a[24:31], 0
	buffer_load_dwordx4 a[52:55], v33, s[76:79], 0 offen offset:1024
	s_add_u32 s32, s4, s32
	s_addc_u32 s33, 0, s33
	s_nop 5
	v_fma_f32 v44, v8, v4, v44
	v_fma_f32 v45, v9, v4, v45
	v_fma_f32 v46, v10, v4, v46
	v_fma_f32 v47, v11, v4, v47
	s_nop 5
	v_fma_f32 v48, v12, v6, v48
	v_fma_f32 v49, v13, v6, v49
	v_fma_f32 v50, v14, v6, v50
	v_fma_f32 v51, v15, v6, v51
	buffer_load_dwordx4 a[56:59], v34, s[76:79], 0 offen
	buffer_load_dwordx4 a[60:63], v34, s[76:79], 0 offen offset:1024
	buffer_load_dwordx4 v32, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s46
	buffer_load_dword v28, v24, s[28:31], 0 offen
	buffer_load_dword v29, v25, s[28:31], 0 offen
	s_waitcnt vmcnt(3)
	v_mul_f32_dpp v4, v23, v30 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[48:55], a[16:23], 0
	buffer_load_dword v20, v18, s[32:35], 0 offen
	ds_read_b128 a[0:3], v2
	ds_read_b128 a[4:7], v2 offset:64
	s_add_u32 s76, s73, s24
	s_addc_u32 s77, 0, s77
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[56:63], a[16:23], 0
	buffer_load_dwordx4 a[32:35], v33, s[24:27], 0 offen
	s_add_u32 s52, 0x180, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s57, s57, 0
	s_cselect_b32 s6, s6, 0
	s_nop 5
	v_fma_f32 v52, v8, v4, v52
	v_fma_f32 v53, v9, v4, v53
	v_fma_f32 v54, v10, v4, v54
	v_fma_f32 v55, v11, v4, v55
	v_mul_f32_dpp v6, v23, v31 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[48:55], a[24:31], 0
	ds_read_b128 a[8:11], v2 offset:512
	ds_read_b128 a[12:15], v2 offset:576
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	s_nop 5
	v_fma_f32 v60, v12, v4, v60
	v_fma_f32 v61, v13, v4, v61
	v_fma_f32 v62, v14, v4, v62
	v_fma_f32 v63, v15, v4, v63
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[56:63], a[24:31], 0
	buffer_load_dwordx4 a[36:39], v33, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v56, v8, v6, v56
	v_fma_f32 v57, v9, v6, v57
	v_fma_f32 v58, v10, v6, v58
	v_fma_f32 v59, v11, v6, v59
	s_nop 5
	v_fma_f32 v64, v12, v6, v64
	v_fma_f32 v65, v13, v6, v65
	v_fma_f32 v66, v14, v6, v66
	v_fma_f32 v67, v15, v6, v67
	buffer_load_dwordx4 a[40:43], v34, s[24:27], 0 offen
	buffer_load_dwordx4 a[44:47], v34, s[24:27], 0 offen offset:1024
	s_add_u32 s52, 0x100, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s58, s58, 0
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_addk_i32 s70, 0x80
	s_cmp_lt_i32 s70, s71
	s_cbranch_scc0 label_02E3
	s_branch label_0192

000000000000348c <label_02E3>:
	s_cmp_eq_u32 s74, 0
	s_cbranch_scc0 label_040D
	v_cvt_pk_bf16_f32 v36, v36, v37
	v_cvt_pk_bf16_f32 v37, v38, v39
	v_cvt_pk_bf16_f32 v38, v40, v41
	v_cvt_pk_bf16_f32 v39, v42, v43
	v_cvt_pk_bf16_f32 v40, v44, v45
	v_cvt_pk_bf16_f32 v41, v46, v47
	v_cvt_pk_bf16_f32 v42, v48, v49
	v_cvt_pk_bf16_f32 v43, v50, v51
	ds_write_b64 v16, v[36:37]
	ds_write_b64 v16, v[38:39] offset:4352
	ds_write_b64 v16, v[40:41] offset:2176
	ds_write_b64 v16, v[42:43] offset:6528
	v_cvt_pk_bf16_f32 v52, v52, v53
	v_cvt_pk_bf16_f32 v53, v54, v55
	v_cvt_pk_bf16_f32 v54, v56, v57
	v_cvt_pk_bf16_f32 v55, v58, v59
	v_cvt_pk_bf16_f32 v56, v60, v61
	v_cvt_pk_bf16_f32 v57, v62, v63
	v_cvt_pk_bf16_f32 v58, v64, v65
	v_cvt_pk_bf16_f32 v59, v66, v67
	v_lshrrev_b32_e32 v4, 5, v0
	v_xor_b32_e32 v5, 1, v4
	s_mul_i32 s52, s61, 2
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 1, 4
	s_mul_i32 s52, s53, s52
	v_readlane_b32 s72, v3, 0
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 1
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v44, v6, v7
	v_readlane_b32 s72, v3, 2
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 3
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v45, v6, v7
	v_readlane_b32 s72, v3, 4
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 5
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v46, v6, v7
	v_readlane_b32 s72, v3, 6
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 7
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v47, v6, v7
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 2, 4
	v_mul_lo_u32 v4, v4, s53
	v_and_b32_e64 v5, v0, 1
	v_add_u32_e32 v4, v4, v5
	v_lshlrev_b32_e32 v4, 2, v4
	v_add_u32_e32 v44, v44, v4
	v_add_u32_e32 v45, v45, v4
	v_add_u32_e32 v46, v46, v4
	v_add_u32_e32 v47, v47, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v36, v17
	ds_read_b32 v37, v17 offset:64
	ds_read_b32 v38, v17 offset:2176
	ds_read_b32 v39, v17 offset:2240
	ds_read_b32 v40, v17 offset:4352
	ds_read_b32 v41, v17 offset:4416
	ds_read_b32 v42, v17 offset:6528
	ds_read_b32 v43, v17 offset:6592
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_or_b32 s9, s9, 0x40000
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v44
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v36, v6, s[8:11], 0 offen
	buffer_store_dword v38, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v45
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v37, v6, s[8:11], 0 offen
	buffer_store_dword v39, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v46
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v40, v6, s[8:11], 0 offen
	buffer_store_dword v42, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v47
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v41, v6, s[8:11], 0 offen
	buffer_store_dword v43, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_write_b64 v16, v[52:53]
	ds_write_b64 v16, v[54:55] offset:4352
	ds_write_b64 v16, v[56:57] offset:2176
	ds_write_b64 v16, v[58:59] offset:6528
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v52, v17
	ds_read_b32 v53, v17 offset:64
	ds_read_b32 v54, v17 offset:2176
	ds_read_b32 v55, v17 offset:2240
	ds_read_b32 v56, v17 offset:4352
	ds_read_b32 v57, v17 offset:4416
	ds_read_b32 v58, v17 offset:6528
	ds_read_b32 v59, v17 offset:6592
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_add_u32 s8, 0x100, s8
	s_addc_u32 s9, 0, s9
	s_or_b32 s9, s9, 0x40000
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v44
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v52, v6, s[8:11], 0 offen
	buffer_store_dword v54, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v45
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v53, v6, s[8:11], 0 offen
	buffer_store_dword v55, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v46
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v56, v6, s[8:11], 0 offen
	buffer_store_dword v58, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v47
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v57, v6, s[8:11], 0 offen
	buffer_store_dword v59, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	s_branch label_09FF

0000000000003934 <label_040D>:
	ds_write_b64 v16, v[36:37]
	ds_write_b64 v16, v[40:41] offset:4352
	ds_write_b64 v16, v[44:45] offset:2176
	ds_write_b64 v16, v[48:49] offset:6528
	v_lshrrev_b32_e32 v4, 5, v0
	v_xor_b32_e32 v5, 1, v4
	s_mul_i32 s52, s61, 2
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 1, 4
	s_mul_i32 s52, s53, s52
	v_readlane_b32 s72, v3, 0
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 1
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v44, v6, v7
	v_readlane_b32 s72, v3, 2
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 3
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v45, v6, v7
	v_readlane_b32 s72, v3, 4
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 5
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v46, v6, v7
	v_readlane_b32 s72, v3, 6
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 7
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v47, v6, v7
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 2, 4
	v_mul_lo_u32 v4, v4, s53
	v_and_b32_e64 v5, v0, 1
	v_add_u32_e32 v4, v4, v5
	v_lshlrev_b32_e32 v4, 2, v4
	v_add_u32_e32 v44, v44, v4
	v_add_u32_e32 v45, v45, v4
	v_add_u32_e32 v46, v46, v4
	v_add_u32_e32 v47, v47, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v36, v17
	ds_read_b32 v37, v17 offset:64
	ds_read_b32 v40, v17 offset:2176
	ds_read_b32 v41, v17 offset:2240
	ds_read_b32 v44, v17 offset:4352
	ds_read_b32 v45, v17 offset:4416
	ds_read_b32 v48, v17 offset:6528
	ds_read_b32 v49, v17 offset:6592
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v44
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v36, s[8:9]
	global_atomic_add_f32 v6, v40, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v45
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v37, s[8:9]
	global_atomic_add_f32 v6, v41, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v46
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v44, s[8:9]
	global_atomic_add_f32 v6, v48, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v47
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v45, s[8:9]
	global_atomic_add_f32 v6, v49, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[38:39]
	ds_write_b64 v16, v[42:43] offset:4352
	ds_write_b64 v16, v[46:47] offset:2176
	ds_write_b64 v16, v[50:51] offset:6528
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v38, v17
	ds_read_b32 v39, v17 offset:64
	ds_read_b32 v42, v17 offset:2176
	ds_read_b32 v43, v17 offset:2240
	ds_read_b32 v46, v17 offset:4352
	ds_read_b32 v47, v17 offset:4416
	ds_read_b32 v50, v17 offset:6528
	ds_read_b32 v51, v17 offset:6592
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v44
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v38, s[8:9] offset:8
	global_atomic_add_f32 v6, v42, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v45
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v39, s[8:9] offset:8
	global_atomic_add_f32 v6, v43, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v46
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v46, s[8:9] offset:8
	global_atomic_add_f32 v6, v50, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v47
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v47, s[8:9] offset:8
	global_atomic_add_f32 v6, v51, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[52:53]
	ds_write_b64 v16, v[56:57] offset:4352
	ds_write_b64 v16, v[60:61] offset:2176
	ds_write_b64 v16, v[64:65] offset:6528
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v52, v17
	ds_read_b32 v53, v17 offset:64
	ds_read_b32 v56, v17 offset:2176
	ds_read_b32 v57, v17 offset:2240
	ds_read_b32 v60, v17 offset:4352
	ds_read_b32 v61, v17 offset:4416
	ds_read_b32 v64, v17 offset:6528
	ds_read_b32 v65, v17 offset:6592
	s_mul_i32 s52, s61, 4
	s_add_u32 s8, s52, s8
	s_addc_u32 s9, 0, s9
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v44
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v52, s[8:9]
	global_atomic_add_f32 v6, v56, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v45
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v53, s[8:9]
	global_atomic_add_f32 v6, v57, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v46
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v60, s[8:9]
	global_atomic_add_f32 v6, v64, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v47
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v61, s[8:9]
	global_atomic_add_f32 v6, v65, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[54:55]
	ds_write_b64 v16, v[58:59] offset:4352
	ds_write_b64 v16, v[62:63] offset:2176
	ds_write_b64 v16, v[66:67] offset:6528
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v54, v17
	ds_read_b32 v55, v17 offset:64
	ds_read_b32 v58, v17 offset:2176
	ds_read_b32 v59, v17 offset:2240
	ds_read_b32 v62, v17 offset:4352
	ds_read_b32 v63, v17 offset:4416
	ds_read_b32 v66, v17 offset:6528
	ds_read_b32 v67, v17 offset:6592
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v44
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v54, s[8:9] offset:8
	global_atomic_add_f32 v6, v58, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v45
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v55, s[8:9] offset:8
	global_atomic_add_f32 v6, v59, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v46
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v62, s[8:9] offset:8
	global_atomic_add_f32 v6, v66, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v47
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v63, s[8:9] offset:8
	global_atomic_add_f32 v6, v67, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	s_branch label_09FF

000000000000401c <label_05CA>:
	s_waitcnt vmcnt(2) lgkmcnt(0)
	s_barrier
	v_mov_b32_e32 v30, v26
	v_mov_b32_e32 v31, v27
	v_mul_f32_dpp v4, v20, v30 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[32:39], a[0:7], 0
	buffer_load_dword v23, v19, s[32:35], 0 offen
	buffer_load_dwordx4 a[48:51], v33, s[76:79], 0 offen
	v_mul_f32_dpp v6, v20, v31 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[32:39], a[8:15], 0
	s_nop 5
	v_fma_f32 v36, v8, v4, v36
	v_fma_f32 v37, v9, v4, v37
	v_fma_f32 v38, v10, v4, v38
	v_fma_f32 v39, v11, v4, v39
	s_waitcnt vmcnt(2)
	v_mul_f32_dpp v4, v20, v30 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[40:47], a[0:7], 0
	buffer_load_dwordx4 a[52:55], v33, s[76:79], 0 offen offset:1024
	s_add_u32 s52, 0x80, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s73, s73, 0
	s_cselect_b32 s4, s4, 0
	s_nop 5
	v_fma_f32 v40, v12, v6, v40
	v_fma_f32 v41, v13, v6, v41
	v_fma_f32 v42, v14, v6, v42
	v_fma_f32 v43, v15, v6, v43
	v_mul_f32_dpp v6, v20, v31 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[40:47], a[8:15], 0
	s_add_u32 s32, s4, s32
	s_addc_u32 s33, 0, s33
	s_nop 5
	v_fma_f32 v44, v8, v4, v44
	v_fma_f32 v45, v9, v4, v45
	v_fma_f32 v46, v10, v4, v46
	v_fma_f32 v47, v11, v4, v47
	s_nop 5
	v_fma_f32 v48, v12, v6, v48
	v_fma_f32 v49, v13, v6, v49
	v_fma_f32 v50, v14, v6, v50
	v_fma_f32 v51, v15, v6, v51
	buffer_load_dwordx4 a[56:59], v34, s[76:79], 0 offen
	buffer_load_dwordx4 a[60:63], v34, s[76:79], 0 offen offset:1024
	buffer_load_dwordx4 v32, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s47
	buffer_load_dword v26, v24, s[28:31], 0 offen
	buffer_load_dword v27, v25, s[28:31], 0 offen
	s_waitcnt vmcnt(3)
	v_mul_f32_dpp v4, v23, v30 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[48:55], a[0:7], 0
	buffer_load_dword v20, v18, s[32:35], 0 offen
	buffer_load_dwordx4 a[32:35], v33, s[24:27], 0 offen
	s_add_u32 s76, s73, s24
	s_addc_u32 s77, 0, s77
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[56:63], a[0:7], 0
	ds_read_b128 a[16:19], v2 offset:4224
	ds_read_b128 a[20:23], v2 offset:4288
	s_add_u32 s52, 0x180, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s57, s57, 0
	s_cselect_b32 s6, s6, 0
	s_nop 5
	v_fma_f32 v52, v8, v4, v52
	v_fma_f32 v53, v9, v4, v53
	v_fma_f32 v54, v10, v4, v54
	v_fma_f32 v55, v11, v4, v55
	v_mul_f32_dpp v6, v23, v31 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[48:55], a[8:15], 0
	buffer_load_dwordx4 a[36:39], v33, s[24:27], 0 offen offset:1024
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	s_nop 5
	v_fma_f32 v60, v12, v4, v60
	v_fma_f32 v61, v13, v4, v61
	v_fma_f32 v62, v14, v4, v62
	v_fma_f32 v63, v15, v4, v63
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[56:63], a[8:15], 0
	ds_read_b128 a[24:27], v2 offset:4736
	ds_read_b128 a[28:31], v2 offset:4800
	s_nop 5
	v_fma_f32 v56, v8, v6, v56
	v_fma_f32 v57, v9, v6, v57
	v_fma_f32 v58, v10, v6, v58
	v_fma_f32 v59, v11, v6, v59
	s_nop 5
	v_fma_f32 v64, v12, v6, v64
	v_fma_f32 v65, v13, v6, v65
	v_fma_f32 v66, v14, v6, v66
	v_fma_f32 v67, v15, v6, v67
	buffer_load_dwordx4 a[40:43], v34, s[24:27], 0 offen
	buffer_load_dwordx4 a[44:47], v34, s[24:27], 0 offen offset:1024
	s_add_u32 s52, 0x100, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s58, s58, 0
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_addk_i32 s70, 0x80
	s_cmp_lt_i32 s70, s71
	s_cbranch_scc0 label_071B
	s_waitcnt vmcnt(2) lgkmcnt(0)
	s_barrier
	v_mov_b32_e32 v30, v28
	v_mov_b32_e32 v31, v29
	v_mul_f32_dpp v4, v20, v30 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[32:39], a[16:23], 0
	buffer_load_dword v23, v19, s[32:35], 0 offen
	buffer_load_dwordx4 a[48:51], v33, s[76:79], 0 offen
	v_mul_f32_dpp v6, v20, v31 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[32:39], a[24:31], 0
	s_nop 5
	v_fma_f32 v36, v8, v4, v36
	v_fma_f32 v37, v9, v4, v37
	v_fma_f32 v38, v10, v4, v38
	v_fma_f32 v39, v11, v4, v39
	s_waitcnt vmcnt(2)
	v_mul_f32_dpp v4, v20, v30 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[40:47], a[16:23], 0
	buffer_load_dwordx4 a[52:55], v33, s[76:79], 0 offen offset:1024
	s_add_u32 s52, 0x80, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s73, s73, 0
	s_cselect_b32 s4, s4, 0
	s_nop 5
	v_fma_f32 v40, v12, v6, v40
	v_fma_f32 v41, v13, v6, v41
	v_fma_f32 v42, v14, v6, v42
	v_fma_f32 v43, v15, v6, v43
	v_mul_f32_dpp v6, v20, v31 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[40:47], a[24:31], 0
	s_add_u32 s32, s4, s32
	s_addc_u32 s33, 0, s33
	s_nop 5
	v_fma_f32 v44, v8, v4, v44
	v_fma_f32 v45, v9, v4, v45
	v_fma_f32 v46, v10, v4, v46
	v_fma_f32 v47, v11, v4, v47
	s_nop 5
	v_fma_f32 v48, v12, v6, v48
	v_fma_f32 v49, v13, v6, v49
	v_fma_f32 v50, v14, v6, v50
	v_fma_f32 v51, v15, v6, v51
	buffer_load_dwordx4 a[56:59], v34, s[76:79], 0 offen
	buffer_load_dwordx4 a[60:63], v34, s[76:79], 0 offen offset:1024
	buffer_load_dwordx4 v32, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s46
	buffer_load_dword v28, v24, s[28:31], 0 offen
	buffer_load_dword v29, v25, s[28:31], 0 offen
	s_waitcnt vmcnt(3)
	v_mul_f32_dpp v4, v23, v30 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[48:55], a[16:23], 0
	buffer_load_dword v20, v18, s[32:35], 0 offen
	buffer_load_dwordx4 a[32:35], v33, s[24:27], 0 offen
	s_add_u32 s76, s73, s24
	s_addc_u32 s77, 0, s77
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[56:63], a[16:23], 0
	ds_read_b128 a[0:3], v2
	ds_read_b128 a[4:7], v2 offset:64
	s_add_u32 s52, 0x180, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s57, s57, 0
	s_cselect_b32 s6, s6, 0
	s_nop 5
	v_fma_f32 v52, v8, v4, v52
	v_fma_f32 v53, v9, v4, v53
	v_fma_f32 v54, v10, v4, v54
	v_fma_f32 v55, v11, v4, v55
	v_mul_f32_dpp v6, v23, v31 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[48:55], a[24:31], 0
	buffer_load_dwordx4 a[36:39], v33, s[24:27], 0 offen offset:1024
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	s_nop 5
	v_fma_f32 v60, v12, v4, v60
	v_fma_f32 v61, v13, v4, v61
	v_fma_f32 v62, v14, v4, v62
	v_fma_f32 v63, v15, v4, v63
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[56:63], a[24:31], 0
	ds_read_b128 a[8:11], v2 offset:512
	ds_read_b128 a[12:15], v2 offset:576
	s_nop 5
	v_fma_f32 v56, v8, v6, v56
	v_fma_f32 v57, v9, v6, v57
	v_fma_f32 v58, v10, v6, v58
	v_fma_f32 v59, v11, v6, v59
	s_nop 5
	v_fma_f32 v64, v12, v6, v64
	v_fma_f32 v65, v13, v6, v65
	v_fma_f32 v66, v14, v6, v66
	v_fma_f32 v67, v15, v6, v67
	buffer_load_dwordx4 a[40:43], v34, s[24:27], 0 offen
	buffer_load_dwordx4 a[44:47], v34, s[24:27], 0 offen offset:1024
	s_add_u32 s52, 0x100, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s58, s58, 0
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_addk_i32 s70, 0x80
	s_cmp_lt_i32 s70, s71
	s_cbranch_scc0 label_071B
	s_branch label_05CA

0000000000004560 <label_071B>:
	s_cmp_eq_u32 s74, 0
	s_cbranch_scc0 label_0845
	v_cvt_pk_bf16_f32 v36, v36, v37
	v_cvt_pk_bf16_f32 v37, v38, v39
	v_cvt_pk_bf16_f32 v38, v40, v41
	v_cvt_pk_bf16_f32 v39, v42, v43
	v_cvt_pk_bf16_f32 v40, v44, v45
	v_cvt_pk_bf16_f32 v41, v46, v47
	v_cvt_pk_bf16_f32 v42, v48, v49
	v_cvt_pk_bf16_f32 v43, v50, v51
	ds_write_b64 v16, v[36:37]
	ds_write_b64 v16, v[38:39] offset:4352
	ds_write_b64 v16, v[40:41] offset:2176
	ds_write_b64 v16, v[42:43] offset:6528
	v_cvt_pk_bf16_f32 v52, v52, v53
	v_cvt_pk_bf16_f32 v53, v54, v55
	v_cvt_pk_bf16_f32 v54, v56, v57
	v_cvt_pk_bf16_f32 v55, v58, v59
	v_cvt_pk_bf16_f32 v56, v60, v61
	v_cvt_pk_bf16_f32 v57, v62, v63
	v_cvt_pk_bf16_f32 v58, v64, v65
	v_cvt_pk_bf16_f32 v59, v66, v67
	v_lshrrev_b32_e32 v4, 5, v0
	v_xor_b32_e32 v5, 1, v4
	s_mul_i32 s52, s61, 2
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 1, 4
	s_mul_i32 s52, s53, s52
	v_readlane_b32 s72, v3, 0
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 1
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v44, v6, v7
	v_readlane_b32 s72, v3, 2
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 3
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v45, v6, v7
	v_readlane_b32 s72, v3, 4
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 5
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v46, v6, v7
	v_readlane_b32 s72, v3, 6
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 7
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v47, v6, v7
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 2, 4
	v_mul_lo_u32 v4, v4, s53
	v_and_b32_e64 v5, v0, 1
	v_add_u32_e32 v4, v4, v5
	v_lshlrev_b32_e32 v4, 2, v4
	v_add_u32_e32 v44, v44, v4
	v_add_u32_e32 v45, v45, v4
	v_add_u32_e32 v46, v46, v4
	v_add_u32_e32 v47, v47, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v36, v17
	ds_read_b32 v37, v17 offset:64
	ds_read_b32 v38, v17 offset:2176
	ds_read_b32 v39, v17 offset:2240
	ds_read_b32 v40, v17 offset:4352
	ds_read_b32 v41, v17 offset:4416
	ds_read_b32 v42, v17 offset:6528
	ds_read_b32 v43, v17 offset:6592
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_or_b32 s9, s9, 0x40000
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v44
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v36, v6, s[8:11], 0 offen
	buffer_store_dword v38, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v45
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v37, v6, s[8:11], 0 offen
	buffer_store_dword v39, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v46
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v40, v6, s[8:11], 0 offen
	buffer_store_dword v42, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v47
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v41, v6, s[8:11], 0 offen
	buffer_store_dword v43, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_write_b64 v16, v[52:53]
	ds_write_b64 v16, v[54:55] offset:4352
	ds_write_b64 v16, v[56:57] offset:2176
	ds_write_b64 v16, v[58:59] offset:6528
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v52, v17
	ds_read_b32 v53, v17 offset:64
	ds_read_b32 v54, v17 offset:2176
	ds_read_b32 v55, v17 offset:2240
	ds_read_b32 v56, v17 offset:4352
	ds_read_b32 v57, v17 offset:4416
	ds_read_b32 v58, v17 offset:6528
	ds_read_b32 v59, v17 offset:6592
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_add_u32 s8, 0x100, s8
	s_addc_u32 s9, 0, s9
	s_or_b32 s9, s9, 0x40000
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v44
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v52, v6, s[8:11], 0 offen
	buffer_store_dword v54, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v45
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v53, v6, s[8:11], 0 offen
	buffer_store_dword v55, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v46
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v56, v6, s[8:11], 0 offen
	buffer_store_dword v58, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v47
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v57, v6, s[8:11], 0 offen
	buffer_store_dword v59, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	s_branch label_09FF

0000000000004a08 <label_0845>:
	ds_write_b64 v16, v[36:37]
	ds_write_b64 v16, v[40:41] offset:4352
	ds_write_b64 v16, v[44:45] offset:2176
	ds_write_b64 v16, v[48:49] offset:6528
	v_lshrrev_b32_e32 v4, 5, v0
	v_xor_b32_e32 v5, 1, v4
	s_mul_i32 s52, s61, 2
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 1, 4
	s_mul_i32 s52, s53, s52
	v_readlane_b32 s72, v3, 0
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 1
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v44, v6, v7
	v_readlane_b32 s72, v3, 2
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 3
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v45, v6, v7
	v_readlane_b32 s72, v3, 4
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 5
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v46, v6, v7
	v_readlane_b32 s72, v3, 6
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 7
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v47, v6, v7
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 2, 4
	v_mul_lo_u32 v4, v4, s53
	v_and_b32_e64 v5, v0, 1
	v_add_u32_e32 v4, v4, v5
	v_lshlrev_b32_e32 v4, 2, v4
	v_add_u32_e32 v44, v44, v4
	v_add_u32_e32 v45, v45, v4
	v_add_u32_e32 v46, v46, v4
	v_add_u32_e32 v47, v47, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v36, v17
	ds_read_b32 v37, v17 offset:64
	ds_read_b32 v40, v17 offset:2176
	ds_read_b32 v41, v17 offset:2240
	ds_read_b32 v44, v17 offset:4352
	ds_read_b32 v45, v17 offset:4416
	ds_read_b32 v48, v17 offset:6528
	ds_read_b32 v49, v17 offset:6592
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v44
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v36, s[8:9]
	global_atomic_add_f32 v6, v40, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v45
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v37, s[8:9]
	global_atomic_add_f32 v6, v41, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v46
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v44, s[8:9]
	global_atomic_add_f32 v6, v48, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v47
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v45, s[8:9]
	global_atomic_add_f32 v6, v49, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[38:39]
	ds_write_b64 v16, v[42:43] offset:4352
	ds_write_b64 v16, v[46:47] offset:2176
	ds_write_b64 v16, v[50:51] offset:6528
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v38, v17
	ds_read_b32 v39, v17 offset:64
	ds_read_b32 v42, v17 offset:2176
	ds_read_b32 v43, v17 offset:2240
	ds_read_b32 v46, v17 offset:4352
	ds_read_b32 v47, v17 offset:4416
	ds_read_b32 v50, v17 offset:6528
	ds_read_b32 v51, v17 offset:6592
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v44
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v38, s[8:9] offset:8
	global_atomic_add_f32 v6, v42, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v45
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v39, s[8:9] offset:8
	global_atomic_add_f32 v6, v43, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v46
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v46, s[8:9] offset:8
	global_atomic_add_f32 v6, v50, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v47
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v47, s[8:9] offset:8
	global_atomic_add_f32 v6, v51, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[52:53]
	ds_write_b64 v16, v[56:57] offset:4352
	ds_write_b64 v16, v[60:61] offset:2176
	ds_write_b64 v16, v[64:65] offset:6528
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v52, v17
	ds_read_b32 v53, v17 offset:64
	ds_read_b32 v56, v17 offset:2176
	ds_read_b32 v57, v17 offset:2240
	ds_read_b32 v60, v17 offset:4352
	ds_read_b32 v61, v17 offset:4416
	ds_read_b32 v64, v17 offset:6528
	ds_read_b32 v65, v17 offset:6592
	s_mul_i32 s52, s61, 4
	s_add_u32 s8, s52, s8
	s_addc_u32 s9, 0, s9
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v44
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v52, s[8:9]
	global_atomic_add_f32 v6, v56, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v45
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v53, s[8:9]
	global_atomic_add_f32 v6, v57, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v46
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v60, s[8:9]
	global_atomic_add_f32 v6, v64, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v47
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v61, s[8:9]
	global_atomic_add_f32 v6, v65, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[54:55]
	ds_write_b64 v16, v[58:59] offset:4352
	ds_write_b64 v16, v[62:63] offset:2176
	ds_write_b64 v16, v[66:67] offset:6528
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v54, v17
	ds_read_b32 v55, v17 offset:64
	ds_read_b32 v58, v17 offset:2176
	ds_read_b32 v59, v17 offset:2240
	ds_read_b32 v62, v17 offset:4352
	ds_read_b32 v63, v17 offset:4416
	ds_read_b32 v66, v17 offset:6528
	ds_read_b32 v67, v17 offset:6592
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v44
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v54, s[8:9] offset:8
	global_atomic_add_f32 v6, v58, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v45
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v55, s[8:9] offset:8
	global_atomic_add_f32 v6, v59, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v46
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v62, s[8:9] offset:8
	global_atomic_add_f32 v6, v66, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v47
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v63, s[8:9] offset:8
	global_atomic_add_f32 v6, v67, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	s_branch label_09FF

00000000000050f0 <label_09FF>:
	s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
	s_endpgm
