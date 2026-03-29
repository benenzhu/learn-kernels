
/usr/local/lib/python3.12/dist-packages/aiter_meta/hsa/gfx950/f8_block_scale_mi350_x64.co:	file format elf64-amdgpu

Disassembly of section .text:

0000000000002900 <f8_block_scale_mi350_x64>:
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
	v_accvgpr_write_b32 a95, 0
	v_mov_b32_e32 v111, 0
	s_waitcnt lgkmcnt(0)
	s_mul_i32 s52, s3, 64
	s_cmp_lt_i32 s52, s46
	s_cbranch_scc0 label_117A
	s_mov_b32 s70, 0
	s_lshr_b32 s71, s60, s74
	s_mul_i32 s52, s3, 64
	v_and_b32_e32 v4, 15, v0
	v_add_u32_e64 v24, v4, s52
	v_add_u32_e32 v4, 16, v4
	v_add_u32_e64 v25, v4, s52
	v_add_u32_e32 v4, 16, v4
	v_add_u32_e64 v26, v4, s52
	v_add_u32_e32 v4, 16, v4
	v_add_u32_e64 v27, v4, s52
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
	v_mov_b32_e32 v44, v7
	v_mov_b32_e32 v48, 0
	v_mov_b32_e32 v80, 0
	v_mov_b32_e32 v49, 0
	v_mov_b32_e32 v81, 0
	v_mov_b32_e32 v50, 0
	v_mov_b32_e32 v82, 0
	v_mov_b32_e32 v51, 0
	v_mov_b32_e32 v83, 0
	v_mov_b32_e32 v52, 0
	v_mov_b32_e32 v84, 0
	v_mov_b32_e32 v53, 0
	v_mov_b32_e32 v85, 0
	v_mov_b32_e32 v54, 0
	v_mov_b32_e32 v86, 0
	v_mov_b32_e32 v55, 0
	v_mov_b32_e32 v87, 0
	v_mov_b32_e32 v56, 0
	v_mov_b32_e32 v88, 0
	v_mov_b32_e32 v57, 0
	v_mov_b32_e32 v89, 0
	v_mov_b32_e32 v58, 0
	v_mov_b32_e32 v90, 0
	v_mov_b32_e32 v59, 0
	v_mov_b32_e32 v91, 0
	v_mov_b32_e32 v60, 0
	v_mov_b32_e32 v92, 0
	v_mov_b32_e32 v61, 0
	v_mov_b32_e32 v93, 0
	v_mov_b32_e32 v62, 0
	v_mov_b32_e32 v94, 0
	v_mov_b32_e32 v63, 0
	v_mov_b32_e32 v95, 0
	v_mov_b32_e32 v64, 0
	v_mov_b32_e32 v96, 0
	v_mov_b32_e32 v65, 0
	v_mov_b32_e32 v97, 0
	v_mov_b32_e32 v66, 0
	v_mov_b32_e32 v98, 0
	v_mov_b32_e32 v67, 0
	v_mov_b32_e32 v99, 0
	v_mov_b32_e32 v68, 0
	v_mov_b32_e32 v100, 0
	v_mov_b32_e32 v69, 0
	v_mov_b32_e32 v101, 0
	v_mov_b32_e32 v70, 0
	v_mov_b32_e32 v102, 0
	v_mov_b32_e32 v71, 0
	v_mov_b32_e32 v103, 0
	v_mov_b32_e32 v72, 0
	v_mov_b32_e32 v104, 0
	v_mov_b32_e32 v73, 0
	v_mov_b32_e32 v105, 0
	v_mov_b32_e32 v74, 0
	v_mov_b32_e32 v106, 0
	v_mov_b32_e32 v75, 0
	v_mov_b32_e32 v107, 0
	v_mov_b32_e32 v76, 0
	v_mov_b32_e32 v108, 0
	v_mov_b32_e32 v77, 0
	v_mov_b32_e32 v109, 0
	v_mov_b32_e32 v78, 0
	v_mov_b32_e32 v110, 0
	v_mov_b32_e32 v79, 0
	v_mov_b32_e32 v111, 0
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
	s_mul_i32 s52, s7, 0x820
	s_add_u32 s46, 0, s52
	s_add_u32 s47, 0x2080, s46
	v_and_b32_e32 v4, 15, v0
	v_lshrrev_b32_e32 v5, 3, v4
	v_mul_i32_i24_e32 v5, 2, v5
	v_and_b32_e32 v4, 3, v0
	v_lshrrev_b32_e32 v6, 1, v4
	v_add_u32_e32 v4, v5, v6
	v_mul_i32_i24_e32 v2, 0x820, v4
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
	v_lshlrev_b32_e32 v42, 4, v0
	v_add_u32_e32 v42, s52, v42
	s_mul_i32 s52, 64, s65
	v_add_u32_e32 v43, s52, v42
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
	v_readlane_b32 s72, v44, 0
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 0
	s_mov_b32 s17, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v40, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v44, 1
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v40, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v44, 2
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v40, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v44, 3
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v40, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v44, 4
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 0
	s_mov_b32 s16, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v40, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v44, 5
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v40, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v44, 6
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v40, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v44, 7
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v40, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v44, 8
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 0
	s_mov_b32 s17, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v41, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v44, 9
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v41, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v44, 10
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v41, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v44, 11
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v41, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v44, 12
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 0
	s_mov_b32 s16, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v41, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v44, 13
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v41, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v44, 14
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v41, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v44, 15
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v41, s52
	s_mov_b64 exec, s[54:55]
	v_and_b32_e64 v4, v0, 7
	v_lshlrev_b32_e32 v4, 4, v4
	v_add_u32_e32 v40, v40, v4
	v_add_u32_e32 v41, v41, v4
	v_lshlrev_b32_e32 v24, 2, v24
	v_lshlrev_b32_e32 v25, 2, v25
	v_lshlrev_b32_e32 v26, 2, v26
	v_lshlrev_b32_e32 v27, 2, v27
	s_lshl_b32 s6, s62, 2
	buffer_load_dwordx4 v40, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s46
	buffer_load_dwordx4 v41, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s47
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	buffer_load_dword v28, v24, s[28:31], 0 offen
	buffer_load_dword v29, v25, s[28:31], 0 offen
	buffer_load_dword v30, v26, s[28:31], 0 offen
	buffer_load_dword v31, v27, s[28:31], 0 offen
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	buffer_load_dwordx4 v40, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s47
	buffer_load_dwordx4 v41, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s46
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	buffer_load_dword v32, v24, s[28:31], 0 offen
	buffer_load_dword v33, v25, s[28:31], 0 offen
	buffer_load_dword v34, v26, s[28:31], 0 offen
	buffer_load_dword v35, v27, s[28:31], 0 offen
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	buffer_load_dword v20, v18, s[32:35], 0 offen
	buffer_load_dwordx4 a[64:67], v42, s[24:27], 0 offen
	buffer_load_dwordx4 a[68:71], v42, s[24:27], 0 offen offset:1024
	buffer_load_dwordx4 a[72:75], v43, s[24:27], 0 offen
	buffer_load_dwordx4 a[76:79], v43, s[24:27], 0 offen offset:1024
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_waitcnt vmcnt(15)
	s_barrier
	ds_read_b128 a[0:3], v2
	ds_read_b128 a[4:7], v2 offset:64
	ds_read_b128 a[8:11], v2 offset:512
	ds_read_b128 a[12:15], v2 offset:576
	ds_read_b128 a[16:19], v2 offset:1024
	ds_read_b128 a[20:23], v2 offset:1088
	ds_read_b128 a[24:27], v2 offset:1536
	ds_read_b128 a[28:31], v2 offset:1600
	s_cmp_lt_i32 s7, 2
	s_cbranch_scc0 label_09C9

0000000000003154 <label_0215>:
	s_waitcnt vmcnt(2) lgkmcnt(0)
	s_barrier
	v_mov_b32_e32 v36, v28
	v_mov_b32_e32 v37, v29
	v_mov_b32_e32 v38, v30
	v_mov_b32_e32 v39, v31
	v_mul_f32_dpp v4, v20, v36 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[64:71], a[0:7], 0
	buffer_load_dword v23, v19, s[32:35], 0 offen
	v_mul_f32_dpp v6, v20, v37 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[64:71], a[8:15], 0
	buffer_load_dwordx4 a[80:83], v42, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v48, v8, v4, v48
	v_fma_f32 v49, v9, v4, v49
	v_fma_f32 v50, v10, v4, v50
	v_fma_f32 v51, v11, v4, v51
	v_mul_f32_dpp v4, v20, v38 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[64:71], a[16:23], 0
	s_nop 5
	v_fma_f32 v52, v12, v6, v52
	v_fma_f32 v53, v13, v6, v53
	v_fma_f32 v54, v14, v6, v54
	v_fma_f32 v55, v15, v6, v55
	v_mul_f32_dpp v6, v20, v39 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[64:71], a[24:31], 0
	buffer_load_dwordx4 a[84:87], v42, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v56, v8, v4, v56
	v_fma_f32 v57, v9, v4, v57
	v_fma_f32 v58, v10, v4, v58
	v_fma_f32 v59, v11, v4, v59
	s_waitcnt vmcnt(3)
	v_mul_f32_dpp v4, v20, v36 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[72:79], a[0:7], 0
	s_nop 5
	v_fma_f32 v60, v12, v6, v60
	v_fma_f32 v61, v13, v6, v61
	v_fma_f32 v62, v14, v6, v62
	v_fma_f32 v63, v15, v6, v63
	v_mul_f32_dpp v6, v20, v37 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[72:79], a[8:15], 0
	buffer_load_dwordx4 a[88:91], v43, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v64, v8, v4, v64
	v_fma_f32 v65, v9, v4, v65
	v_fma_f32 v66, v10, v4, v66
	v_fma_f32 v67, v11, v4, v67
	v_mul_f32_dpp v4, v20, v38 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[72:79], a[16:23], 0
	s_add_u32 s52, 0x80, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s73, s73, 0
	s_cselect_b32 s4, s4, 0
	s_nop 5
	v_fma_f32 v68, v12, v6, v68
	v_fma_f32 v69, v13, v6, v69
	v_fma_f32 v70, v14, v6, v70
	v_fma_f32 v71, v15, v6, v71
	v_mul_f32_dpp v6, v20, v39 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[72:79], a[24:31], 0
	buffer_load_dwordx4 a[92:95], v43, s[76:79], 0 offen offset:1024
	s_add_u32 s32, s4, s32
	s_addc_u32 s33, 0, s33
	s_nop 5
	v_fma_f32 v72, v8, v4, v72
	v_fma_f32 v73, v9, v4, v73
	v_fma_f32 v74, v10, v4, v74
	v_fma_f32 v75, v11, v4, v75
	s_nop 5
	v_fma_f32 v76, v12, v6, v76
	v_fma_f32 v77, v13, v6, v77
	v_fma_f32 v78, v14, v6, v78
	v_fma_f32 v79, v15, v6, v79
	buffer_load_dwordx4 v40, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s46
	buffer_load_dwordx4 v41, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s47
	buffer_load_dword v28, v24, s[28:31], 0 offen
	buffer_load_dword v29, v25, s[28:31], 0 offen
	buffer_load_dword v30, v26, s[28:31], 0 offen
	buffer_load_dword v31, v27, s[28:31], 0 offen
	s_waitcnt vmcnt(6)
	v_mul_f32_dpp v4, v23, v36 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[80:87], a[0:7], 0
	buffer_load_dword v20, v18, s[32:35], 0 offen
	ds_read_b128 a[32:35], v2 offset:8320
	ds_read_b128 a[36:39], v2 offset:8384
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[88:95], a[0:7], 0
	buffer_load_dwordx4 a[64:67], v42, s[24:27], 0 offen
	s_nop 5
	v_fma_f32 v80, v8, v4, v80
	v_fma_f32 v81, v9, v4, v81
	v_fma_f32 v82, v10, v4, v82
	v_fma_f32 v83, v11, v4, v83
	v_mul_f32_dpp v6, v23, v37 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[80:87], a[8:15], 0
	ds_read_b128 a[40:43], v2 offset:8832
	ds_read_b128 a[44:47], v2 offset:8896
	s_nop 5
	v_fma_f32 v96, v12, v4, v96
	v_fma_f32 v97, v13, v4, v97
	v_fma_f32 v98, v14, v4, v98
	v_fma_f32 v99, v15, v4, v99
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[88:95], a[8:15], 0
	buffer_load_dwordx4 a[68:71], v42, s[24:27], 0 offen offset:1024
	s_add_u32 s52, 0x100, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s58, s58, 0
	s_nop 5
	v_fma_f32 v84, v8, v6, v84
	v_fma_f32 v85, v9, v6, v85
	v_fma_f32 v86, v10, v6, v86
	v_fma_f32 v87, v11, v6, v87
	v_mul_f32_dpp v4, v23, v38 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[80:87], a[16:23], 0
	ds_read_b128 a[48:51], v2 offset:9344
	ds_read_b128 a[52:55], v2 offset:9408
	s_add_u32 s76, s73, s24
	s_addc_u32 s77, 0, s77
	s_nop 5
	v_fma_f32 v100, v12, v6, v100
	v_fma_f32 v101, v13, v6, v101
	v_fma_f32 v102, v14, v6, v102
	v_fma_f32 v103, v15, v6, v103
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[88:95], a[16:23], 0
	buffer_load_dwordx4 a[72:75], v43, s[24:27], 0 offen
	s_add_u32 s52, 0x180, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s57, s57, 0
	s_cselect_b32 s6, s6, 0
	s_nop 5
	v_fma_f32 v88, v8, v4, v88
	v_fma_f32 v89, v9, v4, v89
	v_fma_f32 v90, v10, v4, v90
	v_fma_f32 v91, v11, v4, v91
	v_mul_f32_dpp v6, v23, v39 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[80:87], a[24:31], 0
	ds_read_b128 a[56:59], v2 offset:9856
	ds_read_b128 a[60:63], v2 offset:9920
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	s_nop 5
	v_fma_f32 v104, v12, v4, v104
	v_fma_f32 v105, v13, v4, v105
	v_fma_f32 v106, v14, v4, v106
	v_fma_f32 v107, v15, v4, v107
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[88:95], a[24:31], 0
	buffer_load_dwordx4 a[76:79], v43, s[24:27], 0 offen offset:1024
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_nop 5
	v_fma_f32 v92, v8, v6, v92
	v_fma_f32 v93, v9, v6, v93
	v_fma_f32 v94, v10, v6, v94
	v_fma_f32 v95, v11, v6, v95
	s_nop 5
	v_fma_f32 v108, v12, v6, v108
	v_fma_f32 v109, v13, v6, v109
	v_fma_f32 v110, v14, v6, v110
	v_fma_f32 v111, v15, v6, v111
	s_addk_i32 s70, 0x80
	s_cmp_lt_i32 s70, s71
	s_cbranch_scc0 label_0452
	s_waitcnt vmcnt(2) lgkmcnt(0)
	s_barrier
	v_mov_b32_e32 v36, v32
	v_mov_b32_e32 v37, v33
	v_mov_b32_e32 v38, v34
	v_mov_b32_e32 v39, v35
	v_mul_f32_dpp v4, v20, v36 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[64:71], a[32:39], 0
	buffer_load_dword v23, v19, s[32:35], 0 offen
	v_mul_f32_dpp v6, v20, v37 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[64:71], a[40:47], 0
	buffer_load_dwordx4 a[80:83], v42, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v48, v8, v4, v48
	v_fma_f32 v49, v9, v4, v49
	v_fma_f32 v50, v10, v4, v50
	v_fma_f32 v51, v11, v4, v51
	v_mul_f32_dpp v4, v20, v38 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[64:71], a[48:55], 0
	s_nop 5
	v_fma_f32 v52, v12, v6, v52
	v_fma_f32 v53, v13, v6, v53
	v_fma_f32 v54, v14, v6, v54
	v_fma_f32 v55, v15, v6, v55
	v_mul_f32_dpp v6, v20, v39 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[64:71], a[56:63], 0
	buffer_load_dwordx4 a[84:87], v42, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v56, v8, v4, v56
	v_fma_f32 v57, v9, v4, v57
	v_fma_f32 v58, v10, v4, v58
	v_fma_f32 v59, v11, v4, v59
	s_waitcnt vmcnt(3)
	v_mul_f32_dpp v4, v20, v36 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[72:79], a[32:39], 0
	s_nop 5
	v_fma_f32 v60, v12, v6, v60
	v_fma_f32 v61, v13, v6, v61
	v_fma_f32 v62, v14, v6, v62
	v_fma_f32 v63, v15, v6, v63
	v_mul_f32_dpp v6, v20, v37 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[72:79], a[40:47], 0
	buffer_load_dwordx4 a[88:91], v43, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v64, v8, v4, v64
	v_fma_f32 v65, v9, v4, v65
	v_fma_f32 v66, v10, v4, v66
	v_fma_f32 v67, v11, v4, v67
	v_mul_f32_dpp v4, v20, v38 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[72:79], a[48:55], 0
	s_add_u32 s52, 0x80, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s73, s73, 0
	s_cselect_b32 s4, s4, 0
	s_nop 5
	v_fma_f32 v68, v12, v6, v68
	v_fma_f32 v69, v13, v6, v69
	v_fma_f32 v70, v14, v6, v70
	v_fma_f32 v71, v15, v6, v71
	v_mul_f32_dpp v6, v20, v39 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[72:79], a[56:63], 0
	buffer_load_dwordx4 a[92:95], v43, s[76:79], 0 offen offset:1024
	s_add_u32 s32, s4, s32
	s_addc_u32 s33, 0, s33
	s_nop 5
	v_fma_f32 v72, v8, v4, v72
	v_fma_f32 v73, v9, v4, v73
	v_fma_f32 v74, v10, v4, v74
	v_fma_f32 v75, v11, v4, v75
	s_nop 5
	v_fma_f32 v76, v12, v6, v76
	v_fma_f32 v77, v13, v6, v77
	v_fma_f32 v78, v14, v6, v78
	v_fma_f32 v79, v15, v6, v79
	buffer_load_dwordx4 v40, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s47
	buffer_load_dwordx4 v41, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s46
	buffer_load_dword v32, v24, s[28:31], 0 offen
	buffer_load_dword v33, v25, s[28:31], 0 offen
	buffer_load_dword v34, v26, s[28:31], 0 offen
	buffer_load_dword v35, v27, s[28:31], 0 offen
	s_waitcnt vmcnt(6)
	v_mul_f32_dpp v4, v23, v36 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[80:87], a[32:39], 0
	buffer_load_dword v20, v18, s[32:35], 0 offen
	ds_read_b128 a[0:3], v2
	ds_read_b128 a[4:7], v2 offset:64
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[88:95], a[32:39], 0
	buffer_load_dwordx4 a[64:67], v42, s[24:27], 0 offen
	s_nop 5
	v_fma_f32 v80, v8, v4, v80
	v_fma_f32 v81, v9, v4, v81
	v_fma_f32 v82, v10, v4, v82
	v_fma_f32 v83, v11, v4, v83
	v_mul_f32_dpp v6, v23, v37 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[80:87], a[40:47], 0
	ds_read_b128 a[8:11], v2 offset:512
	ds_read_b128 a[12:15], v2 offset:576
	s_nop 5
	v_fma_f32 v96, v12, v4, v96
	v_fma_f32 v97, v13, v4, v97
	v_fma_f32 v98, v14, v4, v98
	v_fma_f32 v99, v15, v4, v99
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[88:95], a[40:47], 0
	buffer_load_dwordx4 a[68:71], v42, s[24:27], 0 offen offset:1024
	s_add_u32 s52, 0x100, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s58, s58, 0
	s_nop 5
	v_fma_f32 v84, v8, v6, v84
	v_fma_f32 v85, v9, v6, v85
	v_fma_f32 v86, v10, v6, v86
	v_fma_f32 v87, v11, v6, v87
	v_mul_f32_dpp v4, v23, v38 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[80:87], a[48:55], 0
	ds_read_b128 a[16:19], v2 offset:1024
	ds_read_b128 a[20:23], v2 offset:1088
	s_add_u32 s76, s73, s24
	s_addc_u32 s77, 0, s77
	s_nop 5
	v_fma_f32 v100, v12, v6, v100
	v_fma_f32 v101, v13, v6, v101
	v_fma_f32 v102, v14, v6, v102
	v_fma_f32 v103, v15, v6, v103
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[88:95], a[48:55], 0
	buffer_load_dwordx4 a[72:75], v43, s[24:27], 0 offen
	s_add_u32 s52, 0x180, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s57, s57, 0
	s_cselect_b32 s6, s6, 0
	s_nop 5
	v_fma_f32 v88, v8, v4, v88
	v_fma_f32 v89, v9, v4, v89
	v_fma_f32 v90, v10, v4, v90
	v_fma_f32 v91, v11, v4, v91
	v_mul_f32_dpp v6, v23, v39 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[80:87], a[56:63], 0
	ds_read_b128 a[24:27], v2 offset:1536
	ds_read_b128 a[28:31], v2 offset:1600
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	s_nop 5
	v_fma_f32 v104, v12, v4, v104
	v_fma_f32 v105, v13, v4, v105
	v_fma_f32 v106, v14, v4, v106
	v_fma_f32 v107, v15, v4, v107
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[88:95], a[56:63], 0
	buffer_load_dwordx4 a[76:79], v43, s[24:27], 0 offen offset:1024
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_nop 5
	v_fma_f32 v92, v8, v6, v92
	v_fma_f32 v93, v9, v6, v93
	v_fma_f32 v94, v10, v6, v94
	v_fma_f32 v95, v11, v6, v95
	s_nop 5
	v_fma_f32 v108, v12, v6, v108
	v_fma_f32 v109, v13, v6, v109
	v_fma_f32 v110, v14, v6, v110
	v_fma_f32 v111, v15, v6, v111
	s_addk_i32 s70, 0x80
	s_cmp_lt_i32 s70, s71
	s_cbranch_scc0 label_0452
	s_branch label_0215

0000000000003a48 <label_0452>:
	s_cmp_eq_u32 s74, 0
	s_cbranch_scc0 label_067C
	v_cvt_pk_bf16_f32 v48, v48, v49
	v_cvt_pk_bf16_f32 v49, v50, v51
	v_cvt_pk_bf16_f32 v50, v52, v53
	v_cvt_pk_bf16_f32 v51, v54, v55
	v_cvt_pk_bf16_f32 v52, v56, v57
	v_cvt_pk_bf16_f32 v53, v58, v59
	v_cvt_pk_bf16_f32 v54, v60, v61
	v_cvt_pk_bf16_f32 v55, v62, v63
	v_cvt_pk_bf16_f32 v56, v64, v65
	v_cvt_pk_bf16_f32 v57, v66, v67
	v_cvt_pk_bf16_f32 v58, v68, v69
	v_cvt_pk_bf16_f32 v59, v70, v71
	v_cvt_pk_bf16_f32 v60, v72, v73
	v_cvt_pk_bf16_f32 v61, v74, v75
	v_cvt_pk_bf16_f32 v62, v76, v77
	v_cvt_pk_bf16_f32 v63, v78, v79
	ds_write_b64 v16, v[48:49]
	ds_write_b64 v16, v[50:51] offset:4352
	ds_write_b64 v16, v[52:53] offset:8704
	ds_write_b64 v16, v[54:55] offset:13056
	ds_write_b64 v16, v[56:57] offset:2176
	ds_write_b64 v16, v[58:59] offset:6528
	ds_write_b64 v16, v[60:61] offset:10880
	ds_write_b64 v16, v[62:63] offset:15232
	v_cvt_pk_bf16_f32 v80, v80, v81
	v_cvt_pk_bf16_f32 v81, v82, v83
	v_cvt_pk_bf16_f32 v82, v84, v85
	v_cvt_pk_bf16_f32 v83, v86, v87
	v_cvt_pk_bf16_f32 v84, v88, v89
	v_cvt_pk_bf16_f32 v85, v90, v91
	v_cvt_pk_bf16_f32 v86, v92, v93
	v_cvt_pk_bf16_f32 v87, v94, v95
	v_cvt_pk_bf16_f32 v88, v96, v97
	v_cvt_pk_bf16_f32 v89, v98, v99
	v_cvt_pk_bf16_f32 v90, v100, v101
	v_cvt_pk_bf16_f32 v91, v102, v103
	v_cvt_pk_bf16_f32 v92, v104, v105
	v_cvt_pk_bf16_f32 v93, v106, v107
	v_cvt_pk_bf16_f32 v94, v108, v109
	v_cvt_pk_bf16_f32 v95, v110, v111
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
	v_add_u32_e32 v64, v6, v7
	v_readlane_b32 s72, v3, 2
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 3
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v65, v6, v7
	v_readlane_b32 s72, v3, 4
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 5
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v66, v6, v7
	v_readlane_b32 s72, v3, 6
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 7
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v67, v6, v7
	v_readlane_b32 s72, v3, 8
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 9
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v68, v6, v7
	v_readlane_b32 s72, v3, 10
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 11
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v69, v6, v7
	v_readlane_b32 s72, v3, 12
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 13
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v70, v6, v7
	v_readlane_b32 s72, v3, 14
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 15
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v71, v6, v7
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 2, 4
	v_mul_lo_u32 v4, v4, s53
	v_and_b32_e64 v5, v0, 1
	v_add_u32_e32 v4, v4, v5
	v_lshlrev_b32_e32 v4, 2, v4
	v_add_u32_e32 v64, v64, v4
	v_add_u32_e32 v65, v65, v4
	v_add_u32_e32 v66, v66, v4
	v_add_u32_e32 v67, v67, v4
	v_add_u32_e32 v68, v68, v4
	v_add_u32_e32 v69, v69, v4
	v_add_u32_e32 v70, v70, v4
	v_add_u32_e32 v71, v71, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v48, v17
	ds_read_b32 v49, v17 offset:64
	ds_read_b32 v50, v17 offset:2176
	ds_read_b32 v51, v17 offset:2240
	ds_read_b32 v52, v17 offset:4352
	ds_read_b32 v53, v17 offset:4416
	ds_read_b32 v54, v17 offset:6528
	ds_read_b32 v55, v17 offset:6592
	ds_read_b32 v56, v17 offset:8704
	ds_read_b32 v57, v17 offset:8768
	ds_read_b32 v58, v17 offset:10880
	ds_read_b32 v59, v17 offset:10944
	ds_read_b32 v60, v17 offset:13056
	ds_read_b32 v61, v17 offset:13120
	ds_read_b32 v62, v17 offset:15232
	ds_read_b32 v63, v17 offset:15296
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_or_b32 s9, s9, 0x40000
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v64
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v48, v6, s[8:11], 0 offen
	buffer_store_dword v50, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v65
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v49, v6, s[8:11], 0 offen
	buffer_store_dword v51, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v66
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v52, v6, s[8:11], 0 offen
	buffer_store_dword v54, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v67
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v53, v6, s[8:11], 0 offen
	buffer_store_dword v55, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v68
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v56, v6, s[8:11], 0 offen
	buffer_store_dword v58, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v69
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v57, v6, s[8:11], 0 offen
	buffer_store_dword v59, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v70
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v60, v6, s[8:11], 0 offen
	buffer_store_dword v62, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v71
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v61, v6, s[8:11], 0 offen
	buffer_store_dword v63, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_write_b64 v16, v[80:81]
	ds_write_b64 v16, v[82:83] offset:4352
	ds_write_b64 v16, v[84:85] offset:8704
	ds_write_b64 v16, v[86:87] offset:13056
	ds_write_b64 v16, v[88:89] offset:2176
	ds_write_b64 v16, v[90:91] offset:6528
	ds_write_b64 v16, v[92:93] offset:10880
	ds_write_b64 v16, v[94:95] offset:15232
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v80, v17
	ds_read_b32 v81, v17 offset:64
	ds_read_b32 v82, v17 offset:2176
	ds_read_b32 v83, v17 offset:2240
	ds_read_b32 v84, v17 offset:4352
	ds_read_b32 v85, v17 offset:4416
	ds_read_b32 v86, v17 offset:6528
	ds_read_b32 v87, v17 offset:6592
	ds_read_b32 v88, v17 offset:8704
	ds_read_b32 v89, v17 offset:8768
	ds_read_b32 v90, v17 offset:10880
	ds_read_b32 v91, v17 offset:10944
	ds_read_b32 v92, v17 offset:13056
	ds_read_b32 v93, v17 offset:13120
	ds_read_b32 v94, v17 offset:15232
	ds_read_b32 v95, v17 offset:15296
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_add_u32 s8, 0x100, s8
	s_addc_u32 s9, 0, s9
	s_or_b32 s9, s9, 0x40000
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v64
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v80, v6, s[8:11], 0 offen
	buffer_store_dword v82, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v65
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v81, v6, s[8:11], 0 offen
	buffer_store_dword v83, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v66
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v84, v6, s[8:11], 0 offen
	buffer_store_dword v86, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v67
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v85, v6, s[8:11], 0 offen
	buffer_store_dword v87, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v68
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v88, v6, s[8:11], 0 offen
	buffer_store_dword v90, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v69
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v89, v6, s[8:11], 0 offen
	buffer_store_dword v91, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v70
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v92, v6, s[8:11], 0 offen
	buffer_store_dword v94, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v71
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v93, v6, s[8:11], 0 offen
	buffer_store_dword v95, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	s_branch label_117A

00000000000042f0 <label_067C>:
	ds_write_b64 v16, v[48:49]
	ds_write_b64 v16, v[52:53] offset:4352
	ds_write_b64 v16, v[56:57] offset:8704
	ds_write_b64 v16, v[60:61] offset:13056
	ds_write_b64 v16, v[64:65] offset:2176
	ds_write_b64 v16, v[68:69] offset:6528
	ds_write_b64 v16, v[72:73] offset:10880
	ds_write_b64 v16, v[76:77] offset:15232
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
	v_add_u32_e32 v64, v6, v7
	v_readlane_b32 s72, v3, 2
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 3
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v65, v6, v7
	v_readlane_b32 s72, v3, 4
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 5
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v66, v6, v7
	v_readlane_b32 s72, v3, 6
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 7
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v67, v6, v7
	v_readlane_b32 s72, v3, 8
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 9
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v68, v6, v7
	v_readlane_b32 s72, v3, 10
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 11
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v69, v6, v7
	v_readlane_b32 s72, v3, 12
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 13
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v70, v6, v7
	v_readlane_b32 s72, v3, 14
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 15
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v71, v6, v7
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 2, 4
	v_mul_lo_u32 v4, v4, s53
	v_and_b32_e64 v5, v0, 1
	v_add_u32_e32 v4, v4, v5
	v_lshlrev_b32_e32 v4, 2, v4
	v_add_u32_e32 v64, v64, v4
	v_add_u32_e32 v65, v65, v4
	v_add_u32_e32 v66, v66, v4
	v_add_u32_e32 v67, v67, v4
	v_add_u32_e32 v68, v68, v4
	v_add_u32_e32 v69, v69, v4
	v_add_u32_e32 v70, v70, v4
	v_add_u32_e32 v71, v71, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v48, v17
	ds_read_b32 v49, v17 offset:64
	ds_read_b32 v52, v17 offset:2176
	ds_read_b32 v53, v17 offset:2240
	ds_read_b32 v56, v17 offset:4352
	ds_read_b32 v57, v17 offset:4416
	ds_read_b32 v60, v17 offset:6528
	ds_read_b32 v61, v17 offset:6592
	ds_read_b32 v64, v17 offset:8704
	ds_read_b32 v65, v17 offset:8768
	ds_read_b32 v68, v17 offset:10880
	ds_read_b32 v69, v17 offset:10944
	ds_read_b32 v72, v17 offset:13056
	ds_read_b32 v73, v17 offset:13120
	ds_read_b32 v76, v17 offset:15232
	ds_read_b32 v77, v17 offset:15296
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v64
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v48, s[8:9]
	global_atomic_add_f32 v6, v52, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v65
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v49, s[8:9]
	global_atomic_add_f32 v6, v53, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v66
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v56, s[8:9]
	global_atomic_add_f32 v6, v60, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v67
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v57, s[8:9]
	global_atomic_add_f32 v6, v61, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v68
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v64, s[8:9]
	global_atomic_add_f32 v6, v68, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v69
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v65, s[8:9]
	global_atomic_add_f32 v6, v69, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v70
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v72, s[8:9]
	global_atomic_add_f32 v6, v76, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v71
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v73, s[8:9]
	global_atomic_add_f32 v6, v77, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[50:51]
	ds_write_b64 v16, v[54:55] offset:4352
	ds_write_b64 v16, v[58:59] offset:8704
	ds_write_b64 v16, v[62:63] offset:13056
	ds_write_b64 v16, v[66:67] offset:2176
	ds_write_b64 v16, v[70:71] offset:6528
	ds_write_b64 v16, v[74:75] offset:10880
	ds_write_b64 v16, v[78:79] offset:15232
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v50, v17
	ds_read_b32 v51, v17 offset:64
	ds_read_b32 v54, v17 offset:2176
	ds_read_b32 v55, v17 offset:2240
	ds_read_b32 v58, v17 offset:4352
	ds_read_b32 v59, v17 offset:4416
	ds_read_b32 v62, v17 offset:6528
	ds_read_b32 v63, v17 offset:6592
	ds_read_b32 v66, v17 offset:8704
	ds_read_b32 v67, v17 offset:8768
	ds_read_b32 v70, v17 offset:10880
	ds_read_b32 v71, v17 offset:10944
	ds_read_b32 v74, v17 offset:13056
	ds_read_b32 v75, v17 offset:13120
	ds_read_b32 v78, v17 offset:15232
	ds_read_b32 v79, v17 offset:15296
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v64
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v50, s[8:9] offset:8
	global_atomic_add_f32 v6, v54, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v65
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v51, s[8:9] offset:8
	global_atomic_add_f32 v6, v55, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v66
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v58, s[8:9] offset:8
	global_atomic_add_f32 v6, v62, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v67
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v59, s[8:9] offset:8
	global_atomic_add_f32 v6, v63, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v68
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v66, s[8:9] offset:8
	global_atomic_add_f32 v6, v70, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v69
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v67, s[8:9] offset:8
	global_atomic_add_f32 v6, v71, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v70
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v74, s[8:9] offset:8
	global_atomic_add_f32 v6, v78, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v71
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v75, s[8:9] offset:8
	global_atomic_add_f32 v6, v79, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[80:81]
	ds_write_b64 v16, v[84:85] offset:4352
	ds_write_b64 v16, v[88:89] offset:8704
	ds_write_b64 v16, v[92:93] offset:13056
	ds_write_b64 v16, v[96:97] offset:2176
	ds_write_b64 v16, v[100:101] offset:6528
	ds_write_b64 v16, v[104:105] offset:10880
	ds_write_b64 v16, v[108:109] offset:15232
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v80, v17
	ds_read_b32 v81, v17 offset:64
	ds_read_b32 v84, v17 offset:2176
	ds_read_b32 v85, v17 offset:2240
	ds_read_b32 v88, v17 offset:4352
	ds_read_b32 v89, v17 offset:4416
	ds_read_b32 v92, v17 offset:6528
	ds_read_b32 v93, v17 offset:6592
	ds_read_b32 v96, v17 offset:8704
	ds_read_b32 v97, v17 offset:8768
	ds_read_b32 v100, v17 offset:10880
	ds_read_b32 v101, v17 offset:10944
	ds_read_b32 v104, v17 offset:13056
	ds_read_b32 v105, v17 offset:13120
	ds_read_b32 v108, v17 offset:15232
	ds_read_b32 v109, v17 offset:15296
	s_mul_i32 s52, s61, 4
	s_add_u32 s8, s52, s8
	s_addc_u32 s9, 0, s9
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v64
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v80, s[8:9]
	global_atomic_add_f32 v6, v84, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v65
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v81, s[8:9]
	global_atomic_add_f32 v6, v85, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v66
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v88, s[8:9]
	global_atomic_add_f32 v6, v92, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v67
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v89, s[8:9]
	global_atomic_add_f32 v6, v93, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v68
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v96, s[8:9]
	global_atomic_add_f32 v6, v100, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v69
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v97, s[8:9]
	global_atomic_add_f32 v6, v101, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v70
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v104, s[8:9]
	global_atomic_add_f32 v6, v108, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v71
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v105, s[8:9]
	global_atomic_add_f32 v6, v109, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[82:83]
	ds_write_b64 v16, v[86:87] offset:4352
	ds_write_b64 v16, v[90:91] offset:8704
	ds_write_b64 v16, v[94:95] offset:13056
	ds_write_b64 v16, v[98:99] offset:2176
	ds_write_b64 v16, v[102:103] offset:6528
	ds_write_b64 v16, v[106:107] offset:10880
	ds_write_b64 v16, v[110:111] offset:15232
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v82, v17
	ds_read_b32 v83, v17 offset:64
	ds_read_b32 v86, v17 offset:2176
	ds_read_b32 v87, v17 offset:2240
	ds_read_b32 v90, v17 offset:4352
	ds_read_b32 v91, v17 offset:4416
	ds_read_b32 v94, v17 offset:6528
	ds_read_b32 v95, v17 offset:6592
	ds_read_b32 v98, v17 offset:8704
	ds_read_b32 v99, v17 offset:8768
	ds_read_b32 v102, v17 offset:10880
	ds_read_b32 v103, v17 offset:10944
	ds_read_b32 v106, v17 offset:13056
	ds_read_b32 v107, v17 offset:13120
	ds_read_b32 v110, v17 offset:15232
	ds_read_b32 v111, v17 offset:15296
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v64
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v82, s[8:9] offset:8
	global_atomic_add_f32 v6, v86, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v65
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v83, s[8:9] offset:8
	global_atomic_add_f32 v6, v87, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v66
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v90, s[8:9] offset:8
	global_atomic_add_f32 v6, v94, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v67
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v91, s[8:9] offset:8
	global_atomic_add_f32 v6, v95, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v68
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v98, s[8:9] offset:8
	global_atomic_add_f32 v6, v102, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v69
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v99, s[8:9] offset:8
	global_atomic_add_f32 v6, v103, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v70
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v106, s[8:9] offset:8
	global_atomic_add_f32 v6, v110, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v71
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v107, s[8:9] offset:8
	global_atomic_add_f32 v6, v111, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	s_branch label_117A

0000000000005018 <label_09C9>:
	s_waitcnt vmcnt(2) lgkmcnt(0)
	s_barrier
	v_mov_b32_e32 v36, v28
	v_mov_b32_e32 v37, v29
	v_mov_b32_e32 v38, v30
	v_mov_b32_e32 v39, v31
	v_mul_f32_dpp v4, v20, v36 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[64:71], a[0:7], 0
	buffer_load_dword v23, v19, s[32:35], 0 offen
	buffer_load_dwordx4 a[80:83], v42, s[76:79], 0 offen
	v_mul_f32_dpp v6, v20, v37 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[64:71], a[8:15], 0
	s_nop 5
	v_fma_f32 v48, v8, v4, v48
	v_fma_f32 v49, v9, v4, v49
	v_fma_f32 v50, v10, v4, v50
	v_fma_f32 v51, v11, v4, v51
	v_mul_f32_dpp v4, v20, v38 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[64:71], a[16:23], 0
	buffer_load_dwordx4 a[84:87], v42, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v52, v12, v6, v52
	v_fma_f32 v53, v13, v6, v53
	v_fma_f32 v54, v14, v6, v54
	v_fma_f32 v55, v15, v6, v55
	v_mul_f32_dpp v6, v20, v39 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[64:71], a[24:31], 0
	s_nop 5
	v_fma_f32 v56, v8, v4, v56
	v_fma_f32 v57, v9, v4, v57
	v_fma_f32 v58, v10, v4, v58
	v_fma_f32 v59, v11, v4, v59
	s_waitcnt vmcnt(3)
	v_mul_f32_dpp v4, v20, v36 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[72:79], a[0:7], 0
	buffer_load_dwordx4 a[88:91], v43, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v60, v12, v6, v60
	v_fma_f32 v61, v13, v6, v61
	v_fma_f32 v62, v14, v6, v62
	v_fma_f32 v63, v15, v6, v63
	v_mul_f32_dpp v6, v20, v37 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[72:79], a[8:15], 0
	s_nop 5
	v_fma_f32 v64, v8, v4, v64
	v_fma_f32 v65, v9, v4, v65
	v_fma_f32 v66, v10, v4, v66
	v_fma_f32 v67, v11, v4, v67
	v_mul_f32_dpp v4, v20, v38 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[72:79], a[16:23], 0
	buffer_load_dwordx4 a[92:95], v43, s[76:79], 0 offen offset:1024
	s_add_u32 s52, 0x80, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s73, s73, 0
	s_cselect_b32 s4, s4, 0
	s_nop 5
	v_fma_f32 v68, v12, v6, v68
	v_fma_f32 v69, v13, v6, v69
	v_fma_f32 v70, v14, v6, v70
	v_fma_f32 v71, v15, v6, v71
	v_mul_f32_dpp v6, v20, v39 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[72:79], a[24:31], 0
	s_add_u32 s32, s4, s32
	s_addc_u32 s33, 0, s33
	s_nop 5
	v_fma_f32 v72, v8, v4, v72
	v_fma_f32 v73, v9, v4, v73
	v_fma_f32 v74, v10, v4, v74
	v_fma_f32 v75, v11, v4, v75
	s_nop 5
	v_fma_f32 v76, v12, v6, v76
	v_fma_f32 v77, v13, v6, v77
	v_fma_f32 v78, v14, v6, v78
	v_fma_f32 v79, v15, v6, v79
	buffer_load_dwordx4 v40, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s46
	buffer_load_dwordx4 v41, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s47
	buffer_load_dword v28, v24, s[28:31], 0 offen
	buffer_load_dword v29, v25, s[28:31], 0 offen
	buffer_load_dword v30, v26, s[28:31], 0 offen
	buffer_load_dword v31, v27, s[28:31], 0 offen
	s_waitcnt vmcnt(6)
	v_mul_f32_dpp v4, v23, v36 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[80:87], a[0:7], 0
	buffer_load_dword v20, v18, s[32:35], 0 offen
	buffer_load_dwordx4 a[64:67], v42, s[24:27], 0 offen
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[88:95], a[0:7], 0
	ds_read_b128 a[32:35], v2 offset:8320
	ds_read_b128 a[36:39], v2 offset:8384
	s_nop 5
	v_fma_f32 v80, v8, v4, v80
	v_fma_f32 v81, v9, v4, v81
	v_fma_f32 v82, v10, v4, v82
	v_fma_f32 v83, v11, v4, v83
	v_mul_f32_dpp v6, v23, v37 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[80:87], a[8:15], 0
	buffer_load_dwordx4 a[68:71], v42, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v96, v12, v4, v96
	v_fma_f32 v97, v13, v4, v97
	v_fma_f32 v98, v14, v4, v98
	v_fma_f32 v99, v15, v4, v99
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[88:95], a[8:15], 0
	ds_read_b128 a[40:43], v2 offset:8832
	ds_read_b128 a[44:47], v2 offset:8896
	s_add_u32 s52, 0x100, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s58, s58, 0
	s_nop 5
	v_fma_f32 v84, v8, v6, v84
	v_fma_f32 v85, v9, v6, v85
	v_fma_f32 v86, v10, v6, v86
	v_fma_f32 v87, v11, v6, v87
	v_mul_f32_dpp v4, v23, v38 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[80:87], a[16:23], 0
	buffer_load_dwordx4 a[72:75], v43, s[24:27], 0 offen
	s_add_u32 s76, s73, s24
	s_addc_u32 s77, 0, s77
	s_nop 5
	v_fma_f32 v100, v12, v6, v100
	v_fma_f32 v101, v13, v6, v101
	v_fma_f32 v102, v14, v6, v102
	v_fma_f32 v103, v15, v6, v103
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[88:95], a[16:23], 0
	ds_read_b128 a[48:51], v2 offset:9344
	ds_read_b128 a[52:55], v2 offset:9408
	s_add_u32 s52, 0x180, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s57, s57, 0
	s_cselect_b32 s6, s6, 0
	s_nop 5
	v_fma_f32 v88, v8, v4, v88
	v_fma_f32 v89, v9, v4, v89
	v_fma_f32 v90, v10, v4, v90
	v_fma_f32 v91, v11, v4, v91
	v_mul_f32_dpp v6, v23, v39 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[80:87], a[24:31], 0
	buffer_load_dwordx4 a[76:79], v43, s[24:27], 0 offen offset:1024
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	s_nop 5
	v_fma_f32 v104, v12, v4, v104
	v_fma_f32 v105, v13, v4, v105
	v_fma_f32 v106, v14, v4, v106
	v_fma_f32 v107, v15, v4, v107
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[88:95], a[24:31], 0
	ds_read_b128 a[56:59], v2 offset:9856
	ds_read_b128 a[60:63], v2 offset:9920
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_nop 5
	v_fma_f32 v92, v8, v6, v92
	v_fma_f32 v93, v9, v6, v93
	v_fma_f32 v94, v10, v6, v94
	v_fma_f32 v95, v11, v6, v95
	s_nop 5
	v_fma_f32 v108, v12, v6, v108
	v_fma_f32 v109, v13, v6, v109
	v_fma_f32 v110, v14, v6, v110
	v_fma_f32 v111, v15, v6, v111
	s_addk_i32 s70, 0x80
	s_cmp_lt_i32 s70, s71
	s_cbranch_scc0 label_0C06
	s_waitcnt vmcnt(2) lgkmcnt(0)
	s_barrier
	v_mov_b32_e32 v36, v32
	v_mov_b32_e32 v37, v33
	v_mov_b32_e32 v38, v34
	v_mov_b32_e32 v39, v35
	v_mul_f32_dpp v4, v20, v36 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[64:71], a[32:39], 0
	buffer_load_dword v23, v19, s[32:35], 0 offen
	buffer_load_dwordx4 a[80:83], v42, s[76:79], 0 offen
	v_mul_f32_dpp v6, v20, v37 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[64:71], a[40:47], 0
	s_nop 5
	v_fma_f32 v48, v8, v4, v48
	v_fma_f32 v49, v9, v4, v49
	v_fma_f32 v50, v10, v4, v50
	v_fma_f32 v51, v11, v4, v51
	v_mul_f32_dpp v4, v20, v38 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[64:71], a[48:55], 0
	buffer_load_dwordx4 a[84:87], v42, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v52, v12, v6, v52
	v_fma_f32 v53, v13, v6, v53
	v_fma_f32 v54, v14, v6, v54
	v_fma_f32 v55, v15, v6, v55
	v_mul_f32_dpp v6, v20, v39 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[64:71], a[56:63], 0
	s_nop 5
	v_fma_f32 v56, v8, v4, v56
	v_fma_f32 v57, v9, v4, v57
	v_fma_f32 v58, v10, v4, v58
	v_fma_f32 v59, v11, v4, v59
	s_waitcnt vmcnt(3)
	v_mul_f32_dpp v4, v20, v36 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[72:79], a[32:39], 0
	buffer_load_dwordx4 a[88:91], v43, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v60, v12, v6, v60
	v_fma_f32 v61, v13, v6, v61
	v_fma_f32 v62, v14, v6, v62
	v_fma_f32 v63, v15, v6, v63
	v_mul_f32_dpp v6, v20, v37 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[72:79], a[40:47], 0
	s_nop 5
	v_fma_f32 v64, v8, v4, v64
	v_fma_f32 v65, v9, v4, v65
	v_fma_f32 v66, v10, v4, v66
	v_fma_f32 v67, v11, v4, v67
	v_mul_f32_dpp v4, v20, v38 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[72:79], a[48:55], 0
	buffer_load_dwordx4 a[92:95], v43, s[76:79], 0 offen offset:1024
	s_add_u32 s52, 0x80, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s73, s73, 0
	s_cselect_b32 s4, s4, 0
	s_nop 5
	v_fma_f32 v68, v12, v6, v68
	v_fma_f32 v69, v13, v6, v69
	v_fma_f32 v70, v14, v6, v70
	v_fma_f32 v71, v15, v6, v71
	v_mul_f32_dpp v6, v20, v39 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[72:79], a[56:63], 0
	s_add_u32 s32, s4, s32
	s_addc_u32 s33, 0, s33
	s_nop 5
	v_fma_f32 v72, v8, v4, v72
	v_fma_f32 v73, v9, v4, v73
	v_fma_f32 v74, v10, v4, v74
	v_fma_f32 v75, v11, v4, v75
	s_nop 5
	v_fma_f32 v76, v12, v6, v76
	v_fma_f32 v77, v13, v6, v77
	v_fma_f32 v78, v14, v6, v78
	v_fma_f32 v79, v15, v6, v79
	buffer_load_dwordx4 v40, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s47
	buffer_load_dwordx4 v41, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s46
	buffer_load_dword v32, v24, s[28:31], 0 offen
	buffer_load_dword v33, v25, s[28:31], 0 offen
	buffer_load_dword v34, v26, s[28:31], 0 offen
	buffer_load_dword v35, v27, s[28:31], 0 offen
	s_waitcnt vmcnt(6)
	v_mul_f32_dpp v4, v23, v36 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[80:87], a[32:39], 0
	buffer_load_dword v20, v18, s[32:35], 0 offen
	buffer_load_dwordx4 a[64:67], v42, s[24:27], 0 offen
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[88:95], a[32:39], 0
	ds_read_b128 a[0:3], v2
	ds_read_b128 a[4:7], v2 offset:64
	s_nop 5
	v_fma_f32 v80, v8, v4, v80
	v_fma_f32 v81, v9, v4, v81
	v_fma_f32 v82, v10, v4, v82
	v_fma_f32 v83, v11, v4, v83
	v_mul_f32_dpp v6, v23, v37 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[80:87], a[40:47], 0
	buffer_load_dwordx4 a[68:71], v42, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v96, v12, v4, v96
	v_fma_f32 v97, v13, v4, v97
	v_fma_f32 v98, v14, v4, v98
	v_fma_f32 v99, v15, v4, v99
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[88:95], a[40:47], 0
	ds_read_b128 a[8:11], v2 offset:512
	ds_read_b128 a[12:15], v2 offset:576
	s_add_u32 s52, 0x100, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s58, s58, 0
	s_nop 5
	v_fma_f32 v84, v8, v6, v84
	v_fma_f32 v85, v9, v6, v85
	v_fma_f32 v86, v10, v6, v86
	v_fma_f32 v87, v11, v6, v87
	v_mul_f32_dpp v4, v23, v38 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[80:87], a[48:55], 0
	buffer_load_dwordx4 a[72:75], v43, s[24:27], 0 offen
	s_add_u32 s76, s73, s24
	s_addc_u32 s77, 0, s77
	s_nop 5
	v_fma_f32 v100, v12, v6, v100
	v_fma_f32 v101, v13, v6, v101
	v_fma_f32 v102, v14, v6, v102
	v_fma_f32 v103, v15, v6, v103
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[88:95], a[48:55], 0
	ds_read_b128 a[16:19], v2 offset:1024
	ds_read_b128 a[20:23], v2 offset:1088
	s_add_u32 s52, 0x180, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s57, s57, 0
	s_cselect_b32 s6, s6, 0
	s_nop 5
	v_fma_f32 v88, v8, v4, v88
	v_fma_f32 v89, v9, v4, v89
	v_fma_f32 v90, v10, v4, v90
	v_fma_f32 v91, v11, v4, v91
	v_mul_f32_dpp v6, v23, v39 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[80:87], a[56:63], 0
	buffer_load_dwordx4 a[76:79], v43, s[24:27], 0 offen offset:1024
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	s_nop 5
	v_fma_f32 v104, v12, v4, v104
	v_fma_f32 v105, v13, v4, v105
	v_fma_f32 v106, v14, v4, v106
	v_fma_f32 v107, v15, v4, v107
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[88:95], a[56:63], 0
	ds_read_b128 a[24:27], v2 offset:1536
	ds_read_b128 a[28:31], v2 offset:1600
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_nop 5
	v_fma_f32 v92, v8, v6, v92
	v_fma_f32 v93, v9, v6, v93
	v_fma_f32 v94, v10, v6, v94
	v_fma_f32 v95, v11, v6, v95
	s_nop 5
	v_fma_f32 v108, v12, v6, v108
	v_fma_f32 v109, v13, v6, v109
	v_fma_f32 v110, v14, v6, v110
	v_fma_f32 v111, v15, v6, v111
	s_addk_i32 s70, 0x80
	s_cmp_lt_i32 s70, s71
	s_cbranch_scc0 label_0C06
	s_branch label_09C9

000000000000590c <label_0C06>:
	s_cmp_eq_u32 s74, 0
	s_cbranch_scc0 label_0E30
	v_cvt_pk_bf16_f32 v48, v48, v49
	v_cvt_pk_bf16_f32 v49, v50, v51
	v_cvt_pk_bf16_f32 v50, v52, v53
	v_cvt_pk_bf16_f32 v51, v54, v55
	v_cvt_pk_bf16_f32 v52, v56, v57
	v_cvt_pk_bf16_f32 v53, v58, v59
	v_cvt_pk_bf16_f32 v54, v60, v61
	v_cvt_pk_bf16_f32 v55, v62, v63
	v_cvt_pk_bf16_f32 v56, v64, v65
	v_cvt_pk_bf16_f32 v57, v66, v67
	v_cvt_pk_bf16_f32 v58, v68, v69
	v_cvt_pk_bf16_f32 v59, v70, v71
	v_cvt_pk_bf16_f32 v60, v72, v73
	v_cvt_pk_bf16_f32 v61, v74, v75
	v_cvt_pk_bf16_f32 v62, v76, v77
	v_cvt_pk_bf16_f32 v63, v78, v79
	ds_write_b64 v16, v[48:49]
	ds_write_b64 v16, v[50:51] offset:4352
	ds_write_b64 v16, v[52:53] offset:8704
	ds_write_b64 v16, v[54:55] offset:13056
	ds_write_b64 v16, v[56:57] offset:2176
	ds_write_b64 v16, v[58:59] offset:6528
	ds_write_b64 v16, v[60:61] offset:10880
	ds_write_b64 v16, v[62:63] offset:15232
	v_cvt_pk_bf16_f32 v80, v80, v81
	v_cvt_pk_bf16_f32 v81, v82, v83
	v_cvt_pk_bf16_f32 v82, v84, v85
	v_cvt_pk_bf16_f32 v83, v86, v87
	v_cvt_pk_bf16_f32 v84, v88, v89
	v_cvt_pk_bf16_f32 v85, v90, v91
	v_cvt_pk_bf16_f32 v86, v92, v93
	v_cvt_pk_bf16_f32 v87, v94, v95
	v_cvt_pk_bf16_f32 v88, v96, v97
	v_cvt_pk_bf16_f32 v89, v98, v99
	v_cvt_pk_bf16_f32 v90, v100, v101
	v_cvt_pk_bf16_f32 v91, v102, v103
	v_cvt_pk_bf16_f32 v92, v104, v105
	v_cvt_pk_bf16_f32 v93, v106, v107
	v_cvt_pk_bf16_f32 v94, v108, v109
	v_cvt_pk_bf16_f32 v95, v110, v111
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
	v_add_u32_e32 v64, v6, v7
	v_readlane_b32 s72, v3, 2
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 3
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v65, v6, v7
	v_readlane_b32 s72, v3, 4
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 5
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v66, v6, v7
	v_readlane_b32 s72, v3, 6
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 7
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v67, v6, v7
	v_readlane_b32 s72, v3, 8
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 9
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v68, v6, v7
	v_readlane_b32 s72, v3, 10
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 11
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v69, v6, v7
	v_readlane_b32 s72, v3, 12
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 13
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v70, v6, v7
	v_readlane_b32 s72, v3, 14
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 15
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v71, v6, v7
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 2, 4
	v_mul_lo_u32 v4, v4, s53
	v_and_b32_e64 v5, v0, 1
	v_add_u32_e32 v4, v4, v5
	v_lshlrev_b32_e32 v4, 2, v4
	v_add_u32_e32 v64, v64, v4
	v_add_u32_e32 v65, v65, v4
	v_add_u32_e32 v66, v66, v4
	v_add_u32_e32 v67, v67, v4
	v_add_u32_e32 v68, v68, v4
	v_add_u32_e32 v69, v69, v4
	v_add_u32_e32 v70, v70, v4
	v_add_u32_e32 v71, v71, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v48, v17
	ds_read_b32 v49, v17 offset:64
	ds_read_b32 v50, v17 offset:2176
	ds_read_b32 v51, v17 offset:2240
	ds_read_b32 v52, v17 offset:4352
	ds_read_b32 v53, v17 offset:4416
	ds_read_b32 v54, v17 offset:6528
	ds_read_b32 v55, v17 offset:6592
	ds_read_b32 v56, v17 offset:8704
	ds_read_b32 v57, v17 offset:8768
	ds_read_b32 v58, v17 offset:10880
	ds_read_b32 v59, v17 offset:10944
	ds_read_b32 v60, v17 offset:13056
	ds_read_b32 v61, v17 offset:13120
	ds_read_b32 v62, v17 offset:15232
	ds_read_b32 v63, v17 offset:15296
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_or_b32 s9, s9, 0x40000
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v64
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v48, v6, s[8:11], 0 offen
	buffer_store_dword v50, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v65
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v49, v6, s[8:11], 0 offen
	buffer_store_dword v51, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v66
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v52, v6, s[8:11], 0 offen
	buffer_store_dword v54, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v67
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v53, v6, s[8:11], 0 offen
	buffer_store_dword v55, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v68
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v56, v6, s[8:11], 0 offen
	buffer_store_dword v58, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v69
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v57, v6, s[8:11], 0 offen
	buffer_store_dword v59, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v70
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v60, v6, s[8:11], 0 offen
	buffer_store_dword v62, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v71
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v61, v6, s[8:11], 0 offen
	buffer_store_dword v63, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_write_b64 v16, v[80:81]
	ds_write_b64 v16, v[82:83] offset:4352
	ds_write_b64 v16, v[84:85] offset:8704
	ds_write_b64 v16, v[86:87] offset:13056
	ds_write_b64 v16, v[88:89] offset:2176
	ds_write_b64 v16, v[90:91] offset:6528
	ds_write_b64 v16, v[92:93] offset:10880
	ds_write_b64 v16, v[94:95] offset:15232
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v80, v17
	ds_read_b32 v81, v17 offset:64
	ds_read_b32 v82, v17 offset:2176
	ds_read_b32 v83, v17 offset:2240
	ds_read_b32 v84, v17 offset:4352
	ds_read_b32 v85, v17 offset:4416
	ds_read_b32 v86, v17 offset:6528
	ds_read_b32 v87, v17 offset:6592
	ds_read_b32 v88, v17 offset:8704
	ds_read_b32 v89, v17 offset:8768
	ds_read_b32 v90, v17 offset:10880
	ds_read_b32 v91, v17 offset:10944
	ds_read_b32 v92, v17 offset:13056
	ds_read_b32 v93, v17 offset:13120
	ds_read_b32 v94, v17 offset:15232
	ds_read_b32 v95, v17 offset:15296
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_add_u32 s8, 0x100, s8
	s_addc_u32 s9, 0, s9
	s_or_b32 s9, s9, 0x40000
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v64
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v80, v6, s[8:11], 0 offen
	buffer_store_dword v82, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v65
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v81, v6, s[8:11], 0 offen
	buffer_store_dword v83, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v66
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v84, v6, s[8:11], 0 offen
	buffer_store_dword v86, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v67
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v85, v6, s[8:11], 0 offen
	buffer_store_dword v87, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v68
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v88, v6, s[8:11], 0 offen
	buffer_store_dword v90, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v69
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v89, v6, s[8:11], 0 offen
	buffer_store_dword v91, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v70
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v92, v6, s[8:11], 0 offen
	buffer_store_dword v94, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v71
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v93, v6, s[8:11], 0 offen
	buffer_store_dword v95, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	s_branch label_117A

00000000000061b4 <label_0E30>:
	ds_write_b64 v16, v[48:49]
	ds_write_b64 v16, v[52:53] offset:4352
	ds_write_b64 v16, v[56:57] offset:8704
	ds_write_b64 v16, v[60:61] offset:13056
	ds_write_b64 v16, v[64:65] offset:2176
	ds_write_b64 v16, v[68:69] offset:6528
	ds_write_b64 v16, v[72:73] offset:10880
	ds_write_b64 v16, v[76:77] offset:15232
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
	v_add_u32_e32 v64, v6, v7
	v_readlane_b32 s72, v3, 2
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 3
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v65, v6, v7
	v_readlane_b32 s72, v3, 4
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 5
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v66, v6, v7
	v_readlane_b32 s72, v3, 6
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 7
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v67, v6, v7
	v_readlane_b32 s72, v3, 8
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 9
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v68, v6, v7
	v_readlane_b32 s72, v3, 10
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 11
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v69, v6, v7
	v_readlane_b32 s72, v3, 12
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 13
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v70, v6, v7
	v_readlane_b32 s72, v3, 14
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 15
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v71, v6, v7
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 2, 4
	v_mul_lo_u32 v4, v4, s53
	v_and_b32_e64 v5, v0, 1
	v_add_u32_e32 v4, v4, v5
	v_lshlrev_b32_e32 v4, 2, v4
	v_add_u32_e32 v64, v64, v4
	v_add_u32_e32 v65, v65, v4
	v_add_u32_e32 v66, v66, v4
	v_add_u32_e32 v67, v67, v4
	v_add_u32_e32 v68, v68, v4
	v_add_u32_e32 v69, v69, v4
	v_add_u32_e32 v70, v70, v4
	v_add_u32_e32 v71, v71, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v48, v17
	ds_read_b32 v49, v17 offset:64
	ds_read_b32 v52, v17 offset:2176
	ds_read_b32 v53, v17 offset:2240
	ds_read_b32 v56, v17 offset:4352
	ds_read_b32 v57, v17 offset:4416
	ds_read_b32 v60, v17 offset:6528
	ds_read_b32 v61, v17 offset:6592
	ds_read_b32 v64, v17 offset:8704
	ds_read_b32 v65, v17 offset:8768
	ds_read_b32 v68, v17 offset:10880
	ds_read_b32 v69, v17 offset:10944
	ds_read_b32 v72, v17 offset:13056
	ds_read_b32 v73, v17 offset:13120
	ds_read_b32 v76, v17 offset:15232
	ds_read_b32 v77, v17 offset:15296
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v64
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v48, s[8:9]
	global_atomic_add_f32 v6, v52, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v65
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v49, s[8:9]
	global_atomic_add_f32 v6, v53, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v66
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v56, s[8:9]
	global_atomic_add_f32 v6, v60, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v67
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v57, s[8:9]
	global_atomic_add_f32 v6, v61, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v68
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v64, s[8:9]
	global_atomic_add_f32 v6, v68, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v69
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v65, s[8:9]
	global_atomic_add_f32 v6, v69, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v70
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v72, s[8:9]
	global_atomic_add_f32 v6, v76, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v71
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v73, s[8:9]
	global_atomic_add_f32 v6, v77, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[50:51]
	ds_write_b64 v16, v[54:55] offset:4352
	ds_write_b64 v16, v[58:59] offset:8704
	ds_write_b64 v16, v[62:63] offset:13056
	ds_write_b64 v16, v[66:67] offset:2176
	ds_write_b64 v16, v[70:71] offset:6528
	ds_write_b64 v16, v[74:75] offset:10880
	ds_write_b64 v16, v[78:79] offset:15232
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v50, v17
	ds_read_b32 v51, v17 offset:64
	ds_read_b32 v54, v17 offset:2176
	ds_read_b32 v55, v17 offset:2240
	ds_read_b32 v58, v17 offset:4352
	ds_read_b32 v59, v17 offset:4416
	ds_read_b32 v62, v17 offset:6528
	ds_read_b32 v63, v17 offset:6592
	ds_read_b32 v66, v17 offset:8704
	ds_read_b32 v67, v17 offset:8768
	ds_read_b32 v70, v17 offset:10880
	ds_read_b32 v71, v17 offset:10944
	ds_read_b32 v74, v17 offset:13056
	ds_read_b32 v75, v17 offset:13120
	ds_read_b32 v78, v17 offset:15232
	ds_read_b32 v79, v17 offset:15296
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v64
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v50, s[8:9] offset:8
	global_atomic_add_f32 v6, v54, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v65
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v51, s[8:9] offset:8
	global_atomic_add_f32 v6, v55, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v66
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v58, s[8:9] offset:8
	global_atomic_add_f32 v6, v62, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v67
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v59, s[8:9] offset:8
	global_atomic_add_f32 v6, v63, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v68
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v66, s[8:9] offset:8
	global_atomic_add_f32 v6, v70, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v69
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v67, s[8:9] offset:8
	global_atomic_add_f32 v6, v71, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v70
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v74, s[8:9] offset:8
	global_atomic_add_f32 v6, v78, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v71
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v75, s[8:9] offset:8
	global_atomic_add_f32 v6, v79, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[80:81]
	ds_write_b64 v16, v[84:85] offset:4352
	ds_write_b64 v16, v[88:89] offset:8704
	ds_write_b64 v16, v[92:93] offset:13056
	ds_write_b64 v16, v[96:97] offset:2176
	ds_write_b64 v16, v[100:101] offset:6528
	ds_write_b64 v16, v[104:105] offset:10880
	ds_write_b64 v16, v[108:109] offset:15232
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v80, v17
	ds_read_b32 v81, v17 offset:64
	ds_read_b32 v84, v17 offset:2176
	ds_read_b32 v85, v17 offset:2240
	ds_read_b32 v88, v17 offset:4352
	ds_read_b32 v89, v17 offset:4416
	ds_read_b32 v92, v17 offset:6528
	ds_read_b32 v93, v17 offset:6592
	ds_read_b32 v96, v17 offset:8704
	ds_read_b32 v97, v17 offset:8768
	ds_read_b32 v100, v17 offset:10880
	ds_read_b32 v101, v17 offset:10944
	ds_read_b32 v104, v17 offset:13056
	ds_read_b32 v105, v17 offset:13120
	ds_read_b32 v108, v17 offset:15232
	ds_read_b32 v109, v17 offset:15296
	s_mul_i32 s52, s61, 4
	s_add_u32 s8, s52, s8
	s_addc_u32 s9, 0, s9
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v64
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v80, s[8:9]
	global_atomic_add_f32 v6, v84, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v65
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v81, s[8:9]
	global_atomic_add_f32 v6, v85, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v66
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v88, s[8:9]
	global_atomic_add_f32 v6, v92, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v67
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v89, s[8:9]
	global_atomic_add_f32 v6, v93, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v68
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v96, s[8:9]
	global_atomic_add_f32 v6, v100, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v69
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v97, s[8:9]
	global_atomic_add_f32 v6, v101, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v70
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v104, s[8:9]
	global_atomic_add_f32 v6, v108, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v71
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v105, s[8:9]
	global_atomic_add_f32 v6, v109, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[82:83]
	ds_write_b64 v16, v[86:87] offset:4352
	ds_write_b64 v16, v[90:91] offset:8704
	ds_write_b64 v16, v[94:95] offset:13056
	ds_write_b64 v16, v[98:99] offset:2176
	ds_write_b64 v16, v[102:103] offset:6528
	ds_write_b64 v16, v[106:107] offset:10880
	ds_write_b64 v16, v[110:111] offset:15232
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v82, v17
	ds_read_b32 v83, v17 offset:64
	ds_read_b32 v86, v17 offset:2176
	ds_read_b32 v87, v17 offset:2240
	ds_read_b32 v90, v17 offset:4352
	ds_read_b32 v91, v17 offset:4416
	ds_read_b32 v94, v17 offset:6528
	ds_read_b32 v95, v17 offset:6592
	ds_read_b32 v98, v17 offset:8704
	ds_read_b32 v99, v17 offset:8768
	ds_read_b32 v102, v17 offset:10880
	ds_read_b32 v103, v17 offset:10944
	ds_read_b32 v106, v17 offset:13056
	ds_read_b32 v107, v17 offset:13120
	ds_read_b32 v110, v17 offset:15232
	ds_read_b32 v111, v17 offset:15296
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v64
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v82, s[8:9] offset:8
	global_atomic_add_f32 v6, v86, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v65
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v83, s[8:9] offset:8
	global_atomic_add_f32 v6, v87, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v66
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v90, s[8:9] offset:8
	global_atomic_add_f32 v6, v94, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v67
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v91, s[8:9] offset:8
	global_atomic_add_f32 v6, v95, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v68
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v98, s[8:9] offset:8
	global_atomic_add_f32 v6, v102, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v69
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v99, s[8:9] offset:8
	global_atomic_add_f32 v6, v103, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v70
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v106, s[8:9] offset:8
	global_atomic_add_f32 v6, v110, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v71
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v107, s[8:9] offset:8
	global_atomic_add_f32 v6, v111, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	s_branch label_117A

0000000000006edc <label_117A>:
	s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
	s_endpgm
