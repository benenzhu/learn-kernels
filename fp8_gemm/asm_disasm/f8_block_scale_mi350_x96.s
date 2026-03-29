
/usr/local/lib/python3.12/dist-packages/aiter_meta/hsa/gfx950/f8_block_scale_mi350_x96.co:	file format elf64-amdgpu

Disassembly of section .text:

0000000000002900 <f8_block_scale_mi350_x96>:
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
	v_accvgpr_write_b32 a127, 0
	v_mov_b32_e32 v151, 0
	s_waitcnt lgkmcnt(0)
	s_mul_i32 s52, s3, 0x60
	s_cmp_lt_i32 s52, s46
	s_cbranch_scc0 label_18F7
	s_mov_b32 s70, 0
	s_lshr_b32 s71, s60, s74
	s_mul_i32 s52, s3, 0x60
	v_and_b32_e32 v4, 15, v0
	v_add_u32_e64 v24, v4, s52
	v_add_u32_e32 v4, 16, v4
	v_add_u32_e64 v25, v4, s52
	v_add_u32_e32 v4, 16, v4
	v_add_u32_e64 v26, v4, s52
	v_add_u32_e32 v4, 16, v4
	v_add_u32_e64 v27, v4, s52
	v_add_u32_e32 v4, 16, v4
	v_add_u32_e64 v28, v4, s52
	v_add_u32_e32 v4, 16, v4
	v_add_u32_e64 v29, v4, s52
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
	v_mov_b32_e32 v53, v7
	v_mov_b32_e32 v56, 0
	v_mov_b32_e32 v104, 0
	v_mov_b32_e32 v57, 0
	v_mov_b32_e32 v105, 0
	v_mov_b32_e32 v58, 0
	v_mov_b32_e32 v106, 0
	v_mov_b32_e32 v59, 0
	v_mov_b32_e32 v107, 0
	v_mov_b32_e32 v60, 0
	v_mov_b32_e32 v108, 0
	v_mov_b32_e32 v61, 0
	v_mov_b32_e32 v109, 0
	v_mov_b32_e32 v62, 0
	v_mov_b32_e32 v110, 0
	v_mov_b32_e32 v63, 0
	v_mov_b32_e32 v111, 0
	v_mov_b32_e32 v64, 0
	v_mov_b32_e32 v112, 0
	v_mov_b32_e32 v65, 0
	v_mov_b32_e32 v113, 0
	v_mov_b32_e32 v66, 0
	v_mov_b32_e32 v114, 0
	v_mov_b32_e32 v67, 0
	v_mov_b32_e32 v115, 0
	v_mov_b32_e32 v68, 0
	v_mov_b32_e32 v116, 0
	v_mov_b32_e32 v69, 0
	v_mov_b32_e32 v117, 0
	v_mov_b32_e32 v70, 0
	v_mov_b32_e32 v118, 0
	v_mov_b32_e32 v71, 0
	v_mov_b32_e32 v119, 0
	v_mov_b32_e32 v72, 0
	v_mov_b32_e32 v120, 0
	v_mov_b32_e32 v73, 0
	v_mov_b32_e32 v121, 0
	v_mov_b32_e32 v74, 0
	v_mov_b32_e32 v122, 0
	v_mov_b32_e32 v75, 0
	v_mov_b32_e32 v123, 0
	v_mov_b32_e32 v76, 0
	v_mov_b32_e32 v124, 0
	v_mov_b32_e32 v77, 0
	v_mov_b32_e32 v125, 0
	v_mov_b32_e32 v78, 0
	v_mov_b32_e32 v126, 0
	v_mov_b32_e32 v79, 0
	v_mov_b32_e32 v127, 0
	v_mov_b32_e32 v80, 0
	v_mov_b32_e32 v128, 0
	v_mov_b32_e32 v81, 0
	v_mov_b32_e32 v129, 0
	v_mov_b32_e32 v82, 0
	v_mov_b32_e32 v130, 0
	v_mov_b32_e32 v83, 0
	v_mov_b32_e32 v131, 0
	v_mov_b32_e32 v84, 0
	v_mov_b32_e32 v132, 0
	v_mov_b32_e32 v85, 0
	v_mov_b32_e32 v133, 0
	v_mov_b32_e32 v86, 0
	v_mov_b32_e32 v134, 0
	v_mov_b32_e32 v87, 0
	v_mov_b32_e32 v135, 0
	v_mov_b32_e32 v88, 0
	v_mov_b32_e32 v136, 0
	v_mov_b32_e32 v89, 0
	v_mov_b32_e32 v137, 0
	v_mov_b32_e32 v90, 0
	v_mov_b32_e32 v138, 0
	v_mov_b32_e32 v91, 0
	v_mov_b32_e32 v139, 0
	v_mov_b32_e32 v92, 0
	v_mov_b32_e32 v140, 0
	v_mov_b32_e32 v93, 0
	v_mov_b32_e32 v141, 0
	v_mov_b32_e32 v94, 0
	v_mov_b32_e32 v142, 0
	v_mov_b32_e32 v95, 0
	v_mov_b32_e32 v143, 0
	v_mov_b32_e32 v96, 0
	v_mov_b32_e32 v144, 0
	v_mov_b32_e32 v97, 0
	v_mov_b32_e32 v145, 0
	v_mov_b32_e32 v98, 0
	v_mov_b32_e32 v146, 0
	v_mov_b32_e32 v99, 0
	v_mov_b32_e32 v147, 0
	v_mov_b32_e32 v100, 0
	v_mov_b32_e32 v148, 0
	v_mov_b32_e32 v101, 0
	v_mov_b32_e32 v149, 0
	v_mov_b32_e32 v102, 0
	v_mov_b32_e32 v150, 0
	v_mov_b32_e32 v103, 0
	v_mov_b32_e32 v151, 0
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
	s_mul_i32 s52, s7, 0xc20
	s_add_u32 s46, 0, s52
	s_add_u32 s47, 0x3080, s46
	v_and_b32_e32 v4, 15, v0
	v_lshrrev_b32_e32 v5, 3, v4
	v_mul_i32_i24_e32 v5, 2, v5
	v_and_b32_e32 v4, 3, v0
	v_lshrrev_b32_e32 v6, 1, v4
	v_add_u32_e32 v4, v5, v6
	v_mul_i32_i24_e32 v2, 0xc20, v4
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
	v_lshlrev_b32_e32 v51, 4, v0
	v_add_u32_e32 v51, s52, v51
	s_mul_i32 s52, 64, s65
	v_add_u32_e32 v52, s52, v51
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
	v_readlane_b32 s72, v53, 0
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 0
	s_mov_b32 s17, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v48, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 1
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v48, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 2
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v48, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 3
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v48, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 4
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 0
	s_mov_b32 s16, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v48, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 5
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v48, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 6
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v48, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 7
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v48, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 8
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 0
	s_mov_b32 s17, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v49, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 9
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v49, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 10
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v49, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 11
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v49, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 12
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 0
	s_mov_b32 s16, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v49, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 13
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v49, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 14
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v49, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 15
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v49, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 16
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 0
	s_mov_b32 s17, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v50, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 17
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v50, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 18
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v50, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 19
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v50, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 20
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 0
	s_mov_b32 s16, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v50, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 21
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v50, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 22
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v50, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v53, 23
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v50, s52
	s_mov_b64 exec, s[54:55]
	v_and_b32_e64 v4, v0, 7
	v_lshlrev_b32_e32 v4, 4, v4
	v_add_u32_e32 v48, v48, v4
	v_add_u32_e32 v49, v49, v4
	v_add_u32_e32 v50, v50, v4
	v_lshlrev_b32_e32 v24, 2, v24
	v_lshlrev_b32_e32 v25, 2, v25
	v_lshlrev_b32_e32 v26, 2, v26
	v_lshlrev_b32_e32 v27, 2, v27
	v_lshlrev_b32_e32 v28, 2, v28
	v_lshlrev_b32_e32 v29, 2, v29
	s_lshl_b32 s6, s62, 2
	buffer_load_dwordx4 v48, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s46
	buffer_load_dwordx4 v49, s[20:23], 0 offen lds
	s_add_u32 m0, 0x800, s46
	buffer_load_dwordx4 v50, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s47
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	buffer_load_dword v30, v24, s[28:31], 0 offen
	buffer_load_dword v31, v25, s[28:31], 0 offen
	buffer_load_dword v32, v26, s[28:31], 0 offen
	buffer_load_dword v33, v27, s[28:31], 0 offen
	buffer_load_dword v34, v28, s[28:31], 0 offen
	buffer_load_dword v35, v29, s[28:31], 0 offen
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	buffer_load_dwordx4 v48, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s47
	buffer_load_dwordx4 v49, s[20:23], 0 offen lds
	s_add_u32 m0, 0x800, s47
	buffer_load_dwordx4 v50, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s46
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	buffer_load_dword v36, v24, s[28:31], 0 offen
	buffer_load_dword v37, v25, s[28:31], 0 offen
	buffer_load_dword v38, v26, s[28:31], 0 offen
	buffer_load_dword v39, v27, s[28:31], 0 offen
	buffer_load_dword v40, v28, s[28:31], 0 offen
	buffer_load_dword v41, v29, s[28:31], 0 offen
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	buffer_load_dword v20, v18, s[32:35], 0 offen
	buffer_load_dwordx4 a[96:99], v51, s[24:27], 0 offen
	buffer_load_dwordx4 a[100:103], v51, s[24:27], 0 offen offset:1024
	buffer_load_dwordx4 a[104:107], v52, s[24:27], 0 offen
	buffer_load_dwordx4 a[108:111], v52, s[24:27], 0 offen offset:1024
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_waitcnt vmcnt(20)
	s_barrier
	ds_read_b128 a[0:3], v2
	ds_read_b128 a[4:7], v2 offset:64
	ds_read_b128 a[8:11], v2 offset:512
	ds_read_b128 a[12:15], v2 offset:576
	ds_read_b128 a[16:19], v2 offset:1024
	ds_read_b128 a[20:23], v2 offset:1088
	ds_read_b128 a[24:27], v2 offset:1536
	ds_read_b128 a[28:31], v2 offset:1600
	ds_read_b128 a[32:35], v2 offset:2048
	ds_read_b128 a[36:39], v2 offset:2112
	ds_read_b128 a[40:43], v2 offset:2560
	ds_read_b128 a[44:47], v2 offset:2624
	s_cmp_lt_i32 s7, 2
	s_cbranch_scc0 label_0DCA

0000000000003368 <label_029A>:
	s_waitcnt vmcnt(2) lgkmcnt(0)
	s_barrier
	v_mov_b32_e32 v42, v30
	v_mov_b32_e32 v43, v31
	v_mov_b32_e32 v44, v32
	v_mov_b32_e32 v45, v33
	v_mov_b32_e32 v46, v34
	v_mov_b32_e32 v47, v35
	v_mul_f32_dpp v4, v20, v42 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[96:103], a[0:7], 0
	buffer_load_dword v23, v19, s[32:35], 0 offen
	v_mul_f32_dpp v6, v20, v43 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[96:103], a[8:15], 0
	buffer_load_dwordx4 a[112:115], v51, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v56, v8, v4, v56
	v_fma_f32 v57, v9, v4, v57
	v_fma_f32 v58, v10, v4, v58
	v_fma_f32 v59, v11, v4, v59
	v_mul_f32_dpp v4, v20, v44 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[96:103], a[16:23], 0
	s_nop 5
	v_fma_f32 v60, v12, v6, v60
	v_fma_f32 v61, v13, v6, v61
	v_fma_f32 v62, v14, v6, v62
	v_fma_f32 v63, v15, v6, v63
	v_mul_f32_dpp v6, v20, v45 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[96:103], a[24:31], 0
	buffer_load_dwordx4 a[116:119], v51, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v64, v8, v4, v64
	v_fma_f32 v65, v9, v4, v65
	v_fma_f32 v66, v10, v4, v66
	v_fma_f32 v67, v11, v4, v67
	v_mul_f32_dpp v4, v20, v46 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[96:103], a[32:39], 0
	s_nop 5
	v_fma_f32 v68, v12, v6, v68
	v_fma_f32 v69, v13, v6, v69
	v_fma_f32 v70, v14, v6, v70
	v_fma_f32 v71, v15, v6, v71
	v_mul_f32_dpp v6, v20, v47 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[96:103], a[40:47], 0
	buffer_load_dwordx4 a[120:123], v52, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v72, v8, v4, v72
	v_fma_f32 v73, v9, v4, v73
	v_fma_f32 v74, v10, v4, v74
	v_fma_f32 v75, v11, v4, v75
	s_waitcnt vmcnt(4)
	v_mul_f32_dpp v4, v20, v42 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[104:111], a[0:7], 0
	s_nop 5
	v_fma_f32 v76, v12, v6, v76
	v_fma_f32 v77, v13, v6, v77
	v_fma_f32 v78, v14, v6, v78
	v_fma_f32 v79, v15, v6, v79
	v_mul_f32_dpp v6, v20, v43 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[104:111], a[8:15], 0
	buffer_load_dwordx4 a[124:127], v52, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v80, v8, v4, v80
	v_fma_f32 v81, v9, v4, v81
	v_fma_f32 v82, v10, v4, v82
	v_fma_f32 v83, v11, v4, v83
	v_mul_f32_dpp v4, v20, v44 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[104:111], a[16:23], 0
	s_nop 5
	v_fma_f32 v84, v12, v6, v84
	v_fma_f32 v85, v13, v6, v85
	v_fma_f32 v86, v14, v6, v86
	v_fma_f32 v87, v15, v6, v87
	v_mul_f32_dpp v6, v20, v45 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[104:111], a[24:31], 0
	buffer_load_dwordx4 v48, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s46
	s_nop 5
	v_fma_f32 v88, v8, v4, v88
	v_fma_f32 v89, v9, v4, v89
	v_fma_f32 v90, v10, v4, v90
	v_fma_f32 v91, v11, v4, v91
	v_mul_f32_dpp v4, v20, v46 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[104:111], a[32:39], 0
	s_add_u32 s52, 0x80, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s73, s73, 0
	s_cselect_b32 s4, s4, 0
	s_nop 5
	v_fma_f32 v92, v12, v6, v92
	v_fma_f32 v93, v13, v6, v93
	v_fma_f32 v94, v14, v6, v94
	v_fma_f32 v95, v15, v6, v95
	v_mul_f32_dpp v6, v20, v47 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[104:111], a[40:47], 0
	buffer_load_dwordx4 v49, s[20:23], 0 offen lds
	s_add_u32 m0, 0x800, s46
	s_add_u32 s32, s4, s32
	s_addc_u32 s33, 0, s33
	s_nop 5
	v_fma_f32 v96, v8, v4, v96
	v_fma_f32 v97, v9, v4, v97
	v_fma_f32 v98, v10, v4, v98
	v_fma_f32 v99, v11, v4, v99
	s_nop 5
	v_fma_f32 v100, v12, v6, v100
	v_fma_f32 v101, v13, v6, v101
	v_fma_f32 v102, v14, v6, v102
	v_fma_f32 v103, v15, v6, v103
	buffer_load_dwordx4 v50, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s47
	buffer_load_dword v30, v24, s[28:31], 0 offen
	buffer_load_dword v31, v25, s[28:31], 0 offen
	buffer_load_dword v32, v26, s[28:31], 0 offen
	buffer_load_dword v33, v27, s[28:31], 0 offen
	buffer_load_dword v34, v28, s[28:31], 0 offen
	buffer_load_dword v35, v29, s[28:31], 0 offen
	s_waitcnt vmcnt(9)
	v_mul_f32_dpp v4, v23, v42 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[0:7], 0
	buffer_load_dword v20, v18, s[32:35], 0 offen
	ds_read_b128 a[48:51], v2 offset:12416
	ds_read_b128 a[52:55], v2 offset:12480
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[0:7], 0
	buffer_load_dwordx4 a[96:99], v51, s[24:27], 0 offen
	s_nop 5
	v_fma_f32 v104, v8, v4, v104
	v_fma_f32 v105, v9, v4, v105
	v_fma_f32 v106, v10, v4, v106
	v_fma_f32 v107, v11, v4, v107
	v_mul_f32_dpp v6, v23, v43 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[8:15], 0
	ds_read_b128 a[56:59], v2 offset:12928
	ds_read_b128 a[60:63], v2 offset:12992
	s_nop 5
	v_fma_f32 v128, v12, v4, v128
	v_fma_f32 v129, v13, v4, v129
	v_fma_f32 v130, v14, v4, v130
	v_fma_f32 v131, v15, v4, v131
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[8:15], 0
	buffer_load_dwordx4 a[100:103], v51, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v108, v8, v6, v108
	v_fma_f32 v109, v9, v6, v109
	v_fma_f32 v110, v10, v6, v110
	v_fma_f32 v111, v11, v6, v111
	v_mul_f32_dpp v4, v23, v44 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[16:23], 0
	ds_read_b128 a[64:67], v2 offset:13440
	ds_read_b128 a[68:71], v2 offset:13504
	s_nop 5
	v_fma_f32 v132, v12, v6, v132
	v_fma_f32 v133, v13, v6, v133
	v_fma_f32 v134, v14, v6, v134
	v_fma_f32 v135, v15, v6, v135
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[16:23], 0
	buffer_load_dwordx4 a[104:107], v52, s[24:27], 0 offen
	s_nop 5
	v_fma_f32 v112, v8, v4, v112
	v_fma_f32 v113, v9, v4, v113
	v_fma_f32 v114, v10, v4, v114
	v_fma_f32 v115, v11, v4, v115
	v_mul_f32_dpp v6, v23, v45 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[24:31], 0
	ds_read_b128 a[72:75], v2 offset:13952
	ds_read_b128 a[76:79], v2 offset:14016
	s_nop 5
	v_fma_f32 v136, v12, v4, v136
	v_fma_f32 v137, v13, v4, v137
	v_fma_f32 v138, v14, v4, v138
	v_fma_f32 v139, v15, v4, v139
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[24:31], 0
	buffer_load_dwordx4 a[108:111], v52, s[24:27], 0 offen offset:1024
	s_add_u32 s52, 0x100, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s58, s58, 0
	s_nop 5
	v_fma_f32 v116, v8, v6, v116
	v_fma_f32 v117, v9, v6, v117
	v_fma_f32 v118, v10, v6, v118
	v_fma_f32 v119, v11, v6, v119
	v_mul_f32_dpp v4, v23, v46 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[32:39], 0
	ds_read_b128 a[80:83], v2 offset:14464
	ds_read_b128 a[84:87], v2 offset:14528
	s_add_u32 s76, s73, s24
	s_addc_u32 s77, 0, s77
	s_nop 5
	v_fma_f32 v140, v12, v6, v140
	v_fma_f32 v141, v13, v6, v141
	v_fma_f32 v142, v14, v6, v142
	v_fma_f32 v143, v15, v6, v143
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[32:39], 0
	s_add_u32 s52, 0x180, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s57, s57, 0
	s_cselect_b32 s6, s6, 0
	s_nop 5
	v_fma_f32 v120, v8, v4, v120
	v_fma_f32 v121, v9, v4, v121
	v_fma_f32 v122, v10, v4, v122
	v_fma_f32 v123, v11, v4, v123
	v_mul_f32_dpp v6, v23, v47 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[40:47], 0
	ds_read_b128 a[88:91], v2 offset:14976
	ds_read_b128 a[92:95], v2 offset:15040
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	s_nop 5
	v_fma_f32 v144, v12, v4, v144
	v_fma_f32 v145, v13, v4, v145
	v_fma_f32 v146, v14, v4, v146
	v_fma_f32 v147, v15, v4, v147
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[40:47], 0
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_nop 5
	v_fma_f32 v124, v8, v6, v124
	v_fma_f32 v125, v9, v6, v125
	v_fma_f32 v126, v10, v6, v126
	v_fma_f32 v127, v11, v6, v127
	s_nop 5
	v_fma_f32 v148, v12, v6, v148
	v_fma_f32 v149, v13, v6, v149
	v_fma_f32 v150, v14, v6, v150
	v_fma_f32 v151, v15, v6, v151
	s_addk_i32 s70, 0x80
	s_cmp_lt_i32 s70, s71
	s_cbranch_scc0 label_05C3
	s_waitcnt vmcnt(2) lgkmcnt(0)
	s_barrier
	v_mov_b32_e32 v42, v36
	v_mov_b32_e32 v43, v37
	v_mov_b32_e32 v44, v38
	v_mov_b32_e32 v45, v39
	v_mov_b32_e32 v46, v40
	v_mov_b32_e32 v47, v41
	v_mul_f32_dpp v4, v20, v42 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[96:103], a[48:55], 0
	buffer_load_dword v23, v19, s[32:35], 0 offen
	v_mul_f32_dpp v6, v20, v43 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[96:103], a[56:63], 0
	buffer_load_dwordx4 a[112:115], v51, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v56, v8, v4, v56
	v_fma_f32 v57, v9, v4, v57
	v_fma_f32 v58, v10, v4, v58
	v_fma_f32 v59, v11, v4, v59
	v_mul_f32_dpp v4, v20, v44 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[96:103], a[64:71], 0
	s_nop 5
	v_fma_f32 v60, v12, v6, v60
	v_fma_f32 v61, v13, v6, v61
	v_fma_f32 v62, v14, v6, v62
	v_fma_f32 v63, v15, v6, v63
	v_mul_f32_dpp v6, v20, v45 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[96:103], a[72:79], 0
	buffer_load_dwordx4 a[116:119], v51, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v64, v8, v4, v64
	v_fma_f32 v65, v9, v4, v65
	v_fma_f32 v66, v10, v4, v66
	v_fma_f32 v67, v11, v4, v67
	v_mul_f32_dpp v4, v20, v46 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[96:103], a[80:87], 0
	s_nop 5
	v_fma_f32 v68, v12, v6, v68
	v_fma_f32 v69, v13, v6, v69
	v_fma_f32 v70, v14, v6, v70
	v_fma_f32 v71, v15, v6, v71
	v_mul_f32_dpp v6, v20, v47 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[96:103], a[88:95], 0
	buffer_load_dwordx4 a[120:123], v52, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v72, v8, v4, v72
	v_fma_f32 v73, v9, v4, v73
	v_fma_f32 v74, v10, v4, v74
	v_fma_f32 v75, v11, v4, v75
	s_waitcnt vmcnt(4)
	v_mul_f32_dpp v4, v20, v42 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[104:111], a[48:55], 0
	s_nop 5
	v_fma_f32 v76, v12, v6, v76
	v_fma_f32 v77, v13, v6, v77
	v_fma_f32 v78, v14, v6, v78
	v_fma_f32 v79, v15, v6, v79
	v_mul_f32_dpp v6, v20, v43 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[104:111], a[56:63], 0
	buffer_load_dwordx4 a[124:127], v52, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v80, v8, v4, v80
	v_fma_f32 v81, v9, v4, v81
	v_fma_f32 v82, v10, v4, v82
	v_fma_f32 v83, v11, v4, v83
	v_mul_f32_dpp v4, v20, v44 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[104:111], a[64:71], 0
	s_nop 5
	v_fma_f32 v84, v12, v6, v84
	v_fma_f32 v85, v13, v6, v85
	v_fma_f32 v86, v14, v6, v86
	v_fma_f32 v87, v15, v6, v87
	v_mul_f32_dpp v6, v20, v45 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[104:111], a[72:79], 0
	buffer_load_dwordx4 v48, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s47
	s_nop 5
	v_fma_f32 v88, v8, v4, v88
	v_fma_f32 v89, v9, v4, v89
	v_fma_f32 v90, v10, v4, v90
	v_fma_f32 v91, v11, v4, v91
	v_mul_f32_dpp v4, v20, v46 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[104:111], a[80:87], 0
	s_add_u32 s52, 0x80, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s73, s73, 0
	s_cselect_b32 s4, s4, 0
	s_nop 5
	v_fma_f32 v92, v12, v6, v92
	v_fma_f32 v93, v13, v6, v93
	v_fma_f32 v94, v14, v6, v94
	v_fma_f32 v95, v15, v6, v95
	v_mul_f32_dpp v6, v20, v47 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[104:111], a[88:95], 0
	buffer_load_dwordx4 v49, s[20:23], 0 offen lds
	s_add_u32 m0, 0x800, s47
	s_add_u32 s32, s4, s32
	s_addc_u32 s33, 0, s33
	s_nop 5
	v_fma_f32 v96, v8, v4, v96
	v_fma_f32 v97, v9, v4, v97
	v_fma_f32 v98, v10, v4, v98
	v_fma_f32 v99, v11, v4, v99
	s_nop 5
	v_fma_f32 v100, v12, v6, v100
	v_fma_f32 v101, v13, v6, v101
	v_fma_f32 v102, v14, v6, v102
	v_fma_f32 v103, v15, v6, v103
	buffer_load_dwordx4 v50, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s46
	buffer_load_dword v36, v24, s[28:31], 0 offen
	buffer_load_dword v37, v25, s[28:31], 0 offen
	buffer_load_dword v38, v26, s[28:31], 0 offen
	buffer_load_dword v39, v27, s[28:31], 0 offen
	buffer_load_dword v40, v28, s[28:31], 0 offen
	buffer_load_dword v41, v29, s[28:31], 0 offen
	s_waitcnt vmcnt(9)
	v_mul_f32_dpp v4, v23, v42 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[48:55], 0
	buffer_load_dword v20, v18, s[32:35], 0 offen
	ds_read_b128 a[0:3], v2
	ds_read_b128 a[4:7], v2 offset:64
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[48:55], 0
	buffer_load_dwordx4 a[96:99], v51, s[24:27], 0 offen
	s_nop 5
	v_fma_f32 v104, v8, v4, v104
	v_fma_f32 v105, v9, v4, v105
	v_fma_f32 v106, v10, v4, v106
	v_fma_f32 v107, v11, v4, v107
	v_mul_f32_dpp v6, v23, v43 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[56:63], 0
	ds_read_b128 a[8:11], v2 offset:512
	ds_read_b128 a[12:15], v2 offset:576
	s_nop 5
	v_fma_f32 v128, v12, v4, v128
	v_fma_f32 v129, v13, v4, v129
	v_fma_f32 v130, v14, v4, v130
	v_fma_f32 v131, v15, v4, v131
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[56:63], 0
	buffer_load_dwordx4 a[100:103], v51, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v108, v8, v6, v108
	v_fma_f32 v109, v9, v6, v109
	v_fma_f32 v110, v10, v6, v110
	v_fma_f32 v111, v11, v6, v111
	v_mul_f32_dpp v4, v23, v44 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[64:71], 0
	ds_read_b128 a[16:19], v2 offset:1024
	ds_read_b128 a[20:23], v2 offset:1088
	s_nop 5
	v_fma_f32 v132, v12, v6, v132
	v_fma_f32 v133, v13, v6, v133
	v_fma_f32 v134, v14, v6, v134
	v_fma_f32 v135, v15, v6, v135
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[64:71], 0
	buffer_load_dwordx4 a[104:107], v52, s[24:27], 0 offen
	s_nop 5
	v_fma_f32 v112, v8, v4, v112
	v_fma_f32 v113, v9, v4, v113
	v_fma_f32 v114, v10, v4, v114
	v_fma_f32 v115, v11, v4, v115
	v_mul_f32_dpp v6, v23, v45 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[72:79], 0
	ds_read_b128 a[24:27], v2 offset:1536
	ds_read_b128 a[28:31], v2 offset:1600
	s_nop 5
	v_fma_f32 v136, v12, v4, v136
	v_fma_f32 v137, v13, v4, v137
	v_fma_f32 v138, v14, v4, v138
	v_fma_f32 v139, v15, v4, v139
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[72:79], 0
	buffer_load_dwordx4 a[108:111], v52, s[24:27], 0 offen offset:1024
	s_add_u32 s52, 0x100, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s58, s58, 0
	s_nop 5
	v_fma_f32 v116, v8, v6, v116
	v_fma_f32 v117, v9, v6, v117
	v_fma_f32 v118, v10, v6, v118
	v_fma_f32 v119, v11, v6, v119
	v_mul_f32_dpp v4, v23, v46 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[80:87], 0
	ds_read_b128 a[32:35], v2 offset:2048
	ds_read_b128 a[36:39], v2 offset:2112
	s_add_u32 s76, s73, s24
	s_addc_u32 s77, 0, s77
	s_nop 5
	v_fma_f32 v140, v12, v6, v140
	v_fma_f32 v141, v13, v6, v141
	v_fma_f32 v142, v14, v6, v142
	v_fma_f32 v143, v15, v6, v143
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[80:87], 0
	s_add_u32 s52, 0x180, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s57, s57, 0
	s_cselect_b32 s6, s6, 0
	s_nop 5
	v_fma_f32 v120, v8, v4, v120
	v_fma_f32 v121, v9, v4, v121
	v_fma_f32 v122, v10, v4, v122
	v_fma_f32 v123, v11, v4, v123
	v_mul_f32_dpp v6, v23, v47 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[88:95], 0
	ds_read_b128 a[40:43], v2 offset:2560
	ds_read_b128 a[44:47], v2 offset:2624
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	s_nop 5
	v_fma_f32 v144, v12, v4, v144
	v_fma_f32 v145, v13, v4, v145
	v_fma_f32 v146, v14, v4, v146
	v_fma_f32 v147, v15, v4, v147
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[88:95], 0
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_nop 5
	v_fma_f32 v124, v8, v6, v124
	v_fma_f32 v125, v9, v6, v125
	v_fma_f32 v126, v10, v6, v126
	v_fma_f32 v127, v11, v6, v127
	s_nop 5
	v_fma_f32 v148, v12, v6, v148
	v_fma_f32 v149, v13, v6, v149
	v_fma_f32 v150, v14, v6, v150
	v_fma_f32 v151, v15, v6, v151
	s_addk_i32 s70, 0x80
	s_cmp_lt_i32 s70, s71
	s_cbranch_scc0 label_05C3
	s_branch label_029A

000000000000400c <label_05C3>:
	s_cmp_eq_u32 s74, 0
	s_cbranch_scc0 label_08ED
	v_cvt_pk_bf16_f32 v56, v56, v57
	v_cvt_pk_bf16_f32 v57, v58, v59
	v_cvt_pk_bf16_f32 v58, v60, v61
	v_cvt_pk_bf16_f32 v59, v62, v63
	v_cvt_pk_bf16_f32 v60, v64, v65
	v_cvt_pk_bf16_f32 v61, v66, v67
	v_cvt_pk_bf16_f32 v62, v68, v69
	v_cvt_pk_bf16_f32 v63, v70, v71
	v_cvt_pk_bf16_f32 v64, v72, v73
	v_cvt_pk_bf16_f32 v65, v74, v75
	v_cvt_pk_bf16_f32 v66, v76, v77
	v_cvt_pk_bf16_f32 v67, v78, v79
	v_cvt_pk_bf16_f32 v68, v80, v81
	v_cvt_pk_bf16_f32 v69, v82, v83
	v_cvt_pk_bf16_f32 v70, v84, v85
	v_cvt_pk_bf16_f32 v71, v86, v87
	v_cvt_pk_bf16_f32 v72, v88, v89
	v_cvt_pk_bf16_f32 v73, v90, v91
	v_cvt_pk_bf16_f32 v74, v92, v93
	v_cvt_pk_bf16_f32 v75, v94, v95
	v_cvt_pk_bf16_f32 v76, v96, v97
	v_cvt_pk_bf16_f32 v77, v98, v99
	v_cvt_pk_bf16_f32 v78, v100, v101
	v_cvt_pk_bf16_f32 v79, v102, v103
	ds_write_b64 v16, v[56:57]
	ds_write_b64 v16, v[58:59] offset:4352
	ds_write_b64 v16, v[60:61] offset:8704
	ds_write_b64 v16, v[62:63] offset:13056
	ds_write_b64 v16, v[64:65] offset:17408
	ds_write_b64 v16, v[66:67] offset:21760
	ds_write_b64 v16, v[68:69] offset:2176
	ds_write_b64 v16, v[70:71] offset:6528
	ds_write_b64 v16, v[72:73] offset:10880
	ds_write_b64 v16, v[74:75] offset:15232
	ds_write_b64 v16, v[76:77] offset:19584
	ds_write_b64 v16, v[78:79] offset:23936
	v_cvt_pk_bf16_f32 v104, v104, v105
	v_cvt_pk_bf16_f32 v105, v106, v107
	v_cvt_pk_bf16_f32 v106, v108, v109
	v_cvt_pk_bf16_f32 v107, v110, v111
	v_cvt_pk_bf16_f32 v108, v112, v113
	v_cvt_pk_bf16_f32 v109, v114, v115
	v_cvt_pk_bf16_f32 v110, v116, v117
	v_cvt_pk_bf16_f32 v111, v118, v119
	v_cvt_pk_bf16_f32 v112, v120, v121
	v_cvt_pk_bf16_f32 v113, v122, v123
	v_cvt_pk_bf16_f32 v114, v124, v125
	v_cvt_pk_bf16_f32 v115, v126, v127
	v_cvt_pk_bf16_f32 v116, v128, v129
	v_cvt_pk_bf16_f32 v117, v130, v131
	v_cvt_pk_bf16_f32 v118, v132, v133
	v_cvt_pk_bf16_f32 v119, v134, v135
	v_cvt_pk_bf16_f32 v120, v136, v137
	v_cvt_pk_bf16_f32 v121, v138, v139
	v_cvt_pk_bf16_f32 v122, v140, v141
	v_cvt_pk_bf16_f32 v123, v142, v143
	v_cvt_pk_bf16_f32 v124, v144, v145
	v_cvt_pk_bf16_f32 v125, v146, v147
	v_cvt_pk_bf16_f32 v126, v148, v149
	v_cvt_pk_bf16_f32 v127, v150, v151
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
	v_add_u32_e32 v80, v6, v7
	v_readlane_b32 s72, v3, 2
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 3
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v81, v6, v7
	v_readlane_b32 s72, v3, 4
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 5
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v82, v6, v7
	v_readlane_b32 s72, v3, 6
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 7
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v83, v6, v7
	v_readlane_b32 s72, v3, 8
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 9
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v84, v6, v7
	v_readlane_b32 s72, v3, 10
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 11
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v85, v6, v7
	v_readlane_b32 s72, v3, 12
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 13
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v86, v6, v7
	v_readlane_b32 s72, v3, 14
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 15
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v87, v6, v7
	v_readlane_b32 s72, v3, 16
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 17
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v88, v6, v7
	v_readlane_b32 s72, v3, 18
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 19
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v89, v6, v7
	v_readlane_b32 s72, v3, 20
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 21
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v90, v6, v7
	v_readlane_b32 s72, v3, 22
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 23
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v91, v6, v7
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 2, 4
	v_mul_lo_u32 v4, v4, s53
	v_and_b32_e64 v5, v0, 1
	v_add_u32_e32 v4, v4, v5
	v_lshlrev_b32_e32 v4, 2, v4
	v_add_u32_e32 v80, v80, v4
	v_add_u32_e32 v81, v81, v4
	v_add_u32_e32 v82, v82, v4
	v_add_u32_e32 v83, v83, v4
	v_add_u32_e32 v84, v84, v4
	v_add_u32_e32 v85, v85, v4
	v_add_u32_e32 v86, v86, v4
	v_add_u32_e32 v87, v87, v4
	v_add_u32_e32 v88, v88, v4
	v_add_u32_e32 v89, v89, v4
	v_add_u32_e32 v90, v90, v4
	v_add_u32_e32 v91, v91, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v56, v17
	ds_read_b32 v57, v17 offset:64
	ds_read_b32 v58, v17 offset:2176
	ds_read_b32 v59, v17 offset:2240
	ds_read_b32 v60, v17 offset:4352
	ds_read_b32 v61, v17 offset:4416
	ds_read_b32 v62, v17 offset:6528
	ds_read_b32 v63, v17 offset:6592
	ds_read_b32 v64, v17 offset:8704
	ds_read_b32 v65, v17 offset:8768
	ds_read_b32 v66, v17 offset:10880
	ds_read_b32 v67, v17 offset:10944
	ds_read_b32 v68, v17 offset:13056
	ds_read_b32 v69, v17 offset:13120
	ds_read_b32 v70, v17 offset:15232
	ds_read_b32 v71, v17 offset:15296
	ds_read_b32 v72, v17 offset:17408
	ds_read_b32 v73, v17 offset:17472
	ds_read_b32 v74, v17 offset:19584
	ds_read_b32 v75, v17 offset:19648
	ds_read_b32 v76, v17 offset:21760
	ds_read_b32 v77, v17 offset:21824
	ds_read_b32 v78, v17 offset:23936
	ds_read_b32 v79, v17 offset:24000
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_or_b32 s9, s9, 0x40000
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v80
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v56, v6, s[8:11], 0 offen
	buffer_store_dword v58, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v81
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v57, v6, s[8:11], 0 offen
	buffer_store_dword v59, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v82
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v60, v6, s[8:11], 0 offen
	buffer_store_dword v62, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v83
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v61, v6, s[8:11], 0 offen
	buffer_store_dword v63, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v84
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v64, v6, s[8:11], 0 offen
	buffer_store_dword v66, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v85
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v65, v6, s[8:11], 0 offen
	buffer_store_dword v67, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v86
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v68, v6, s[8:11], 0 offen
	buffer_store_dword v70, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v87
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v69, v6, s[8:11], 0 offen
	buffer_store_dword v71, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v88
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v72, v6, s[8:11], 0 offen
	buffer_store_dword v74, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v89
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v73, v6, s[8:11], 0 offen
	buffer_store_dword v75, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v90
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v76, v6, s[8:11], 0 offen
	buffer_store_dword v78, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v91
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v77, v6, s[8:11], 0 offen
	buffer_store_dword v79, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_write_b64 v16, v[104:105]
	ds_write_b64 v16, v[106:107] offset:4352
	ds_write_b64 v16, v[108:109] offset:8704
	ds_write_b64 v16, v[110:111] offset:13056
	ds_write_b64 v16, v[112:113] offset:17408
	ds_write_b64 v16, v[114:115] offset:21760
	ds_write_b64 v16, v[116:117] offset:2176
	ds_write_b64 v16, v[118:119] offset:6528
	ds_write_b64 v16, v[120:121] offset:10880
	ds_write_b64 v16, v[122:123] offset:15232
	ds_write_b64 v16, v[124:125] offset:19584
	ds_write_b64 v16, v[126:127] offset:23936
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v104, v17
	ds_read_b32 v105, v17 offset:64
	ds_read_b32 v106, v17 offset:2176
	ds_read_b32 v107, v17 offset:2240
	ds_read_b32 v108, v17 offset:4352
	ds_read_b32 v109, v17 offset:4416
	ds_read_b32 v110, v17 offset:6528
	ds_read_b32 v111, v17 offset:6592
	ds_read_b32 v112, v17 offset:8704
	ds_read_b32 v113, v17 offset:8768
	ds_read_b32 v114, v17 offset:10880
	ds_read_b32 v115, v17 offset:10944
	ds_read_b32 v116, v17 offset:13056
	ds_read_b32 v117, v17 offset:13120
	ds_read_b32 v118, v17 offset:15232
	ds_read_b32 v119, v17 offset:15296
	ds_read_b32 v120, v17 offset:17408
	ds_read_b32 v121, v17 offset:17472
	ds_read_b32 v122, v17 offset:19584
	ds_read_b32 v123, v17 offset:19648
	ds_read_b32 v124, v17 offset:21760
	ds_read_b32 v125, v17 offset:21824
	ds_read_b32 v126, v17 offset:23936
	ds_read_b32 v127, v17 offset:24000
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_add_u32 s8, 0x100, s8
	s_addc_u32 s9, 0, s9
	s_or_b32 s9, s9, 0x40000
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v80
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v104, v6, s[8:11], 0 offen
	buffer_store_dword v106, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v81
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v105, v6, s[8:11], 0 offen
	buffer_store_dword v107, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v82
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v108, v6, s[8:11], 0 offen
	buffer_store_dword v110, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v83
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v109, v6, s[8:11], 0 offen
	buffer_store_dword v111, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v84
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v112, v6, s[8:11], 0 offen
	buffer_store_dword v114, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v85
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v113, v6, s[8:11], 0 offen
	buffer_store_dword v115, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v86
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v116, v6, s[8:11], 0 offen
	buffer_store_dword v118, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v87
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v117, v6, s[8:11], 0 offen
	buffer_store_dword v119, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v88
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v120, v6, s[8:11], 0 offen
	buffer_store_dword v122, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v89
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v121, v6, s[8:11], 0 offen
	buffer_store_dword v123, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v90
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v124, v6, s[8:11], 0 offen
	buffer_store_dword v126, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v91
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v125, v6, s[8:11], 0 offen
	buffer_store_dword v127, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	s_branch label_18F7

0000000000004cb4 <label_08ED>:
	ds_write_b64 v16, v[56:57]
	ds_write_b64 v16, v[60:61] offset:4352
	ds_write_b64 v16, v[64:65] offset:8704
	ds_write_b64 v16, v[68:69] offset:13056
	ds_write_b64 v16, v[72:73] offset:17408
	ds_write_b64 v16, v[76:77] offset:21760
	ds_write_b64 v16, v[80:81] offset:2176
	ds_write_b64 v16, v[84:85] offset:6528
	ds_write_b64 v16, v[88:89] offset:10880
	ds_write_b64 v16, v[92:93] offset:15232
	ds_write_b64 v16, v[96:97] offset:19584
	ds_write_b64 v16, v[100:101] offset:23936
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
	v_add_u32_e32 v80, v6, v7
	v_readlane_b32 s72, v3, 2
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 3
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v81, v6, v7
	v_readlane_b32 s72, v3, 4
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 5
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v82, v6, v7
	v_readlane_b32 s72, v3, 6
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 7
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v83, v6, v7
	v_readlane_b32 s72, v3, 8
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 9
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v84, v6, v7
	v_readlane_b32 s72, v3, 10
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 11
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v85, v6, v7
	v_readlane_b32 s72, v3, 12
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 13
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v86, v6, v7
	v_readlane_b32 s72, v3, 14
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 15
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v87, v6, v7
	v_readlane_b32 s72, v3, 16
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 17
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v88, v6, v7
	v_readlane_b32 s72, v3, 18
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 19
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v89, v6, v7
	v_readlane_b32 s72, v3, 20
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 21
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v90, v6, v7
	v_readlane_b32 s72, v3, 22
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 23
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v91, v6, v7
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 2, 4
	v_mul_lo_u32 v4, v4, s53
	v_and_b32_e64 v5, v0, 1
	v_add_u32_e32 v4, v4, v5
	v_lshlrev_b32_e32 v4, 2, v4
	v_add_u32_e32 v80, v80, v4
	v_add_u32_e32 v81, v81, v4
	v_add_u32_e32 v82, v82, v4
	v_add_u32_e32 v83, v83, v4
	v_add_u32_e32 v84, v84, v4
	v_add_u32_e32 v85, v85, v4
	v_add_u32_e32 v86, v86, v4
	v_add_u32_e32 v87, v87, v4
	v_add_u32_e32 v88, v88, v4
	v_add_u32_e32 v89, v89, v4
	v_add_u32_e32 v90, v90, v4
	v_add_u32_e32 v91, v91, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v56, v17
	ds_read_b32 v57, v17 offset:64
	ds_read_b32 v60, v17 offset:2176
	ds_read_b32 v61, v17 offset:2240
	ds_read_b32 v64, v17 offset:4352
	ds_read_b32 v65, v17 offset:4416
	ds_read_b32 v68, v17 offset:6528
	ds_read_b32 v69, v17 offset:6592
	ds_read_b32 v72, v17 offset:8704
	ds_read_b32 v73, v17 offset:8768
	ds_read_b32 v76, v17 offset:10880
	ds_read_b32 v77, v17 offset:10944
	ds_read_b32 v80, v17 offset:13056
	ds_read_b32 v81, v17 offset:13120
	ds_read_b32 v84, v17 offset:15232
	ds_read_b32 v85, v17 offset:15296
	ds_read_b32 v88, v17 offset:17408
	ds_read_b32 v89, v17 offset:17472
	ds_read_b32 v92, v17 offset:19584
	ds_read_b32 v93, v17 offset:19648
	ds_read_b32 v96, v17 offset:21760
	ds_read_b32 v97, v17 offset:21824
	ds_read_b32 v100, v17 offset:23936
	ds_read_b32 v101, v17 offset:24000
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v80
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v56, s[8:9]
	global_atomic_add_f32 v6, v60, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v81
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v57, s[8:9]
	global_atomic_add_f32 v6, v61, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v82
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v64, s[8:9]
	global_atomic_add_f32 v6, v68, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v83
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v65, s[8:9]
	global_atomic_add_f32 v6, v69, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v84
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v72, s[8:9]
	global_atomic_add_f32 v6, v76, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v85
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v73, s[8:9]
	global_atomic_add_f32 v6, v77, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v86
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v80, s[8:9]
	global_atomic_add_f32 v6, v84, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v87
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v81, s[8:9]
	global_atomic_add_f32 v6, v85, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v88
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v88, s[8:9]
	global_atomic_add_f32 v6, v92, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v89
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v89, s[8:9]
	global_atomic_add_f32 v6, v93, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v90
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v96, s[8:9]
	global_atomic_add_f32 v6, v100, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v91
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v97, s[8:9]
	global_atomic_add_f32 v6, v101, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[58:59]
	ds_write_b64 v16, v[62:63] offset:4352
	ds_write_b64 v16, v[66:67] offset:8704
	ds_write_b64 v16, v[70:71] offset:13056
	ds_write_b64 v16, v[74:75] offset:17408
	ds_write_b64 v16, v[78:79] offset:21760
	ds_write_b64 v16, v[82:83] offset:2176
	ds_write_b64 v16, v[86:87] offset:6528
	ds_write_b64 v16, v[90:91] offset:10880
	ds_write_b64 v16, v[94:95] offset:15232
	ds_write_b64 v16, v[98:99] offset:19584
	ds_write_b64 v16, v[102:103] offset:23936
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v58, v17
	ds_read_b32 v59, v17 offset:64
	ds_read_b32 v62, v17 offset:2176
	ds_read_b32 v63, v17 offset:2240
	ds_read_b32 v66, v17 offset:4352
	ds_read_b32 v67, v17 offset:4416
	ds_read_b32 v70, v17 offset:6528
	ds_read_b32 v71, v17 offset:6592
	ds_read_b32 v74, v17 offset:8704
	ds_read_b32 v75, v17 offset:8768
	ds_read_b32 v78, v17 offset:10880
	ds_read_b32 v79, v17 offset:10944
	ds_read_b32 v82, v17 offset:13056
	ds_read_b32 v83, v17 offset:13120
	ds_read_b32 v86, v17 offset:15232
	ds_read_b32 v87, v17 offset:15296
	ds_read_b32 v90, v17 offset:17408
	ds_read_b32 v91, v17 offset:17472
	ds_read_b32 v94, v17 offset:19584
	ds_read_b32 v95, v17 offset:19648
	ds_read_b32 v98, v17 offset:21760
	ds_read_b32 v99, v17 offset:21824
	ds_read_b32 v102, v17 offset:23936
	ds_read_b32 v103, v17 offset:24000
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v80
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v58, s[8:9] offset:8
	global_atomic_add_f32 v6, v62, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v81
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v59, s[8:9] offset:8
	global_atomic_add_f32 v6, v63, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v82
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v66, s[8:9] offset:8
	global_atomic_add_f32 v6, v70, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v83
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v67, s[8:9] offset:8
	global_atomic_add_f32 v6, v71, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v84
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v74, s[8:9] offset:8
	global_atomic_add_f32 v6, v78, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v85
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v75, s[8:9] offset:8
	global_atomic_add_f32 v6, v79, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v86
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v82, s[8:9] offset:8
	global_atomic_add_f32 v6, v86, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v87
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v83, s[8:9] offset:8
	global_atomic_add_f32 v6, v87, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v88
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v90, s[8:9] offset:8
	global_atomic_add_f32 v6, v94, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v89
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v91, s[8:9] offset:8
	global_atomic_add_f32 v6, v95, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v90
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v98, s[8:9] offset:8
	global_atomic_add_f32 v6, v102, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v91
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v99, s[8:9] offset:8
	global_atomic_add_f32 v6, v103, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[104:105]
	ds_write_b64 v16, v[108:109] offset:4352
	ds_write_b64 v16, v[112:113] offset:8704
	ds_write_b64 v16, v[116:117] offset:13056
	ds_write_b64 v16, v[120:121] offset:17408
	ds_write_b64 v16, v[124:125] offset:21760
	ds_write_b64 v16, v[128:129] offset:2176
	ds_write_b64 v16, v[132:133] offset:6528
	ds_write_b64 v16, v[136:137] offset:10880
	ds_write_b64 v16, v[140:141] offset:15232
	ds_write_b64 v16, v[144:145] offset:19584
	ds_write_b64 v16, v[148:149] offset:23936
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v104, v17
	ds_read_b32 v105, v17 offset:64
	ds_read_b32 v108, v17 offset:2176
	ds_read_b32 v109, v17 offset:2240
	ds_read_b32 v112, v17 offset:4352
	ds_read_b32 v113, v17 offset:4416
	ds_read_b32 v116, v17 offset:6528
	ds_read_b32 v117, v17 offset:6592
	ds_read_b32 v120, v17 offset:8704
	ds_read_b32 v121, v17 offset:8768
	ds_read_b32 v124, v17 offset:10880
	ds_read_b32 v125, v17 offset:10944
	ds_read_b32 v128, v17 offset:13056
	ds_read_b32 v129, v17 offset:13120
	ds_read_b32 v132, v17 offset:15232
	ds_read_b32 v133, v17 offset:15296
	ds_read_b32 v136, v17 offset:17408
	ds_read_b32 v137, v17 offset:17472
	ds_read_b32 v140, v17 offset:19584
	ds_read_b32 v141, v17 offset:19648
	ds_read_b32 v144, v17 offset:21760
	ds_read_b32 v145, v17 offset:21824
	ds_read_b32 v148, v17 offset:23936
	ds_read_b32 v149, v17 offset:24000
	s_mul_i32 s52, s61, 4
	s_add_u32 s8, s52, s8
	s_addc_u32 s9, 0, s9
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v80
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v104, s[8:9]
	global_atomic_add_f32 v6, v108, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v81
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v105, s[8:9]
	global_atomic_add_f32 v6, v109, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v82
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v112, s[8:9]
	global_atomic_add_f32 v6, v116, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v83
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v113, s[8:9]
	global_atomic_add_f32 v6, v117, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v84
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v120, s[8:9]
	global_atomic_add_f32 v6, v124, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v85
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v121, s[8:9]
	global_atomic_add_f32 v6, v125, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v86
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v128, s[8:9]
	global_atomic_add_f32 v6, v132, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v87
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v129, s[8:9]
	global_atomic_add_f32 v6, v133, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v88
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v136, s[8:9]
	global_atomic_add_f32 v6, v140, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v89
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v137, s[8:9]
	global_atomic_add_f32 v6, v141, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v90
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v144, s[8:9]
	global_atomic_add_f32 v6, v148, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v91
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v145, s[8:9]
	global_atomic_add_f32 v6, v149, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[106:107]
	ds_write_b64 v16, v[110:111] offset:4352
	ds_write_b64 v16, v[114:115] offset:8704
	ds_write_b64 v16, v[118:119] offset:13056
	ds_write_b64 v16, v[122:123] offset:17408
	ds_write_b64 v16, v[126:127] offset:21760
	ds_write_b64 v16, v[130:131] offset:2176
	ds_write_b64 v16, v[134:135] offset:6528
	ds_write_b64 v16, v[138:139] offset:10880
	ds_write_b64 v16, v[142:143] offset:15232
	ds_write_b64 v16, v[146:147] offset:19584
	ds_write_b64 v16, v[150:151] offset:23936
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v106, v17
	ds_read_b32 v107, v17 offset:64
	ds_read_b32 v110, v17 offset:2176
	ds_read_b32 v111, v17 offset:2240
	ds_read_b32 v114, v17 offset:4352
	ds_read_b32 v115, v17 offset:4416
	ds_read_b32 v118, v17 offset:6528
	ds_read_b32 v119, v17 offset:6592
	ds_read_b32 v122, v17 offset:8704
	ds_read_b32 v123, v17 offset:8768
	ds_read_b32 v126, v17 offset:10880
	ds_read_b32 v127, v17 offset:10944
	ds_read_b32 v130, v17 offset:13056
	ds_read_b32 v131, v17 offset:13120
	ds_read_b32 v134, v17 offset:15232
	ds_read_b32 v135, v17 offset:15296
	ds_read_b32 v138, v17 offset:17408
	ds_read_b32 v139, v17 offset:17472
	ds_read_b32 v142, v17 offset:19584
	ds_read_b32 v143, v17 offset:19648
	ds_read_b32 v146, v17 offset:21760
	ds_read_b32 v147, v17 offset:21824
	ds_read_b32 v150, v17 offset:23936
	ds_read_b32 v151, v17 offset:24000
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v80
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v106, s[8:9] offset:8
	global_atomic_add_f32 v6, v110, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v81
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v107, s[8:9] offset:8
	global_atomic_add_f32 v6, v111, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v82
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v114, s[8:9] offset:8
	global_atomic_add_f32 v6, v118, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v83
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v115, s[8:9] offset:8
	global_atomic_add_f32 v6, v119, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v84
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v122, s[8:9] offset:8
	global_atomic_add_f32 v6, v126, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v85
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v123, s[8:9] offset:8
	global_atomic_add_f32 v6, v127, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v86
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v130, s[8:9] offset:8
	global_atomic_add_f32 v6, v134, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v87
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v131, s[8:9] offset:8
	global_atomic_add_f32 v6, v135, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v88
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v138, s[8:9] offset:8
	global_atomic_add_f32 v6, v142, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v89
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v139, s[8:9] offset:8
	global_atomic_add_f32 v6, v143, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v90
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v146, s[8:9] offset:8
	global_atomic_add_f32 v6, v150, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v91
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v147, s[8:9] offset:8
	global_atomic_add_f32 v6, v151, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	s_branch label_18F7

000000000000601c <label_0DCA>:
	s_waitcnt vmcnt(2) lgkmcnt(0)
	s_barrier
	v_mov_b32_e32 v42, v30
	v_mov_b32_e32 v43, v31
	v_mov_b32_e32 v44, v32
	v_mov_b32_e32 v45, v33
	v_mov_b32_e32 v46, v34
	v_mov_b32_e32 v47, v35
	v_mul_f32_dpp v4, v20, v42 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[96:103], a[0:7], 0
	buffer_load_dword v23, v19, s[32:35], 0 offen
	buffer_load_dwordx4 a[112:115], v51, s[76:79], 0 offen
	v_mul_f32_dpp v6, v20, v43 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[96:103], a[8:15], 0
	s_nop 5
	v_fma_f32 v56, v8, v4, v56
	v_fma_f32 v57, v9, v4, v57
	v_fma_f32 v58, v10, v4, v58
	v_fma_f32 v59, v11, v4, v59
	v_mul_f32_dpp v4, v20, v44 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[96:103], a[16:23], 0
	buffer_load_dwordx4 a[116:119], v51, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v60, v12, v6, v60
	v_fma_f32 v61, v13, v6, v61
	v_fma_f32 v62, v14, v6, v62
	v_fma_f32 v63, v15, v6, v63
	v_mul_f32_dpp v6, v20, v45 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[96:103], a[24:31], 0
	s_nop 5
	v_fma_f32 v64, v8, v4, v64
	v_fma_f32 v65, v9, v4, v65
	v_fma_f32 v66, v10, v4, v66
	v_fma_f32 v67, v11, v4, v67
	v_mul_f32_dpp v4, v20, v46 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[96:103], a[32:39], 0
	buffer_load_dwordx4 a[120:123], v52, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v68, v12, v6, v68
	v_fma_f32 v69, v13, v6, v69
	v_fma_f32 v70, v14, v6, v70
	v_fma_f32 v71, v15, v6, v71
	v_mul_f32_dpp v6, v20, v47 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[96:103], a[40:47], 0
	s_nop 5
	v_fma_f32 v72, v8, v4, v72
	v_fma_f32 v73, v9, v4, v73
	v_fma_f32 v74, v10, v4, v74
	v_fma_f32 v75, v11, v4, v75
	s_waitcnt vmcnt(4)
	v_mul_f32_dpp v4, v20, v42 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[104:111], a[0:7], 0
	buffer_load_dwordx4 a[124:127], v52, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v76, v12, v6, v76
	v_fma_f32 v77, v13, v6, v77
	v_fma_f32 v78, v14, v6, v78
	v_fma_f32 v79, v15, v6, v79
	v_mul_f32_dpp v6, v20, v43 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[104:111], a[8:15], 0
	s_nop 5
	v_fma_f32 v80, v8, v4, v80
	v_fma_f32 v81, v9, v4, v81
	v_fma_f32 v82, v10, v4, v82
	v_fma_f32 v83, v11, v4, v83
	v_mul_f32_dpp v4, v20, v44 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[104:111], a[16:23], 0
	buffer_load_dwordx4 v48, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s46
	s_nop 5
	v_fma_f32 v84, v12, v6, v84
	v_fma_f32 v85, v13, v6, v85
	v_fma_f32 v86, v14, v6, v86
	v_fma_f32 v87, v15, v6, v87
	v_mul_f32_dpp v6, v20, v45 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[104:111], a[24:31], 0
	s_nop 5
	v_fma_f32 v88, v8, v4, v88
	v_fma_f32 v89, v9, v4, v89
	v_fma_f32 v90, v10, v4, v90
	v_fma_f32 v91, v11, v4, v91
	v_mul_f32_dpp v4, v20, v46 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[104:111], a[32:39], 0
	buffer_load_dwordx4 v49, s[20:23], 0 offen lds
	s_add_u32 m0, 0x800, s46
	s_add_u32 s52, 0x80, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s73, s73, 0
	s_cselect_b32 s4, s4, 0
	s_nop 5
	v_fma_f32 v92, v12, v6, v92
	v_fma_f32 v93, v13, v6, v93
	v_fma_f32 v94, v14, v6, v94
	v_fma_f32 v95, v15, v6, v95
	v_mul_f32_dpp v6, v20, v47 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[104:111], a[40:47], 0
	s_add_u32 s32, s4, s32
	s_addc_u32 s33, 0, s33
	s_nop 5
	v_fma_f32 v96, v8, v4, v96
	v_fma_f32 v97, v9, v4, v97
	v_fma_f32 v98, v10, v4, v98
	v_fma_f32 v99, v11, v4, v99
	s_nop 5
	v_fma_f32 v100, v12, v6, v100
	v_fma_f32 v101, v13, v6, v101
	v_fma_f32 v102, v14, v6, v102
	v_fma_f32 v103, v15, v6, v103
	buffer_load_dwordx4 v50, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s47
	buffer_load_dword v30, v24, s[28:31], 0 offen
	buffer_load_dword v31, v25, s[28:31], 0 offen
	buffer_load_dword v32, v26, s[28:31], 0 offen
	buffer_load_dword v33, v27, s[28:31], 0 offen
	buffer_load_dword v34, v28, s[28:31], 0 offen
	buffer_load_dword v35, v29, s[28:31], 0 offen
	s_waitcnt vmcnt(9)
	v_mul_f32_dpp v4, v23, v42 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[0:7], 0
	buffer_load_dword v20, v18, s[32:35], 0 offen
	buffer_load_dwordx4 a[96:99], v51, s[24:27], 0 offen
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[0:7], 0
	ds_read_b128 a[48:51], v2 offset:12416
	ds_read_b128 a[52:55], v2 offset:12480
	s_nop 5
	v_fma_f32 v104, v8, v4, v104
	v_fma_f32 v105, v9, v4, v105
	v_fma_f32 v106, v10, v4, v106
	v_fma_f32 v107, v11, v4, v107
	v_mul_f32_dpp v6, v23, v43 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[8:15], 0
	buffer_load_dwordx4 a[100:103], v51, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v128, v12, v4, v128
	v_fma_f32 v129, v13, v4, v129
	v_fma_f32 v130, v14, v4, v130
	v_fma_f32 v131, v15, v4, v131
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[8:15], 0
	ds_read_b128 a[56:59], v2 offset:12928
	ds_read_b128 a[60:63], v2 offset:12992
	s_nop 5
	v_fma_f32 v108, v8, v6, v108
	v_fma_f32 v109, v9, v6, v109
	v_fma_f32 v110, v10, v6, v110
	v_fma_f32 v111, v11, v6, v111
	v_mul_f32_dpp v4, v23, v44 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[16:23], 0
	buffer_load_dwordx4 a[104:107], v52, s[24:27], 0 offen
	s_nop 5
	v_fma_f32 v132, v12, v6, v132
	v_fma_f32 v133, v13, v6, v133
	v_fma_f32 v134, v14, v6, v134
	v_fma_f32 v135, v15, v6, v135
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[16:23], 0
	ds_read_b128 a[64:67], v2 offset:13440
	ds_read_b128 a[68:71], v2 offset:13504
	s_nop 5
	v_fma_f32 v112, v8, v4, v112
	v_fma_f32 v113, v9, v4, v113
	v_fma_f32 v114, v10, v4, v114
	v_fma_f32 v115, v11, v4, v115
	v_mul_f32_dpp v6, v23, v45 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[24:31], 0
	buffer_load_dwordx4 a[108:111], v52, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v136, v12, v4, v136
	v_fma_f32 v137, v13, v4, v137
	v_fma_f32 v138, v14, v4, v138
	v_fma_f32 v139, v15, v4, v139
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[24:31], 0
	ds_read_b128 a[72:75], v2 offset:13952
	ds_read_b128 a[76:79], v2 offset:14016
	s_add_u32 s52, 0x100, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s58, s58, 0
	s_nop 5
	v_fma_f32 v116, v8, v6, v116
	v_fma_f32 v117, v9, v6, v117
	v_fma_f32 v118, v10, v6, v118
	v_fma_f32 v119, v11, v6, v119
	v_mul_f32_dpp v4, v23, v46 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[32:39], 0
	s_add_u32 s76, s73, s24
	s_addc_u32 s77, 0, s77
	s_nop 5
	v_fma_f32 v140, v12, v6, v140
	v_fma_f32 v141, v13, v6, v141
	v_fma_f32 v142, v14, v6, v142
	v_fma_f32 v143, v15, v6, v143
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[32:39], 0
	ds_read_b128 a[80:83], v2 offset:14464
	ds_read_b128 a[84:87], v2 offset:14528
	s_add_u32 s52, 0x180, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s57, s57, 0
	s_cselect_b32 s6, s6, 0
	s_nop 5
	v_fma_f32 v120, v8, v4, v120
	v_fma_f32 v121, v9, v4, v121
	v_fma_f32 v122, v10, v4, v122
	v_fma_f32 v123, v11, v4, v123
	v_mul_f32_dpp v6, v23, v47 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[40:47], 0
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	s_nop 5
	v_fma_f32 v144, v12, v4, v144
	v_fma_f32 v145, v13, v4, v145
	v_fma_f32 v146, v14, v4, v146
	v_fma_f32 v147, v15, v4, v147
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[40:47], 0
	ds_read_b128 a[88:91], v2 offset:14976
	ds_read_b128 a[92:95], v2 offset:15040
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_nop 5
	v_fma_f32 v124, v8, v6, v124
	v_fma_f32 v125, v9, v6, v125
	v_fma_f32 v126, v10, v6, v126
	v_fma_f32 v127, v11, v6, v127
	s_nop 5
	v_fma_f32 v148, v12, v6, v148
	v_fma_f32 v149, v13, v6, v149
	v_fma_f32 v150, v14, v6, v150
	v_fma_f32 v151, v15, v6, v151
	s_addk_i32 s70, 0x80
	s_cmp_lt_i32 s70, s71
	s_cbranch_scc0 label_10F3
	s_waitcnt vmcnt(2) lgkmcnt(0)
	s_barrier
	v_mov_b32_e32 v42, v36
	v_mov_b32_e32 v43, v37
	v_mov_b32_e32 v44, v38
	v_mov_b32_e32 v45, v39
	v_mov_b32_e32 v46, v40
	v_mov_b32_e32 v47, v41
	v_mul_f32_dpp v4, v20, v42 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[96:103], a[48:55], 0
	buffer_load_dword v23, v19, s[32:35], 0 offen
	buffer_load_dwordx4 a[112:115], v51, s[76:79], 0 offen
	v_mul_f32_dpp v6, v20, v43 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[96:103], a[56:63], 0
	s_nop 5
	v_fma_f32 v56, v8, v4, v56
	v_fma_f32 v57, v9, v4, v57
	v_fma_f32 v58, v10, v4, v58
	v_fma_f32 v59, v11, v4, v59
	v_mul_f32_dpp v4, v20, v44 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[96:103], a[64:71], 0
	buffer_load_dwordx4 a[116:119], v51, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v60, v12, v6, v60
	v_fma_f32 v61, v13, v6, v61
	v_fma_f32 v62, v14, v6, v62
	v_fma_f32 v63, v15, v6, v63
	v_mul_f32_dpp v6, v20, v45 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[96:103], a[72:79], 0
	s_nop 5
	v_fma_f32 v64, v8, v4, v64
	v_fma_f32 v65, v9, v4, v65
	v_fma_f32 v66, v10, v4, v66
	v_fma_f32 v67, v11, v4, v67
	v_mul_f32_dpp v4, v20, v46 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[96:103], a[80:87], 0
	buffer_load_dwordx4 a[120:123], v52, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v68, v12, v6, v68
	v_fma_f32 v69, v13, v6, v69
	v_fma_f32 v70, v14, v6, v70
	v_fma_f32 v71, v15, v6, v71
	v_mul_f32_dpp v6, v20, v47 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[96:103], a[88:95], 0
	s_nop 5
	v_fma_f32 v72, v8, v4, v72
	v_fma_f32 v73, v9, v4, v73
	v_fma_f32 v74, v10, v4, v74
	v_fma_f32 v75, v11, v4, v75
	s_waitcnt vmcnt(4)
	v_mul_f32_dpp v4, v20, v42 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[104:111], a[48:55], 0
	buffer_load_dwordx4 a[124:127], v52, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v76, v12, v6, v76
	v_fma_f32 v77, v13, v6, v77
	v_fma_f32 v78, v14, v6, v78
	v_fma_f32 v79, v15, v6, v79
	v_mul_f32_dpp v6, v20, v43 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[104:111], a[56:63], 0
	s_nop 5
	v_fma_f32 v80, v8, v4, v80
	v_fma_f32 v81, v9, v4, v81
	v_fma_f32 v82, v10, v4, v82
	v_fma_f32 v83, v11, v4, v83
	v_mul_f32_dpp v4, v20, v44 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[104:111], a[64:71], 0
	buffer_load_dwordx4 v48, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s47
	s_nop 5
	v_fma_f32 v84, v12, v6, v84
	v_fma_f32 v85, v13, v6, v85
	v_fma_f32 v86, v14, v6, v86
	v_fma_f32 v87, v15, v6, v87
	v_mul_f32_dpp v6, v20, v45 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[104:111], a[72:79], 0
	s_nop 5
	v_fma_f32 v88, v8, v4, v88
	v_fma_f32 v89, v9, v4, v89
	v_fma_f32 v90, v10, v4, v90
	v_fma_f32 v91, v11, v4, v91
	v_mul_f32_dpp v4, v20, v46 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[104:111], a[80:87], 0
	buffer_load_dwordx4 v49, s[20:23], 0 offen lds
	s_add_u32 m0, 0x800, s47
	s_add_u32 s52, 0x80, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s73, s73, 0
	s_cselect_b32 s4, s4, 0
	s_nop 5
	v_fma_f32 v92, v12, v6, v92
	v_fma_f32 v93, v13, v6, v93
	v_fma_f32 v94, v14, v6, v94
	v_fma_f32 v95, v15, v6, v95
	v_mul_f32_dpp v6, v20, v47 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[104:111], a[88:95], 0
	s_add_u32 s32, s4, s32
	s_addc_u32 s33, 0, s33
	s_nop 5
	v_fma_f32 v96, v8, v4, v96
	v_fma_f32 v97, v9, v4, v97
	v_fma_f32 v98, v10, v4, v98
	v_fma_f32 v99, v11, v4, v99
	s_nop 5
	v_fma_f32 v100, v12, v6, v100
	v_fma_f32 v101, v13, v6, v101
	v_fma_f32 v102, v14, v6, v102
	v_fma_f32 v103, v15, v6, v103
	buffer_load_dwordx4 v50, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s46
	buffer_load_dword v36, v24, s[28:31], 0 offen
	buffer_load_dword v37, v25, s[28:31], 0 offen
	buffer_load_dword v38, v26, s[28:31], 0 offen
	buffer_load_dword v39, v27, s[28:31], 0 offen
	buffer_load_dword v40, v28, s[28:31], 0 offen
	buffer_load_dword v41, v29, s[28:31], 0 offen
	s_waitcnt vmcnt(9)
	v_mul_f32_dpp v4, v23, v42 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[48:55], 0
	buffer_load_dword v20, v18, s[32:35], 0 offen
	buffer_load_dwordx4 a[96:99], v51, s[24:27], 0 offen
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[48:55], 0
	ds_read_b128 a[0:3], v2
	ds_read_b128 a[4:7], v2 offset:64
	s_nop 5
	v_fma_f32 v104, v8, v4, v104
	v_fma_f32 v105, v9, v4, v105
	v_fma_f32 v106, v10, v4, v106
	v_fma_f32 v107, v11, v4, v107
	v_mul_f32_dpp v6, v23, v43 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[56:63], 0
	buffer_load_dwordx4 a[100:103], v51, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v128, v12, v4, v128
	v_fma_f32 v129, v13, v4, v129
	v_fma_f32 v130, v14, v4, v130
	v_fma_f32 v131, v15, v4, v131
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[56:63], 0
	ds_read_b128 a[8:11], v2 offset:512
	ds_read_b128 a[12:15], v2 offset:576
	s_nop 5
	v_fma_f32 v108, v8, v6, v108
	v_fma_f32 v109, v9, v6, v109
	v_fma_f32 v110, v10, v6, v110
	v_fma_f32 v111, v11, v6, v111
	v_mul_f32_dpp v4, v23, v44 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[64:71], 0
	buffer_load_dwordx4 a[104:107], v52, s[24:27], 0 offen
	s_nop 5
	v_fma_f32 v132, v12, v6, v132
	v_fma_f32 v133, v13, v6, v133
	v_fma_f32 v134, v14, v6, v134
	v_fma_f32 v135, v15, v6, v135
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[64:71], 0
	ds_read_b128 a[16:19], v2 offset:1024
	ds_read_b128 a[20:23], v2 offset:1088
	s_nop 5
	v_fma_f32 v112, v8, v4, v112
	v_fma_f32 v113, v9, v4, v113
	v_fma_f32 v114, v10, v4, v114
	v_fma_f32 v115, v11, v4, v115
	v_mul_f32_dpp v6, v23, v45 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[72:79], 0
	buffer_load_dwordx4 a[108:111], v52, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v136, v12, v4, v136
	v_fma_f32 v137, v13, v4, v137
	v_fma_f32 v138, v14, v4, v138
	v_fma_f32 v139, v15, v4, v139
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[72:79], 0
	ds_read_b128 a[24:27], v2 offset:1536
	ds_read_b128 a[28:31], v2 offset:1600
	s_add_u32 s52, 0x100, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s58, s58, 0
	s_nop 5
	v_fma_f32 v116, v8, v6, v116
	v_fma_f32 v117, v9, v6, v117
	v_fma_f32 v118, v10, v6, v118
	v_fma_f32 v119, v11, v6, v119
	v_mul_f32_dpp v4, v23, v46 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[80:87], 0
	s_add_u32 s76, s73, s24
	s_addc_u32 s77, 0, s77
	s_nop 5
	v_fma_f32 v140, v12, v6, v140
	v_fma_f32 v141, v13, v6, v141
	v_fma_f32 v142, v14, v6, v142
	v_fma_f32 v143, v15, v6, v143
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[80:87], 0
	ds_read_b128 a[32:35], v2 offset:2048
	ds_read_b128 a[36:39], v2 offset:2112
	s_add_u32 s52, 0x180, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s57, s57, 0
	s_cselect_b32 s6, s6, 0
	s_nop 5
	v_fma_f32 v120, v8, v4, v120
	v_fma_f32 v121, v9, v4, v121
	v_fma_f32 v122, v10, v4, v122
	v_fma_f32 v123, v11, v4, v123
	v_mul_f32_dpp v6, v23, v47 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[112:119], a[88:95], 0
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	s_nop 5
	v_fma_f32 v144, v12, v4, v144
	v_fma_f32 v145, v13, v4, v145
	v_fma_f32 v146, v14, v4, v146
	v_fma_f32 v147, v15, v4, v147
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[120:127], a[88:95], 0
	ds_read_b128 a[40:43], v2 offset:2560
	ds_read_b128 a[44:47], v2 offset:2624
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_nop 5
	v_fma_f32 v124, v8, v6, v124
	v_fma_f32 v125, v9, v6, v125
	v_fma_f32 v126, v10, v6, v126
	v_fma_f32 v127, v11, v6, v127
	s_nop 5
	v_fma_f32 v148, v12, v6, v148
	v_fma_f32 v149, v13, v6, v149
	v_fma_f32 v150, v14, v6, v150
	v_fma_f32 v151, v15, v6, v151
	s_addk_i32 s70, 0x80
	s_cmp_lt_i32 s70, s71
	s_cbranch_scc0 label_10F3
	s_branch label_0DCA

0000000000006cc0 <label_10F3>:
	s_cmp_eq_u32 s74, 0
	s_cbranch_scc0 label_141D
	v_cvt_pk_bf16_f32 v56, v56, v57
	v_cvt_pk_bf16_f32 v57, v58, v59
	v_cvt_pk_bf16_f32 v58, v60, v61
	v_cvt_pk_bf16_f32 v59, v62, v63
	v_cvt_pk_bf16_f32 v60, v64, v65
	v_cvt_pk_bf16_f32 v61, v66, v67
	v_cvt_pk_bf16_f32 v62, v68, v69
	v_cvt_pk_bf16_f32 v63, v70, v71
	v_cvt_pk_bf16_f32 v64, v72, v73
	v_cvt_pk_bf16_f32 v65, v74, v75
	v_cvt_pk_bf16_f32 v66, v76, v77
	v_cvt_pk_bf16_f32 v67, v78, v79
	v_cvt_pk_bf16_f32 v68, v80, v81
	v_cvt_pk_bf16_f32 v69, v82, v83
	v_cvt_pk_bf16_f32 v70, v84, v85
	v_cvt_pk_bf16_f32 v71, v86, v87
	v_cvt_pk_bf16_f32 v72, v88, v89
	v_cvt_pk_bf16_f32 v73, v90, v91
	v_cvt_pk_bf16_f32 v74, v92, v93
	v_cvt_pk_bf16_f32 v75, v94, v95
	v_cvt_pk_bf16_f32 v76, v96, v97
	v_cvt_pk_bf16_f32 v77, v98, v99
	v_cvt_pk_bf16_f32 v78, v100, v101
	v_cvt_pk_bf16_f32 v79, v102, v103
	ds_write_b64 v16, v[56:57]
	ds_write_b64 v16, v[58:59] offset:4352
	ds_write_b64 v16, v[60:61] offset:8704
	ds_write_b64 v16, v[62:63] offset:13056
	ds_write_b64 v16, v[64:65] offset:17408
	ds_write_b64 v16, v[66:67] offset:21760
	ds_write_b64 v16, v[68:69] offset:2176
	ds_write_b64 v16, v[70:71] offset:6528
	ds_write_b64 v16, v[72:73] offset:10880
	ds_write_b64 v16, v[74:75] offset:15232
	ds_write_b64 v16, v[76:77] offset:19584
	ds_write_b64 v16, v[78:79] offset:23936
	v_cvt_pk_bf16_f32 v104, v104, v105
	v_cvt_pk_bf16_f32 v105, v106, v107
	v_cvt_pk_bf16_f32 v106, v108, v109
	v_cvt_pk_bf16_f32 v107, v110, v111
	v_cvt_pk_bf16_f32 v108, v112, v113
	v_cvt_pk_bf16_f32 v109, v114, v115
	v_cvt_pk_bf16_f32 v110, v116, v117
	v_cvt_pk_bf16_f32 v111, v118, v119
	v_cvt_pk_bf16_f32 v112, v120, v121
	v_cvt_pk_bf16_f32 v113, v122, v123
	v_cvt_pk_bf16_f32 v114, v124, v125
	v_cvt_pk_bf16_f32 v115, v126, v127
	v_cvt_pk_bf16_f32 v116, v128, v129
	v_cvt_pk_bf16_f32 v117, v130, v131
	v_cvt_pk_bf16_f32 v118, v132, v133
	v_cvt_pk_bf16_f32 v119, v134, v135
	v_cvt_pk_bf16_f32 v120, v136, v137
	v_cvt_pk_bf16_f32 v121, v138, v139
	v_cvt_pk_bf16_f32 v122, v140, v141
	v_cvt_pk_bf16_f32 v123, v142, v143
	v_cvt_pk_bf16_f32 v124, v144, v145
	v_cvt_pk_bf16_f32 v125, v146, v147
	v_cvt_pk_bf16_f32 v126, v148, v149
	v_cvt_pk_bf16_f32 v127, v150, v151
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
	v_add_u32_e32 v80, v6, v7
	v_readlane_b32 s72, v3, 2
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 3
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v81, v6, v7
	v_readlane_b32 s72, v3, 4
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 5
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v82, v6, v7
	v_readlane_b32 s72, v3, 6
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 7
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v83, v6, v7
	v_readlane_b32 s72, v3, 8
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 9
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v84, v6, v7
	v_readlane_b32 s72, v3, 10
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 11
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v85, v6, v7
	v_readlane_b32 s72, v3, 12
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 13
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v86, v6, v7
	v_readlane_b32 s72, v3, 14
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 15
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v87, v6, v7
	v_readlane_b32 s72, v3, 16
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 17
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v88, v6, v7
	v_readlane_b32 s72, v3, 18
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 19
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v89, v6, v7
	v_readlane_b32 s72, v3, 20
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 21
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v90, v6, v7
	v_readlane_b32 s72, v3, 22
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 23
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v91, v6, v7
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 2, 4
	v_mul_lo_u32 v4, v4, s53
	v_and_b32_e64 v5, v0, 1
	v_add_u32_e32 v4, v4, v5
	v_lshlrev_b32_e32 v4, 2, v4
	v_add_u32_e32 v80, v80, v4
	v_add_u32_e32 v81, v81, v4
	v_add_u32_e32 v82, v82, v4
	v_add_u32_e32 v83, v83, v4
	v_add_u32_e32 v84, v84, v4
	v_add_u32_e32 v85, v85, v4
	v_add_u32_e32 v86, v86, v4
	v_add_u32_e32 v87, v87, v4
	v_add_u32_e32 v88, v88, v4
	v_add_u32_e32 v89, v89, v4
	v_add_u32_e32 v90, v90, v4
	v_add_u32_e32 v91, v91, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v56, v17
	ds_read_b32 v57, v17 offset:64
	ds_read_b32 v58, v17 offset:2176
	ds_read_b32 v59, v17 offset:2240
	ds_read_b32 v60, v17 offset:4352
	ds_read_b32 v61, v17 offset:4416
	ds_read_b32 v62, v17 offset:6528
	ds_read_b32 v63, v17 offset:6592
	ds_read_b32 v64, v17 offset:8704
	ds_read_b32 v65, v17 offset:8768
	ds_read_b32 v66, v17 offset:10880
	ds_read_b32 v67, v17 offset:10944
	ds_read_b32 v68, v17 offset:13056
	ds_read_b32 v69, v17 offset:13120
	ds_read_b32 v70, v17 offset:15232
	ds_read_b32 v71, v17 offset:15296
	ds_read_b32 v72, v17 offset:17408
	ds_read_b32 v73, v17 offset:17472
	ds_read_b32 v74, v17 offset:19584
	ds_read_b32 v75, v17 offset:19648
	ds_read_b32 v76, v17 offset:21760
	ds_read_b32 v77, v17 offset:21824
	ds_read_b32 v78, v17 offset:23936
	ds_read_b32 v79, v17 offset:24000
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_or_b32 s9, s9, 0x40000
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v80
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v56, v6, s[8:11], 0 offen
	buffer_store_dword v58, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v81
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v57, v6, s[8:11], 0 offen
	buffer_store_dword v59, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v82
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v60, v6, s[8:11], 0 offen
	buffer_store_dword v62, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v83
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v61, v6, s[8:11], 0 offen
	buffer_store_dword v63, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v84
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v64, v6, s[8:11], 0 offen
	buffer_store_dword v66, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v85
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v65, v6, s[8:11], 0 offen
	buffer_store_dword v67, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v86
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v68, v6, s[8:11], 0 offen
	buffer_store_dword v70, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v87
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v69, v6, s[8:11], 0 offen
	buffer_store_dword v71, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v88
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v72, v6, s[8:11], 0 offen
	buffer_store_dword v74, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v89
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v73, v6, s[8:11], 0 offen
	buffer_store_dword v75, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v90
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v76, v6, s[8:11], 0 offen
	buffer_store_dword v78, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v91
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v77, v6, s[8:11], 0 offen
	buffer_store_dword v79, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_write_b64 v16, v[104:105]
	ds_write_b64 v16, v[106:107] offset:4352
	ds_write_b64 v16, v[108:109] offset:8704
	ds_write_b64 v16, v[110:111] offset:13056
	ds_write_b64 v16, v[112:113] offset:17408
	ds_write_b64 v16, v[114:115] offset:21760
	ds_write_b64 v16, v[116:117] offset:2176
	ds_write_b64 v16, v[118:119] offset:6528
	ds_write_b64 v16, v[120:121] offset:10880
	ds_write_b64 v16, v[122:123] offset:15232
	ds_write_b64 v16, v[124:125] offset:19584
	ds_write_b64 v16, v[126:127] offset:23936
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v104, v17
	ds_read_b32 v105, v17 offset:64
	ds_read_b32 v106, v17 offset:2176
	ds_read_b32 v107, v17 offset:2240
	ds_read_b32 v108, v17 offset:4352
	ds_read_b32 v109, v17 offset:4416
	ds_read_b32 v110, v17 offset:6528
	ds_read_b32 v111, v17 offset:6592
	ds_read_b32 v112, v17 offset:8704
	ds_read_b32 v113, v17 offset:8768
	ds_read_b32 v114, v17 offset:10880
	ds_read_b32 v115, v17 offset:10944
	ds_read_b32 v116, v17 offset:13056
	ds_read_b32 v117, v17 offset:13120
	ds_read_b32 v118, v17 offset:15232
	ds_read_b32 v119, v17 offset:15296
	ds_read_b32 v120, v17 offset:17408
	ds_read_b32 v121, v17 offset:17472
	ds_read_b32 v122, v17 offset:19584
	ds_read_b32 v123, v17 offset:19648
	ds_read_b32 v124, v17 offset:21760
	ds_read_b32 v125, v17 offset:21824
	ds_read_b32 v126, v17 offset:23936
	ds_read_b32 v127, v17 offset:24000
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_add_u32 s8, 0x100, s8
	s_addc_u32 s9, 0, s9
	s_or_b32 s9, s9, 0x40000
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v80
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v104, v6, s[8:11], 0 offen
	buffer_store_dword v106, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v81
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v105, v6, s[8:11], 0 offen
	buffer_store_dword v107, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v82
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v108, v6, s[8:11], 0 offen
	buffer_store_dword v110, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v83
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v109, v6, s[8:11], 0 offen
	buffer_store_dword v111, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v84
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v112, v6, s[8:11], 0 offen
	buffer_store_dword v114, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v85
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v113, v6, s[8:11], 0 offen
	buffer_store_dword v115, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v86
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v116, v6, s[8:11], 0 offen
	buffer_store_dword v118, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v87
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v117, v6, s[8:11], 0 offen
	buffer_store_dword v119, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v88
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v120, v6, s[8:11], 0 offen
	buffer_store_dword v122, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v89
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v121, v6, s[8:11], 0 offen
	buffer_store_dword v123, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v90
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v124, v6, s[8:11], 0 offen
	buffer_store_dword v126, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v91
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v125, v6, s[8:11], 0 offen
	buffer_store_dword v127, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	s_branch label_18F7

0000000000007968 <label_141D>:
	ds_write_b64 v16, v[56:57]
	ds_write_b64 v16, v[60:61] offset:4352
	ds_write_b64 v16, v[64:65] offset:8704
	ds_write_b64 v16, v[68:69] offset:13056
	ds_write_b64 v16, v[72:73] offset:17408
	ds_write_b64 v16, v[76:77] offset:21760
	ds_write_b64 v16, v[80:81] offset:2176
	ds_write_b64 v16, v[84:85] offset:6528
	ds_write_b64 v16, v[88:89] offset:10880
	ds_write_b64 v16, v[92:93] offset:15232
	ds_write_b64 v16, v[96:97] offset:19584
	ds_write_b64 v16, v[100:101] offset:23936
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
	v_add_u32_e32 v80, v6, v7
	v_readlane_b32 s72, v3, 2
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 3
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v81, v6, v7
	v_readlane_b32 s72, v3, 4
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 5
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v82, v6, v7
	v_readlane_b32 s72, v3, 6
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 7
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v83, v6, v7
	v_readlane_b32 s72, v3, 8
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 9
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v84, v6, v7
	v_readlane_b32 s72, v3, 10
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 11
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v85, v6, v7
	v_readlane_b32 s72, v3, 12
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 13
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v86, v6, v7
	v_readlane_b32 s72, v3, 14
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 15
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v87, v6, v7
	v_readlane_b32 s72, v3, 16
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 17
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v88, v6, v7
	v_readlane_b32 s72, v3, 18
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 19
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v89, v6, v7
	v_readlane_b32 s72, v3, 20
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 21
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v90, v6, v7
	v_readlane_b32 s72, v3, 22
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 23
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v91, v6, v7
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 2, 4
	v_mul_lo_u32 v4, v4, s53
	v_and_b32_e64 v5, v0, 1
	v_add_u32_e32 v4, v4, v5
	v_lshlrev_b32_e32 v4, 2, v4
	v_add_u32_e32 v80, v80, v4
	v_add_u32_e32 v81, v81, v4
	v_add_u32_e32 v82, v82, v4
	v_add_u32_e32 v83, v83, v4
	v_add_u32_e32 v84, v84, v4
	v_add_u32_e32 v85, v85, v4
	v_add_u32_e32 v86, v86, v4
	v_add_u32_e32 v87, v87, v4
	v_add_u32_e32 v88, v88, v4
	v_add_u32_e32 v89, v89, v4
	v_add_u32_e32 v90, v90, v4
	v_add_u32_e32 v91, v91, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v56, v17
	ds_read_b32 v57, v17 offset:64
	ds_read_b32 v60, v17 offset:2176
	ds_read_b32 v61, v17 offset:2240
	ds_read_b32 v64, v17 offset:4352
	ds_read_b32 v65, v17 offset:4416
	ds_read_b32 v68, v17 offset:6528
	ds_read_b32 v69, v17 offset:6592
	ds_read_b32 v72, v17 offset:8704
	ds_read_b32 v73, v17 offset:8768
	ds_read_b32 v76, v17 offset:10880
	ds_read_b32 v77, v17 offset:10944
	ds_read_b32 v80, v17 offset:13056
	ds_read_b32 v81, v17 offset:13120
	ds_read_b32 v84, v17 offset:15232
	ds_read_b32 v85, v17 offset:15296
	ds_read_b32 v88, v17 offset:17408
	ds_read_b32 v89, v17 offset:17472
	ds_read_b32 v92, v17 offset:19584
	ds_read_b32 v93, v17 offset:19648
	ds_read_b32 v96, v17 offset:21760
	ds_read_b32 v97, v17 offset:21824
	ds_read_b32 v100, v17 offset:23936
	ds_read_b32 v101, v17 offset:24000
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v80
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v56, s[8:9]
	global_atomic_add_f32 v6, v60, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v81
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v57, s[8:9]
	global_atomic_add_f32 v6, v61, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v82
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v64, s[8:9]
	global_atomic_add_f32 v6, v68, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v83
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v65, s[8:9]
	global_atomic_add_f32 v6, v69, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v84
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v72, s[8:9]
	global_atomic_add_f32 v6, v76, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v85
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v73, s[8:9]
	global_atomic_add_f32 v6, v77, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v86
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v80, s[8:9]
	global_atomic_add_f32 v6, v84, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v87
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v81, s[8:9]
	global_atomic_add_f32 v6, v85, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v88
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v88, s[8:9]
	global_atomic_add_f32 v6, v92, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v89
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v89, s[8:9]
	global_atomic_add_f32 v6, v93, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v90
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v96, s[8:9]
	global_atomic_add_f32 v6, v100, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v91
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v97, s[8:9]
	global_atomic_add_f32 v6, v101, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[58:59]
	ds_write_b64 v16, v[62:63] offset:4352
	ds_write_b64 v16, v[66:67] offset:8704
	ds_write_b64 v16, v[70:71] offset:13056
	ds_write_b64 v16, v[74:75] offset:17408
	ds_write_b64 v16, v[78:79] offset:21760
	ds_write_b64 v16, v[82:83] offset:2176
	ds_write_b64 v16, v[86:87] offset:6528
	ds_write_b64 v16, v[90:91] offset:10880
	ds_write_b64 v16, v[94:95] offset:15232
	ds_write_b64 v16, v[98:99] offset:19584
	ds_write_b64 v16, v[102:103] offset:23936
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v58, v17
	ds_read_b32 v59, v17 offset:64
	ds_read_b32 v62, v17 offset:2176
	ds_read_b32 v63, v17 offset:2240
	ds_read_b32 v66, v17 offset:4352
	ds_read_b32 v67, v17 offset:4416
	ds_read_b32 v70, v17 offset:6528
	ds_read_b32 v71, v17 offset:6592
	ds_read_b32 v74, v17 offset:8704
	ds_read_b32 v75, v17 offset:8768
	ds_read_b32 v78, v17 offset:10880
	ds_read_b32 v79, v17 offset:10944
	ds_read_b32 v82, v17 offset:13056
	ds_read_b32 v83, v17 offset:13120
	ds_read_b32 v86, v17 offset:15232
	ds_read_b32 v87, v17 offset:15296
	ds_read_b32 v90, v17 offset:17408
	ds_read_b32 v91, v17 offset:17472
	ds_read_b32 v94, v17 offset:19584
	ds_read_b32 v95, v17 offset:19648
	ds_read_b32 v98, v17 offset:21760
	ds_read_b32 v99, v17 offset:21824
	ds_read_b32 v102, v17 offset:23936
	ds_read_b32 v103, v17 offset:24000
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v80
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v58, s[8:9] offset:8
	global_atomic_add_f32 v6, v62, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v81
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v59, s[8:9] offset:8
	global_atomic_add_f32 v6, v63, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v82
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v66, s[8:9] offset:8
	global_atomic_add_f32 v6, v70, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v83
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v67, s[8:9] offset:8
	global_atomic_add_f32 v6, v71, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v84
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v74, s[8:9] offset:8
	global_atomic_add_f32 v6, v78, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v85
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v75, s[8:9] offset:8
	global_atomic_add_f32 v6, v79, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v86
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v82, s[8:9] offset:8
	global_atomic_add_f32 v6, v86, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v87
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v83, s[8:9] offset:8
	global_atomic_add_f32 v6, v87, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v88
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v90, s[8:9] offset:8
	global_atomic_add_f32 v6, v94, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v89
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v91, s[8:9] offset:8
	global_atomic_add_f32 v6, v95, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v90
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v98, s[8:9] offset:8
	global_atomic_add_f32 v6, v102, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v91
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v99, s[8:9] offset:8
	global_atomic_add_f32 v6, v103, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[104:105]
	ds_write_b64 v16, v[108:109] offset:4352
	ds_write_b64 v16, v[112:113] offset:8704
	ds_write_b64 v16, v[116:117] offset:13056
	ds_write_b64 v16, v[120:121] offset:17408
	ds_write_b64 v16, v[124:125] offset:21760
	ds_write_b64 v16, v[128:129] offset:2176
	ds_write_b64 v16, v[132:133] offset:6528
	ds_write_b64 v16, v[136:137] offset:10880
	ds_write_b64 v16, v[140:141] offset:15232
	ds_write_b64 v16, v[144:145] offset:19584
	ds_write_b64 v16, v[148:149] offset:23936
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v104, v17
	ds_read_b32 v105, v17 offset:64
	ds_read_b32 v108, v17 offset:2176
	ds_read_b32 v109, v17 offset:2240
	ds_read_b32 v112, v17 offset:4352
	ds_read_b32 v113, v17 offset:4416
	ds_read_b32 v116, v17 offset:6528
	ds_read_b32 v117, v17 offset:6592
	ds_read_b32 v120, v17 offset:8704
	ds_read_b32 v121, v17 offset:8768
	ds_read_b32 v124, v17 offset:10880
	ds_read_b32 v125, v17 offset:10944
	ds_read_b32 v128, v17 offset:13056
	ds_read_b32 v129, v17 offset:13120
	ds_read_b32 v132, v17 offset:15232
	ds_read_b32 v133, v17 offset:15296
	ds_read_b32 v136, v17 offset:17408
	ds_read_b32 v137, v17 offset:17472
	ds_read_b32 v140, v17 offset:19584
	ds_read_b32 v141, v17 offset:19648
	ds_read_b32 v144, v17 offset:21760
	ds_read_b32 v145, v17 offset:21824
	ds_read_b32 v148, v17 offset:23936
	ds_read_b32 v149, v17 offset:24000
	s_mul_i32 s52, s61, 4
	s_add_u32 s8, s52, s8
	s_addc_u32 s9, 0, s9
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v80
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v104, s[8:9]
	global_atomic_add_f32 v6, v108, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v81
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v105, s[8:9]
	global_atomic_add_f32 v6, v109, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v82
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v112, s[8:9]
	global_atomic_add_f32 v6, v116, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v83
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v113, s[8:9]
	global_atomic_add_f32 v6, v117, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v84
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v120, s[8:9]
	global_atomic_add_f32 v6, v124, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v85
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v121, s[8:9]
	global_atomic_add_f32 v6, v125, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v86
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v128, s[8:9]
	global_atomic_add_f32 v6, v132, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v87
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v129, s[8:9]
	global_atomic_add_f32 v6, v133, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v88
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v136, s[8:9]
	global_atomic_add_f32 v6, v140, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v89
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v137, s[8:9]
	global_atomic_add_f32 v6, v141, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v90
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v144, s[8:9]
	global_atomic_add_f32 v6, v148, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v91
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v145, s[8:9]
	global_atomic_add_f32 v6, v149, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[106:107]
	ds_write_b64 v16, v[110:111] offset:4352
	ds_write_b64 v16, v[114:115] offset:8704
	ds_write_b64 v16, v[118:119] offset:13056
	ds_write_b64 v16, v[122:123] offset:17408
	ds_write_b64 v16, v[126:127] offset:21760
	ds_write_b64 v16, v[130:131] offset:2176
	ds_write_b64 v16, v[134:135] offset:6528
	ds_write_b64 v16, v[138:139] offset:10880
	ds_write_b64 v16, v[142:143] offset:15232
	ds_write_b64 v16, v[146:147] offset:19584
	ds_write_b64 v16, v[150:151] offset:23936
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v106, v17
	ds_read_b32 v107, v17 offset:64
	ds_read_b32 v110, v17 offset:2176
	ds_read_b32 v111, v17 offset:2240
	ds_read_b32 v114, v17 offset:4352
	ds_read_b32 v115, v17 offset:4416
	ds_read_b32 v118, v17 offset:6528
	ds_read_b32 v119, v17 offset:6592
	ds_read_b32 v122, v17 offset:8704
	ds_read_b32 v123, v17 offset:8768
	ds_read_b32 v126, v17 offset:10880
	ds_read_b32 v127, v17 offset:10944
	ds_read_b32 v130, v17 offset:13056
	ds_read_b32 v131, v17 offset:13120
	ds_read_b32 v134, v17 offset:15232
	ds_read_b32 v135, v17 offset:15296
	ds_read_b32 v138, v17 offset:17408
	ds_read_b32 v139, v17 offset:17472
	ds_read_b32 v142, v17 offset:19584
	ds_read_b32 v143, v17 offset:19648
	ds_read_b32 v146, v17 offset:21760
	ds_read_b32 v147, v17 offset:21824
	ds_read_b32 v150, v17 offset:23936
	ds_read_b32 v151, v17 offset:24000
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v80
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v106, s[8:9] offset:8
	global_atomic_add_f32 v6, v110, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v81
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v107, s[8:9] offset:8
	global_atomic_add_f32 v6, v111, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v82
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v114, s[8:9] offset:8
	global_atomic_add_f32 v6, v118, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v83
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v115, s[8:9] offset:8
	global_atomic_add_f32 v6, v119, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v84
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v122, s[8:9] offset:8
	global_atomic_add_f32 v6, v126, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v85
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v123, s[8:9] offset:8
	global_atomic_add_f32 v6, v127, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v86
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v130, s[8:9] offset:8
	global_atomic_add_f32 v6, v134, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v87
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v131, s[8:9] offset:8
	global_atomic_add_f32 v6, v135, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v88
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v138, s[8:9] offset:8
	global_atomic_add_f32 v6, v142, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v89
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v139, s[8:9] offset:8
	global_atomic_add_f32 v6, v143, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v90
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v146, s[8:9] offset:8
	global_atomic_add_f32 v6, v150, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v91
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v147, s[8:9] offset:8
	global_atomic_add_f32 v6, v151, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	s_branch label_18F7

0000000000008cd0 <label_18F7>:
	s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
	s_endpgm
