
/usr/local/lib/python3.12/dist-packages/aiter_meta/hsa/gfx950/f8_block_scale_mi350_x128.co:	file format elf64-amdgpu

Disassembly of section .text:

0000000000002900 <f8_block_scale_mi350_x128>:
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
	v_accvgpr_write_b32 a159, 0
	v_mov_b32_e32 v191, 0
	s_waitcnt lgkmcnt(0)
	s_mul_i32 s52, s3, 0x80
	s_cmp_lt_i32 s52, s46
	s_cbranch_scc0 label_2072
	s_mov_b32 s70, 0
	s_lshr_b32 s71, s60, s74
	s_mul_i32 s52, s3, 0x80
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
	v_add_u32_e64 v30, v4, s52
	v_add_u32_e32 v4, 16, v4
	v_add_u32_e64 v31, v4, s52
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
	v_mov_b32_e32 v62, v7
	v_mov_b32_e32 v64, 0
	v_mov_b32_e32 v128, 0
	v_mov_b32_e32 v65, 0
	v_mov_b32_e32 v129, 0
	v_mov_b32_e32 v66, 0
	v_mov_b32_e32 v130, 0
	v_mov_b32_e32 v67, 0
	v_mov_b32_e32 v131, 0
	v_mov_b32_e32 v68, 0
	v_mov_b32_e32 v132, 0
	v_mov_b32_e32 v69, 0
	v_mov_b32_e32 v133, 0
	v_mov_b32_e32 v70, 0
	v_mov_b32_e32 v134, 0
	v_mov_b32_e32 v71, 0
	v_mov_b32_e32 v135, 0
	v_mov_b32_e32 v72, 0
	v_mov_b32_e32 v136, 0
	v_mov_b32_e32 v73, 0
	v_mov_b32_e32 v137, 0
	v_mov_b32_e32 v74, 0
	v_mov_b32_e32 v138, 0
	v_mov_b32_e32 v75, 0
	v_mov_b32_e32 v139, 0
	v_mov_b32_e32 v76, 0
	v_mov_b32_e32 v140, 0
	v_mov_b32_e32 v77, 0
	v_mov_b32_e32 v141, 0
	v_mov_b32_e32 v78, 0
	v_mov_b32_e32 v142, 0
	v_mov_b32_e32 v79, 0
	v_mov_b32_e32 v143, 0
	v_mov_b32_e32 v80, 0
	v_mov_b32_e32 v144, 0
	v_mov_b32_e32 v81, 0
	v_mov_b32_e32 v145, 0
	v_mov_b32_e32 v82, 0
	v_mov_b32_e32 v146, 0
	v_mov_b32_e32 v83, 0
	v_mov_b32_e32 v147, 0
	v_mov_b32_e32 v84, 0
	v_mov_b32_e32 v148, 0
	v_mov_b32_e32 v85, 0
	v_mov_b32_e32 v149, 0
	v_mov_b32_e32 v86, 0
	v_mov_b32_e32 v150, 0
	v_mov_b32_e32 v87, 0
	v_mov_b32_e32 v151, 0
	v_mov_b32_e32 v88, 0
	v_mov_b32_e32 v152, 0
	v_mov_b32_e32 v89, 0
	v_mov_b32_e32 v153, 0
	v_mov_b32_e32 v90, 0
	v_mov_b32_e32 v154, 0
	v_mov_b32_e32 v91, 0
	v_mov_b32_e32 v155, 0
	v_mov_b32_e32 v92, 0
	v_mov_b32_e32 v156, 0
	v_mov_b32_e32 v93, 0
	v_mov_b32_e32 v157, 0
	v_mov_b32_e32 v94, 0
	v_mov_b32_e32 v158, 0
	v_mov_b32_e32 v95, 0
	v_mov_b32_e32 v159, 0
	v_mov_b32_e32 v96, 0
	v_mov_b32_e32 v160, 0
	v_mov_b32_e32 v97, 0
	v_mov_b32_e32 v161, 0
	v_mov_b32_e32 v98, 0
	v_mov_b32_e32 v162, 0
	v_mov_b32_e32 v99, 0
	v_mov_b32_e32 v163, 0
	v_mov_b32_e32 v100, 0
	v_mov_b32_e32 v164, 0
	v_mov_b32_e32 v101, 0
	v_mov_b32_e32 v165, 0
	v_mov_b32_e32 v102, 0
	v_mov_b32_e32 v166, 0
	v_mov_b32_e32 v103, 0
	v_mov_b32_e32 v167, 0
	v_mov_b32_e32 v104, 0
	v_mov_b32_e32 v168, 0
	v_mov_b32_e32 v105, 0
	v_mov_b32_e32 v169, 0
	v_mov_b32_e32 v106, 0
	v_mov_b32_e32 v170, 0
	v_mov_b32_e32 v107, 0
	v_mov_b32_e32 v171, 0
	v_mov_b32_e32 v108, 0
	v_mov_b32_e32 v172, 0
	v_mov_b32_e32 v109, 0
	v_mov_b32_e32 v173, 0
	v_mov_b32_e32 v110, 0
	v_mov_b32_e32 v174, 0
	v_mov_b32_e32 v111, 0
	v_mov_b32_e32 v175, 0
	v_mov_b32_e32 v112, 0
	v_mov_b32_e32 v176, 0
	v_mov_b32_e32 v113, 0
	v_mov_b32_e32 v177, 0
	v_mov_b32_e32 v114, 0
	v_mov_b32_e32 v178, 0
	v_mov_b32_e32 v115, 0
	v_mov_b32_e32 v179, 0
	v_mov_b32_e32 v116, 0
	v_mov_b32_e32 v180, 0
	v_mov_b32_e32 v117, 0
	v_mov_b32_e32 v181, 0
	v_mov_b32_e32 v118, 0
	v_mov_b32_e32 v182, 0
	v_mov_b32_e32 v119, 0
	v_mov_b32_e32 v183, 0
	v_mov_b32_e32 v120, 0
	v_mov_b32_e32 v184, 0
	v_mov_b32_e32 v121, 0
	v_mov_b32_e32 v185, 0
	v_mov_b32_e32 v122, 0
	v_mov_b32_e32 v186, 0
	v_mov_b32_e32 v123, 0
	v_mov_b32_e32 v187, 0
	v_mov_b32_e32 v124, 0
	v_mov_b32_e32 v188, 0
	v_mov_b32_e32 v125, 0
	v_mov_b32_e32 v189, 0
	v_mov_b32_e32 v126, 0
	v_mov_b32_e32 v190, 0
	v_mov_b32_e32 v127, 0
	v_mov_b32_e32 v191, 0
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
	s_mul_i32 s52, s7, 0x1020
	s_add_u32 s46, 0, s52
	s_add_u32 s47, 0x4080, s46
	v_and_b32_e32 v4, 15, v0
	v_lshrrev_b32_e32 v5, 3, v4
	v_mul_i32_i24_e32 v5, 2, v5
	v_and_b32_e32 v4, 3, v0
	v_lshrrev_b32_e32 v6, 1, v4
	v_add_u32_e32 v4, v5, v6
	v_mul_i32_i24_e32 v2, 0x1020, v4
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
	v_lshlrev_b32_e32 v60, 4, v0
	v_add_u32_e32 v60, s52, v60
	s_mul_i32 s52, 64, s65
	v_add_u32_e32 v61, s52, v60
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
	v_readlane_b32 s72, v62, 0
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 0
	s_mov_b32 s17, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v56, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 1
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v56, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 2
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v56, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 3
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v56, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 4
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 0
	s_mov_b32 s16, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v56, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 5
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v56, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 6
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v56, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 7
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v56, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 8
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 0
	s_mov_b32 s17, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v57, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 9
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v57, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 10
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v57, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 11
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v57, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 12
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 0
	s_mov_b32 s16, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v57, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 13
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v57, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 14
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v57, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 15
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v57, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 16
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 0
	s_mov_b32 s17, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v58, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 17
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v58, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 18
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v58, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 19
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v58, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 20
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 0
	s_mov_b32 s16, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v58, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 21
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v58, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 22
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v58, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 23
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v58, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 24
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 0
	s_mov_b32 s17, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v59, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 25
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v59, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 26
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v59, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 27
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s16, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v59, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 28
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 0
	s_mov_b32 s16, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v59, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 29
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 8
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v59, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 30
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 16
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v59, s52
	s_mov_b64 exec, s[54:55]
	v_readlane_b32 s72, v62, 31
	s_mul_i32 s52, s72, s64
	s_lshl_b32 s17, 0xff, 24
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v59, s52
	s_mov_b64 exec, s[54:55]
	v_and_b32_e64 v4, v0, 7
	v_lshlrev_b32_e32 v4, 4, v4
	v_add_u32_e32 v56, v56, v4
	v_add_u32_e32 v57, v57, v4
	v_add_u32_e32 v58, v58, v4
	v_add_u32_e32 v59, v59, v4
	v_lshlrev_b32_e32 v24, 2, v24
	v_lshlrev_b32_e32 v25, 2, v25
	v_lshlrev_b32_e32 v26, 2, v26
	v_lshlrev_b32_e32 v27, 2, v27
	v_lshlrev_b32_e32 v28, 2, v28
	v_lshlrev_b32_e32 v29, 2, v29
	v_lshlrev_b32_e32 v30, 2, v30
	v_lshlrev_b32_e32 v31, 2, v31
	s_lshl_b32 s6, s62, 2
	buffer_load_dwordx4 v56, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s46
	buffer_load_dwordx4 v57, s[20:23], 0 offen lds
	s_add_u32 m0, 0x800, s46
	buffer_load_dwordx4 v58, s[20:23], 0 offen lds
	s_add_u32 m0, 0xc00, s46
	buffer_load_dwordx4 v59, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s47
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	buffer_load_dword v32, v24, s[28:31], 0 offen
	buffer_load_dword v33, v25, s[28:31], 0 offen
	buffer_load_dword v34, v26, s[28:31], 0 offen
	buffer_load_dword v35, v27, s[28:31], 0 offen
	buffer_load_dword v36, v28, s[28:31], 0 offen
	buffer_load_dword v37, v29, s[28:31], 0 offen
	buffer_load_dword v38, v30, s[28:31], 0 offen
	buffer_load_dword v39, v31, s[28:31], 0 offen
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	buffer_load_dwordx4 v56, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s47
	buffer_load_dwordx4 v57, s[20:23], 0 offen lds
	s_add_u32 m0, 0x800, s47
	buffer_load_dwordx4 v58, s[20:23], 0 offen lds
	s_add_u32 m0, 0xc00, s47
	buffer_load_dwordx4 v59, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s46
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	buffer_load_dword v40, v24, s[28:31], 0 offen
	buffer_load_dword v41, v25, s[28:31], 0 offen
	buffer_load_dword v42, v26, s[28:31], 0 offen
	buffer_load_dword v43, v27, s[28:31], 0 offen
	buffer_load_dword v44, v28, s[28:31], 0 offen
	buffer_load_dword v45, v29, s[28:31], 0 offen
	buffer_load_dword v46, v30, s[28:31], 0 offen
	buffer_load_dword v47, v31, s[28:31], 0 offen
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	buffer_load_dword v20, v18, s[32:35], 0 offen
	buffer_load_dwordx4 a[128:131], v60, s[24:27], 0 offen
	buffer_load_dwordx4 a[132:135], v60, s[24:27], 0 offen offset:1024
	buffer_load_dwordx4 a[136:139], v61, s[24:27], 0 offen
	buffer_load_dwordx4 a[140:143], v61, s[24:27], 0 offen offset:1024
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_waitcnt vmcnt(25)
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
	ds_read_b128 a[48:51], v2 offset:3072
	ds_read_b128 a[52:55], v2 offset:3136
	ds_read_b128 a[56:59], v2 offset:3584
	ds_read_b128 a[60:63], v2 offset:3648
	s_cmp_lt_i32 s7, 2
	s_cbranch_scc0 label_11C9

0000000000003574 <label_031D>:
	s_waitcnt vmcnt(2) lgkmcnt(0)
	s_barrier
	v_mov_b32_e32 v48, v32
	v_mov_b32_e32 v49, v33
	v_mov_b32_e32 v50, v34
	v_mov_b32_e32 v51, v35
	v_mov_b32_e32 v52, v36
	v_mov_b32_e32 v53, v37
	v_mov_b32_e32 v54, v38
	v_mov_b32_e32 v55, v39
	v_mul_f32_dpp v4, v20, v48 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[128:135], a[0:7], 0
	buffer_load_dword v23, v19, s[32:35], 0 offen
	v_mul_f32_dpp v6, v20, v49 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[128:135], a[8:15], 0
	buffer_load_dwordx4 a[144:147], v60, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v64, v8, v4, v64
	v_fma_f32 v65, v9, v4, v65
	v_fma_f32 v66, v10, v4, v66
	v_fma_f32 v67, v11, v4, v67
	v_mul_f32_dpp v4, v20, v50 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[128:135], a[16:23], 0
	s_nop 5
	v_fma_f32 v68, v12, v6, v68
	v_fma_f32 v69, v13, v6, v69
	v_fma_f32 v70, v14, v6, v70
	v_fma_f32 v71, v15, v6, v71
	v_mul_f32_dpp v6, v20, v51 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[128:135], a[24:31], 0
	buffer_load_dwordx4 a[148:151], v60, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v72, v8, v4, v72
	v_fma_f32 v73, v9, v4, v73
	v_fma_f32 v74, v10, v4, v74
	v_fma_f32 v75, v11, v4, v75
	v_mul_f32_dpp v4, v20, v52 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[128:135], a[32:39], 0
	s_nop 5
	v_fma_f32 v76, v12, v6, v76
	v_fma_f32 v77, v13, v6, v77
	v_fma_f32 v78, v14, v6, v78
	v_fma_f32 v79, v15, v6, v79
	v_mul_f32_dpp v6, v20, v53 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[128:135], a[40:47], 0
	buffer_load_dwordx4 a[152:155], v61, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v80, v8, v4, v80
	v_fma_f32 v81, v9, v4, v81
	v_fma_f32 v82, v10, v4, v82
	v_fma_f32 v83, v11, v4, v83
	v_mul_f32_dpp v4, v20, v54 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[128:135], a[48:55], 0
	s_nop 5
	v_fma_f32 v84, v12, v6, v84
	v_fma_f32 v85, v13, v6, v85
	v_fma_f32 v86, v14, v6, v86
	v_fma_f32 v87, v15, v6, v87
	v_mul_f32_dpp v6, v20, v55 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[128:135], a[56:63], 0
	buffer_load_dwordx4 a[156:159], v61, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v88, v8, v4, v88
	v_fma_f32 v89, v9, v4, v89
	v_fma_f32 v90, v10, v4, v90
	v_fma_f32 v91, v11, v4, v91
	s_waitcnt vmcnt(5)
	v_mul_f32_dpp v4, v20, v48 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[136:143], a[0:7], 0
	s_nop 5
	v_fma_f32 v92, v12, v6, v92
	v_fma_f32 v93, v13, v6, v93
	v_fma_f32 v94, v14, v6, v94
	v_fma_f32 v95, v15, v6, v95
	v_mul_f32_dpp v6, v20, v49 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[136:143], a[8:15], 0
	buffer_load_dwordx4 v56, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s46
	s_nop 5
	v_fma_f32 v96, v8, v4, v96
	v_fma_f32 v97, v9, v4, v97
	v_fma_f32 v98, v10, v4, v98
	v_fma_f32 v99, v11, v4, v99
	v_mul_f32_dpp v4, v20, v50 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[136:143], a[16:23], 0
	s_nop 5
	v_fma_f32 v100, v12, v6, v100
	v_fma_f32 v101, v13, v6, v101
	v_fma_f32 v102, v14, v6, v102
	v_fma_f32 v103, v15, v6, v103
	v_mul_f32_dpp v6, v20, v51 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[136:143], a[24:31], 0
	buffer_load_dwordx4 v57, s[20:23], 0 offen lds
	s_add_u32 m0, 0x800, s46
	s_nop 5
	v_fma_f32 v104, v8, v4, v104
	v_fma_f32 v105, v9, v4, v105
	v_fma_f32 v106, v10, v4, v106
	v_fma_f32 v107, v11, v4, v107
	v_mul_f32_dpp v4, v20, v52 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[136:143], a[32:39], 0
	s_nop 5
	v_fma_f32 v108, v12, v6, v108
	v_fma_f32 v109, v13, v6, v109
	v_fma_f32 v110, v14, v6, v110
	v_fma_f32 v111, v15, v6, v111
	v_mul_f32_dpp v6, v20, v53 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[136:143], a[40:47], 0
	buffer_load_dwordx4 v58, s[20:23], 0 offen lds
	s_add_u32 m0, 0xc00, s46
	s_nop 5
	v_fma_f32 v112, v8, v4, v112
	v_fma_f32 v113, v9, v4, v113
	v_fma_f32 v114, v10, v4, v114
	v_fma_f32 v115, v11, v4, v115
	v_mul_f32_dpp v4, v20, v54 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[136:143], a[48:55], 0
	s_add_u32 s52, 0x80, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s73, s73, 0
	s_cselect_b32 s4, s4, 0
	s_nop 5
	v_fma_f32 v116, v12, v6, v116
	v_fma_f32 v117, v13, v6, v117
	v_fma_f32 v118, v14, v6, v118
	v_fma_f32 v119, v15, v6, v119
	v_mul_f32_dpp v6, v20, v55 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[136:143], a[56:63], 0
	buffer_load_dwordx4 v59, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s47
	s_add_u32 s32, s4, s32
	s_addc_u32 s33, 0, s33
	s_nop 5
	v_fma_f32 v120, v8, v4, v120
	v_fma_f32 v121, v9, v4, v121
	v_fma_f32 v122, v10, v4, v122
	v_fma_f32 v123, v11, v4, v123
	s_nop 5
	v_fma_f32 v124, v12, v6, v124
	v_fma_f32 v125, v13, v6, v125
	v_fma_f32 v126, v14, v6, v126
	v_fma_f32 v127, v15, v6, v127
	buffer_load_dword v32, v24, s[28:31], 0 offen
	buffer_load_dword v33, v25, s[28:31], 0 offen
	buffer_load_dword v34, v26, s[28:31], 0 offen
	buffer_load_dword v35, v27, s[28:31], 0 offen
	buffer_load_dword v36, v28, s[28:31], 0 offen
	buffer_load_dword v37, v29, s[28:31], 0 offen
	buffer_load_dword v38, v30, s[28:31], 0 offen
	buffer_load_dword v39, v31, s[28:31], 0 offen
	s_waitcnt vmcnt(12)
	v_mul_f32_dpp v4, v23, v48 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[0:7], 0
	buffer_load_dword v20, v18, s[32:35], 0 offen
	ds_read_b128 a[64:67], v2 offset:16512
	ds_read_b128 a[68:71], v2 offset:16576
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[0:7], 0
	buffer_load_dwordx4 a[128:131], v60, s[24:27], 0 offen
	s_nop 5
	v_fma_f32 v128, v8, v4, v128
	v_fma_f32 v129, v9, v4, v129
	v_fma_f32 v130, v10, v4, v130
	v_fma_f32 v131, v11, v4, v131
	v_mul_f32_dpp v6, v23, v49 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[8:15], 0
	ds_read_b128 a[72:75], v2 offset:17024
	ds_read_b128 a[76:79], v2 offset:17088
	s_nop 5
	v_fma_f32 v160, v12, v4, v160
	v_fma_f32 v161, v13, v4, v161
	v_fma_f32 v162, v14, v4, v162
	v_fma_f32 v163, v15, v4, v163
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[8:15], 0
	buffer_load_dwordx4 a[132:135], v60, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v132, v8, v6, v132
	v_fma_f32 v133, v9, v6, v133
	v_fma_f32 v134, v10, v6, v134
	v_fma_f32 v135, v11, v6, v135
	v_mul_f32_dpp v4, v23, v50 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[16:23], 0
	ds_read_b128 a[80:83], v2 offset:17536
	ds_read_b128 a[84:87], v2 offset:17600
	s_nop 5
	v_fma_f32 v164, v12, v6, v164
	v_fma_f32 v165, v13, v6, v165
	v_fma_f32 v166, v14, v6, v166
	v_fma_f32 v167, v15, v6, v167
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[16:23], 0
	buffer_load_dwordx4 a[136:139], v61, s[24:27], 0 offen
	s_nop 5
	v_fma_f32 v136, v8, v4, v136
	v_fma_f32 v137, v9, v4, v137
	v_fma_f32 v138, v10, v4, v138
	v_fma_f32 v139, v11, v4, v139
	v_mul_f32_dpp v6, v23, v51 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[24:31], 0
	ds_read_b128 a[88:91], v2 offset:18048
	ds_read_b128 a[92:95], v2 offset:18112
	s_nop 5
	v_fma_f32 v168, v12, v4, v168
	v_fma_f32 v169, v13, v4, v169
	v_fma_f32 v170, v14, v4, v170
	v_fma_f32 v171, v15, v4, v171
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[24:31], 0
	buffer_load_dwordx4 a[140:143], v61, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v140, v8, v6, v140
	v_fma_f32 v141, v9, v6, v141
	v_fma_f32 v142, v10, v6, v142
	v_fma_f32 v143, v11, v6, v143
	v_mul_f32_dpp v4, v23, v52 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[32:39], 0
	ds_read_b128 a[96:99], v2 offset:18560
	ds_read_b128 a[100:103], v2 offset:18624
	s_nop 5
	v_fma_f32 v172, v12, v6, v172
	v_fma_f32 v173, v13, v6, v173
	v_fma_f32 v174, v14, v6, v174
	v_fma_f32 v175, v15, v6, v175
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[32:39], 0
	s_nop 5
	v_fma_f32 v144, v8, v4, v144
	v_fma_f32 v145, v9, v4, v145
	v_fma_f32 v146, v10, v4, v146
	v_fma_f32 v147, v11, v4, v147
	v_mul_f32_dpp v6, v23, v53 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[40:47], 0
	ds_read_b128 a[104:107], v2 offset:19072
	ds_read_b128 a[108:111], v2 offset:19136
	s_nop 5
	v_fma_f32 v176, v12, v4, v176
	v_fma_f32 v177, v13, v4, v177
	v_fma_f32 v178, v14, v4, v178
	v_fma_f32 v179, v15, v4, v179
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[40:47], 0
	s_add_u32 s52, 0x100, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s58, s58, 0
	s_nop 5
	v_fma_f32 v148, v8, v6, v148
	v_fma_f32 v149, v9, v6, v149
	v_fma_f32 v150, v10, v6, v150
	v_fma_f32 v151, v11, v6, v151
	v_mul_f32_dpp v4, v23, v54 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[48:55], 0
	ds_read_b128 a[112:115], v2 offset:19584
	ds_read_b128 a[116:119], v2 offset:19648
	s_add_u32 s76, s73, s24
	s_addc_u32 s77, 0, s77
	s_nop 5
	v_fma_f32 v180, v12, v6, v180
	v_fma_f32 v181, v13, v6, v181
	v_fma_f32 v182, v14, v6, v182
	v_fma_f32 v183, v15, v6, v183
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[48:55], 0
	s_add_u32 s52, 0x180, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s57, s57, 0
	s_cselect_b32 s6, s6, 0
	s_nop 5
	v_fma_f32 v152, v8, v4, v152
	v_fma_f32 v153, v9, v4, v153
	v_fma_f32 v154, v10, v4, v154
	v_fma_f32 v155, v11, v4, v155
	v_mul_f32_dpp v6, v23, v55 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[56:63], 0
	ds_read_b128 a[120:123], v2 offset:20096
	ds_read_b128 a[124:127], v2 offset:20160
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	s_nop 5
	v_fma_f32 v184, v12, v4, v184
	v_fma_f32 v185, v13, v4, v185
	v_fma_f32 v186, v14, v4, v186
	v_fma_f32 v187, v15, v4, v187
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[56:63], 0
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_nop 5
	v_fma_f32 v156, v8, v6, v156
	v_fma_f32 v157, v9, v6, v157
	v_fma_f32 v158, v10, v6, v158
	v_fma_f32 v159, v11, v6, v159
	s_nop 5
	v_fma_f32 v188, v12, v6, v188
	v_fma_f32 v189, v13, v6, v189
	v_fma_f32 v190, v14, v6, v190
	v_fma_f32 v191, v15, v6, v191
	s_addk_i32 s70, 0x80
	s_cmp_lt_i32 s70, s71
	s_cbranch_scc0 label_0732
	s_waitcnt vmcnt(2) lgkmcnt(0)
	s_barrier
	v_mov_b32_e32 v48, v40
	v_mov_b32_e32 v49, v41
	v_mov_b32_e32 v50, v42
	v_mov_b32_e32 v51, v43
	v_mov_b32_e32 v52, v44
	v_mov_b32_e32 v53, v45
	v_mov_b32_e32 v54, v46
	v_mov_b32_e32 v55, v47
	v_mul_f32_dpp v4, v20, v48 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[128:135], a[64:71], 0
	buffer_load_dword v23, v19, s[32:35], 0 offen
	v_mul_f32_dpp v6, v20, v49 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[128:135], a[72:79], 0
	buffer_load_dwordx4 a[144:147], v60, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v64, v8, v4, v64
	v_fma_f32 v65, v9, v4, v65
	v_fma_f32 v66, v10, v4, v66
	v_fma_f32 v67, v11, v4, v67
	v_mul_f32_dpp v4, v20, v50 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[128:135], a[80:87], 0
	s_nop 5
	v_fma_f32 v68, v12, v6, v68
	v_fma_f32 v69, v13, v6, v69
	v_fma_f32 v70, v14, v6, v70
	v_fma_f32 v71, v15, v6, v71
	v_mul_f32_dpp v6, v20, v51 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[128:135], a[88:95], 0
	buffer_load_dwordx4 a[148:151], v60, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v72, v8, v4, v72
	v_fma_f32 v73, v9, v4, v73
	v_fma_f32 v74, v10, v4, v74
	v_fma_f32 v75, v11, v4, v75
	v_mul_f32_dpp v4, v20, v52 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[128:135], a[96:103], 0
	s_nop 5
	v_fma_f32 v76, v12, v6, v76
	v_fma_f32 v77, v13, v6, v77
	v_fma_f32 v78, v14, v6, v78
	v_fma_f32 v79, v15, v6, v79
	v_mul_f32_dpp v6, v20, v53 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[128:135], a[104:111], 0
	buffer_load_dwordx4 a[152:155], v61, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v80, v8, v4, v80
	v_fma_f32 v81, v9, v4, v81
	v_fma_f32 v82, v10, v4, v82
	v_fma_f32 v83, v11, v4, v83
	v_mul_f32_dpp v4, v20, v54 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[128:135], a[112:119], 0
	s_nop 5
	v_fma_f32 v84, v12, v6, v84
	v_fma_f32 v85, v13, v6, v85
	v_fma_f32 v86, v14, v6, v86
	v_fma_f32 v87, v15, v6, v87
	v_mul_f32_dpp v6, v20, v55 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[128:135], a[120:127], 0
	buffer_load_dwordx4 a[156:159], v61, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v88, v8, v4, v88
	v_fma_f32 v89, v9, v4, v89
	v_fma_f32 v90, v10, v4, v90
	v_fma_f32 v91, v11, v4, v91
	s_waitcnt vmcnt(5)
	v_mul_f32_dpp v4, v20, v48 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[136:143], a[64:71], 0
	s_nop 5
	v_fma_f32 v92, v12, v6, v92
	v_fma_f32 v93, v13, v6, v93
	v_fma_f32 v94, v14, v6, v94
	v_fma_f32 v95, v15, v6, v95
	v_mul_f32_dpp v6, v20, v49 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[136:143], a[72:79], 0
	buffer_load_dwordx4 v56, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s47
	s_nop 5
	v_fma_f32 v96, v8, v4, v96
	v_fma_f32 v97, v9, v4, v97
	v_fma_f32 v98, v10, v4, v98
	v_fma_f32 v99, v11, v4, v99
	v_mul_f32_dpp v4, v20, v50 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[136:143], a[80:87], 0
	s_nop 5
	v_fma_f32 v100, v12, v6, v100
	v_fma_f32 v101, v13, v6, v101
	v_fma_f32 v102, v14, v6, v102
	v_fma_f32 v103, v15, v6, v103
	v_mul_f32_dpp v6, v20, v51 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[136:143], a[88:95], 0
	buffer_load_dwordx4 v57, s[20:23], 0 offen lds
	s_add_u32 m0, 0x800, s47
	s_nop 5
	v_fma_f32 v104, v8, v4, v104
	v_fma_f32 v105, v9, v4, v105
	v_fma_f32 v106, v10, v4, v106
	v_fma_f32 v107, v11, v4, v107
	v_mul_f32_dpp v4, v20, v52 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[136:143], a[96:103], 0
	s_nop 5
	v_fma_f32 v108, v12, v6, v108
	v_fma_f32 v109, v13, v6, v109
	v_fma_f32 v110, v14, v6, v110
	v_fma_f32 v111, v15, v6, v111
	v_mul_f32_dpp v6, v20, v53 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[136:143], a[104:111], 0
	buffer_load_dwordx4 v58, s[20:23], 0 offen lds
	s_add_u32 m0, 0xc00, s47
	s_nop 5
	v_fma_f32 v112, v8, v4, v112
	v_fma_f32 v113, v9, v4, v113
	v_fma_f32 v114, v10, v4, v114
	v_fma_f32 v115, v11, v4, v115
	v_mul_f32_dpp v4, v20, v54 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[136:143], a[112:119], 0
	s_add_u32 s52, 0x80, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s73, s73, 0
	s_cselect_b32 s4, s4, 0
	s_nop 5
	v_fma_f32 v116, v12, v6, v116
	v_fma_f32 v117, v13, v6, v117
	v_fma_f32 v118, v14, v6, v118
	v_fma_f32 v119, v15, v6, v119
	v_mul_f32_dpp v6, v20, v55 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[136:143], a[120:127], 0
	buffer_load_dwordx4 v59, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s46
	s_add_u32 s32, s4, s32
	s_addc_u32 s33, 0, s33
	s_nop 5
	v_fma_f32 v120, v8, v4, v120
	v_fma_f32 v121, v9, v4, v121
	v_fma_f32 v122, v10, v4, v122
	v_fma_f32 v123, v11, v4, v123
	s_nop 5
	v_fma_f32 v124, v12, v6, v124
	v_fma_f32 v125, v13, v6, v125
	v_fma_f32 v126, v14, v6, v126
	v_fma_f32 v127, v15, v6, v127
	buffer_load_dword v40, v24, s[28:31], 0 offen
	buffer_load_dword v41, v25, s[28:31], 0 offen
	buffer_load_dword v42, v26, s[28:31], 0 offen
	buffer_load_dword v43, v27, s[28:31], 0 offen
	buffer_load_dword v44, v28, s[28:31], 0 offen
	buffer_load_dword v45, v29, s[28:31], 0 offen
	buffer_load_dword v46, v30, s[28:31], 0 offen
	buffer_load_dword v47, v31, s[28:31], 0 offen
	s_waitcnt vmcnt(12)
	v_mul_f32_dpp v4, v23, v48 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[64:71], 0
	buffer_load_dword v20, v18, s[32:35], 0 offen
	ds_read_b128 a[0:3], v2
	ds_read_b128 a[4:7], v2 offset:64
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[64:71], 0
	buffer_load_dwordx4 a[128:131], v60, s[24:27], 0 offen
	s_nop 5
	v_fma_f32 v128, v8, v4, v128
	v_fma_f32 v129, v9, v4, v129
	v_fma_f32 v130, v10, v4, v130
	v_fma_f32 v131, v11, v4, v131
	v_mul_f32_dpp v6, v23, v49 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[72:79], 0
	ds_read_b128 a[8:11], v2 offset:512
	ds_read_b128 a[12:15], v2 offset:576
	s_nop 5
	v_fma_f32 v160, v12, v4, v160
	v_fma_f32 v161, v13, v4, v161
	v_fma_f32 v162, v14, v4, v162
	v_fma_f32 v163, v15, v4, v163
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[72:79], 0
	buffer_load_dwordx4 a[132:135], v60, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v132, v8, v6, v132
	v_fma_f32 v133, v9, v6, v133
	v_fma_f32 v134, v10, v6, v134
	v_fma_f32 v135, v11, v6, v135
	v_mul_f32_dpp v4, v23, v50 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[80:87], 0
	ds_read_b128 a[16:19], v2 offset:1024
	ds_read_b128 a[20:23], v2 offset:1088
	s_nop 5
	v_fma_f32 v164, v12, v6, v164
	v_fma_f32 v165, v13, v6, v165
	v_fma_f32 v166, v14, v6, v166
	v_fma_f32 v167, v15, v6, v167
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[80:87], 0
	buffer_load_dwordx4 a[136:139], v61, s[24:27], 0 offen
	s_nop 5
	v_fma_f32 v136, v8, v4, v136
	v_fma_f32 v137, v9, v4, v137
	v_fma_f32 v138, v10, v4, v138
	v_fma_f32 v139, v11, v4, v139
	v_mul_f32_dpp v6, v23, v51 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[88:95], 0
	ds_read_b128 a[24:27], v2 offset:1536
	ds_read_b128 a[28:31], v2 offset:1600
	s_nop 5
	v_fma_f32 v168, v12, v4, v168
	v_fma_f32 v169, v13, v4, v169
	v_fma_f32 v170, v14, v4, v170
	v_fma_f32 v171, v15, v4, v171
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[88:95], 0
	buffer_load_dwordx4 a[140:143], v61, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v140, v8, v6, v140
	v_fma_f32 v141, v9, v6, v141
	v_fma_f32 v142, v10, v6, v142
	v_fma_f32 v143, v11, v6, v143
	v_mul_f32_dpp v4, v23, v52 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[96:103], 0
	ds_read_b128 a[32:35], v2 offset:2048
	ds_read_b128 a[36:39], v2 offset:2112
	s_nop 5
	v_fma_f32 v172, v12, v6, v172
	v_fma_f32 v173, v13, v6, v173
	v_fma_f32 v174, v14, v6, v174
	v_fma_f32 v175, v15, v6, v175
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[96:103], 0
	s_nop 5
	v_fma_f32 v144, v8, v4, v144
	v_fma_f32 v145, v9, v4, v145
	v_fma_f32 v146, v10, v4, v146
	v_fma_f32 v147, v11, v4, v147
	v_mul_f32_dpp v6, v23, v53 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[104:111], 0
	ds_read_b128 a[40:43], v2 offset:2560
	ds_read_b128 a[44:47], v2 offset:2624
	s_nop 5
	v_fma_f32 v176, v12, v4, v176
	v_fma_f32 v177, v13, v4, v177
	v_fma_f32 v178, v14, v4, v178
	v_fma_f32 v179, v15, v4, v179
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[104:111], 0
	s_add_u32 s52, 0x100, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s58, s58, 0
	s_nop 5
	v_fma_f32 v148, v8, v6, v148
	v_fma_f32 v149, v9, v6, v149
	v_fma_f32 v150, v10, v6, v150
	v_fma_f32 v151, v11, v6, v151
	v_mul_f32_dpp v4, v23, v54 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[112:119], 0
	ds_read_b128 a[48:51], v2 offset:3072
	ds_read_b128 a[52:55], v2 offset:3136
	s_add_u32 s76, s73, s24
	s_addc_u32 s77, 0, s77
	s_nop 5
	v_fma_f32 v180, v12, v6, v180
	v_fma_f32 v181, v13, v6, v181
	v_fma_f32 v182, v14, v6, v182
	v_fma_f32 v183, v15, v6, v183
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[112:119], 0
	s_add_u32 s52, 0x180, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s57, s57, 0
	s_cselect_b32 s6, s6, 0
	s_nop 5
	v_fma_f32 v152, v8, v4, v152
	v_fma_f32 v153, v9, v4, v153
	v_fma_f32 v154, v10, v4, v154
	v_fma_f32 v155, v11, v4, v155
	v_mul_f32_dpp v6, v23, v55 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[120:127], 0
	ds_read_b128 a[56:59], v2 offset:3584
	ds_read_b128 a[60:63], v2 offset:3648
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	s_nop 5
	v_fma_f32 v184, v12, v4, v184
	v_fma_f32 v185, v13, v4, v185
	v_fma_f32 v186, v14, v4, v186
	v_fma_f32 v187, v15, v4, v187
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[120:127], 0
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_nop 5
	v_fma_f32 v156, v8, v6, v156
	v_fma_f32 v157, v9, v6, v157
	v_fma_f32 v158, v10, v6, v158
	v_fma_f32 v159, v11, v6, v159
	s_nop 5
	v_fma_f32 v188, v12, v6, v188
	v_fma_f32 v189, v13, v6, v189
	v_fma_f32 v190, v14, v6, v190
	v_fma_f32 v191, v15, v6, v191
	s_addk_i32 s70, 0x80
	s_cmp_lt_i32 s70, s71
	s_cbranch_scc0 label_0732
	s_branch label_031D

00000000000045c8 <label_0732>:
	s_cmp_eq_u32 s74, 0
	s_cbranch_scc0 label_0B5C
	v_cvt_pk_bf16_f32 v64, v64, v65
	v_cvt_pk_bf16_f32 v65, v66, v67
	v_cvt_pk_bf16_f32 v66, v68, v69
	v_cvt_pk_bf16_f32 v67, v70, v71
	v_cvt_pk_bf16_f32 v68, v72, v73
	v_cvt_pk_bf16_f32 v69, v74, v75
	v_cvt_pk_bf16_f32 v70, v76, v77
	v_cvt_pk_bf16_f32 v71, v78, v79
	v_cvt_pk_bf16_f32 v72, v80, v81
	v_cvt_pk_bf16_f32 v73, v82, v83
	v_cvt_pk_bf16_f32 v74, v84, v85
	v_cvt_pk_bf16_f32 v75, v86, v87
	v_cvt_pk_bf16_f32 v76, v88, v89
	v_cvt_pk_bf16_f32 v77, v90, v91
	v_cvt_pk_bf16_f32 v78, v92, v93
	v_cvt_pk_bf16_f32 v79, v94, v95
	v_cvt_pk_bf16_f32 v80, v96, v97
	v_cvt_pk_bf16_f32 v81, v98, v99
	v_cvt_pk_bf16_f32 v82, v100, v101
	v_cvt_pk_bf16_f32 v83, v102, v103
	v_cvt_pk_bf16_f32 v84, v104, v105
	v_cvt_pk_bf16_f32 v85, v106, v107
	v_cvt_pk_bf16_f32 v86, v108, v109
	v_cvt_pk_bf16_f32 v87, v110, v111
	v_cvt_pk_bf16_f32 v88, v112, v113
	v_cvt_pk_bf16_f32 v89, v114, v115
	v_cvt_pk_bf16_f32 v90, v116, v117
	v_cvt_pk_bf16_f32 v91, v118, v119
	v_cvt_pk_bf16_f32 v92, v120, v121
	v_cvt_pk_bf16_f32 v93, v122, v123
	v_cvt_pk_bf16_f32 v94, v124, v125
	v_cvt_pk_bf16_f32 v95, v126, v127
	ds_write_b64 v16, v[64:65]
	ds_write_b64 v16, v[66:67] offset:4352
	ds_write_b64 v16, v[68:69] offset:8704
	ds_write_b64 v16, v[70:71] offset:13056
	ds_write_b64 v16, v[72:73] offset:17408
	ds_write_b64 v16, v[74:75] offset:21760
	ds_write_b64 v16, v[76:77] offset:26112
	ds_write_b64 v16, v[78:79] offset:30464
	ds_write_b64 v16, v[80:81] offset:2176
	ds_write_b64 v16, v[82:83] offset:6528
	ds_write_b64 v16, v[84:85] offset:10880
	ds_write_b64 v16, v[86:87] offset:15232
	ds_write_b64 v16, v[88:89] offset:19584
	ds_write_b64 v16, v[90:91] offset:23936
	ds_write_b64 v16, v[92:93] offset:28288
	ds_write_b64 v16, v[94:95] offset:32640
	v_cvt_pk_bf16_f32 v128, v128, v129
	v_cvt_pk_bf16_f32 v129, v130, v131
	v_cvt_pk_bf16_f32 v130, v132, v133
	v_cvt_pk_bf16_f32 v131, v134, v135
	v_cvt_pk_bf16_f32 v132, v136, v137
	v_cvt_pk_bf16_f32 v133, v138, v139
	v_cvt_pk_bf16_f32 v134, v140, v141
	v_cvt_pk_bf16_f32 v135, v142, v143
	v_cvt_pk_bf16_f32 v136, v144, v145
	v_cvt_pk_bf16_f32 v137, v146, v147
	v_cvt_pk_bf16_f32 v138, v148, v149
	v_cvt_pk_bf16_f32 v139, v150, v151
	v_cvt_pk_bf16_f32 v140, v152, v153
	v_cvt_pk_bf16_f32 v141, v154, v155
	v_cvt_pk_bf16_f32 v142, v156, v157
	v_cvt_pk_bf16_f32 v143, v158, v159
	v_cvt_pk_bf16_f32 v144, v160, v161
	v_cvt_pk_bf16_f32 v145, v162, v163
	v_cvt_pk_bf16_f32 v146, v164, v165
	v_cvt_pk_bf16_f32 v147, v166, v167
	v_cvt_pk_bf16_f32 v148, v168, v169
	v_cvt_pk_bf16_f32 v149, v170, v171
	v_cvt_pk_bf16_f32 v150, v172, v173
	v_cvt_pk_bf16_f32 v151, v174, v175
	v_cvt_pk_bf16_f32 v152, v176, v177
	v_cvt_pk_bf16_f32 v153, v178, v179
	v_cvt_pk_bf16_f32 v154, v180, v181
	v_cvt_pk_bf16_f32 v155, v182, v183
	v_cvt_pk_bf16_f32 v156, v184, v185
	v_cvt_pk_bf16_f32 v157, v186, v187
	v_cvt_pk_bf16_f32 v158, v188, v189
	v_cvt_pk_bf16_f32 v159, v190, v191
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
	v_add_u32_e32 v96, v6, v7
	v_readlane_b32 s72, v3, 2
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 3
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v97, v6, v7
	v_readlane_b32 s72, v3, 4
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 5
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v98, v6, v7
	v_readlane_b32 s72, v3, 6
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 7
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v99, v6, v7
	v_readlane_b32 s72, v3, 8
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 9
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v100, v6, v7
	v_readlane_b32 s72, v3, 10
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 11
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v101, v6, v7
	v_readlane_b32 s72, v3, 12
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 13
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v102, v6, v7
	v_readlane_b32 s72, v3, 14
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 15
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v103, v6, v7
	v_readlane_b32 s72, v3, 16
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 17
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v104, v6, v7
	v_readlane_b32 s72, v3, 18
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 19
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v105, v6, v7
	v_readlane_b32 s72, v3, 20
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 21
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v106, v6, v7
	v_readlane_b32 s72, v3, 22
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 23
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v107, v6, v7
	v_readlane_b32 s72, v3, 24
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 25
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v108, v6, v7
	v_readlane_b32 s72, v3, 26
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 27
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v109, v6, v7
	v_readlane_b32 s72, v3, 28
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 29
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v110, v6, v7
	v_readlane_b32 s72, v3, 30
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 31
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v111, v6, v7
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 2, 4
	v_mul_lo_u32 v4, v4, s53
	v_and_b32_e64 v5, v0, 1
	v_add_u32_e32 v4, v4, v5
	v_lshlrev_b32_e32 v4, 2, v4
	v_add_u32_e32 v96, v96, v4
	v_add_u32_e32 v97, v97, v4
	v_add_u32_e32 v98, v98, v4
	v_add_u32_e32 v99, v99, v4
	v_add_u32_e32 v100, v100, v4
	v_add_u32_e32 v101, v101, v4
	v_add_u32_e32 v102, v102, v4
	v_add_u32_e32 v103, v103, v4
	v_add_u32_e32 v104, v104, v4
	v_add_u32_e32 v105, v105, v4
	v_add_u32_e32 v106, v106, v4
	v_add_u32_e32 v107, v107, v4
	v_add_u32_e32 v108, v108, v4
	v_add_u32_e32 v109, v109, v4
	v_add_u32_e32 v110, v110, v4
	v_add_u32_e32 v111, v111, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v64, v17
	ds_read_b32 v65, v17 offset:64
	ds_read_b32 v66, v17 offset:2176
	ds_read_b32 v67, v17 offset:2240
	ds_read_b32 v68, v17 offset:4352
	ds_read_b32 v69, v17 offset:4416
	ds_read_b32 v70, v17 offset:6528
	ds_read_b32 v71, v17 offset:6592
	ds_read_b32 v72, v17 offset:8704
	ds_read_b32 v73, v17 offset:8768
	ds_read_b32 v74, v17 offset:10880
	ds_read_b32 v75, v17 offset:10944
	ds_read_b32 v76, v17 offset:13056
	ds_read_b32 v77, v17 offset:13120
	ds_read_b32 v78, v17 offset:15232
	ds_read_b32 v79, v17 offset:15296
	ds_read_b32 v80, v17 offset:17408
	ds_read_b32 v81, v17 offset:17472
	ds_read_b32 v82, v17 offset:19584
	ds_read_b32 v83, v17 offset:19648
	ds_read_b32 v84, v17 offset:21760
	ds_read_b32 v85, v17 offset:21824
	ds_read_b32 v86, v17 offset:23936
	ds_read_b32 v87, v17 offset:24000
	ds_read_b32 v88, v17 offset:26112
	ds_read_b32 v89, v17 offset:26176
	ds_read_b32 v90, v17 offset:28288
	ds_read_b32 v91, v17 offset:28352
	ds_read_b32 v92, v17 offset:30464
	ds_read_b32 v93, v17 offset:30528
	ds_read_b32 v94, v17 offset:32640
	ds_read_b32 v95, v17 offset:32704
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_or_b32 s9, s9, 0x40000
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v96
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v64, v6, s[8:11], 0 offen
	buffer_store_dword v66, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v97
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v65, v6, s[8:11], 0 offen
	buffer_store_dword v67, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v98
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v68, v6, s[8:11], 0 offen
	buffer_store_dword v70, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v99
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v69, v6, s[8:11], 0 offen
	buffer_store_dword v71, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v100
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v72, v6, s[8:11], 0 offen
	buffer_store_dword v74, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v101
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v73, v6, s[8:11], 0 offen
	buffer_store_dword v75, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v102
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v76, v6, s[8:11], 0 offen
	buffer_store_dword v78, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v103
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v77, v6, s[8:11], 0 offen
	buffer_store_dword v79, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v104
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v80, v6, s[8:11], 0 offen
	buffer_store_dword v82, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v105
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v81, v6, s[8:11], 0 offen
	buffer_store_dword v83, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v106
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v84, v6, s[8:11], 0 offen
	buffer_store_dword v86, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v107
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v85, v6, s[8:11], 0 offen
	buffer_store_dword v87, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v108
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 24
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 25
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v88, v6, s[8:11], 0 offen
	buffer_store_dword v90, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v109
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 26
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 27
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v89, v6, s[8:11], 0 offen
	buffer_store_dword v91, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v110
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 28
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 29
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v92, v6, s[8:11], 0 offen
	buffer_store_dword v94, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v111
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 30
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 31
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v93, v6, s[8:11], 0 offen
	buffer_store_dword v95, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_write_b64 v16, v[128:129]
	ds_write_b64 v16, v[130:131] offset:4352
	ds_write_b64 v16, v[132:133] offset:8704
	ds_write_b64 v16, v[134:135] offset:13056
	ds_write_b64 v16, v[136:137] offset:17408
	ds_write_b64 v16, v[138:139] offset:21760
	ds_write_b64 v16, v[140:141] offset:26112
	ds_write_b64 v16, v[142:143] offset:30464
	ds_write_b64 v16, v[144:145] offset:2176
	ds_write_b64 v16, v[146:147] offset:6528
	ds_write_b64 v16, v[148:149] offset:10880
	ds_write_b64 v16, v[150:151] offset:15232
	ds_write_b64 v16, v[152:153] offset:19584
	ds_write_b64 v16, v[154:155] offset:23936
	ds_write_b64 v16, v[156:157] offset:28288
	ds_write_b64 v16, v[158:159] offset:32640
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v128, v17
	ds_read_b32 v129, v17 offset:64
	ds_read_b32 v130, v17 offset:2176
	ds_read_b32 v131, v17 offset:2240
	ds_read_b32 v132, v17 offset:4352
	ds_read_b32 v133, v17 offset:4416
	ds_read_b32 v134, v17 offset:6528
	ds_read_b32 v135, v17 offset:6592
	ds_read_b32 v136, v17 offset:8704
	ds_read_b32 v137, v17 offset:8768
	ds_read_b32 v138, v17 offset:10880
	ds_read_b32 v139, v17 offset:10944
	ds_read_b32 v140, v17 offset:13056
	ds_read_b32 v141, v17 offset:13120
	ds_read_b32 v142, v17 offset:15232
	ds_read_b32 v143, v17 offset:15296
	ds_read_b32 v144, v17 offset:17408
	ds_read_b32 v145, v17 offset:17472
	ds_read_b32 v146, v17 offset:19584
	ds_read_b32 v147, v17 offset:19648
	ds_read_b32 v148, v17 offset:21760
	ds_read_b32 v149, v17 offset:21824
	ds_read_b32 v150, v17 offset:23936
	ds_read_b32 v151, v17 offset:24000
	ds_read_b32 v152, v17 offset:26112
	ds_read_b32 v153, v17 offset:26176
	ds_read_b32 v154, v17 offset:28288
	ds_read_b32 v155, v17 offset:28352
	ds_read_b32 v156, v17 offset:30464
	ds_read_b32 v157, v17 offset:30528
	ds_read_b32 v158, v17 offset:32640
	ds_read_b32 v159, v17 offset:32704
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_add_u32 s8, 0x100, s8
	s_addc_u32 s9, 0, s9
	s_or_b32 s9, s9, 0x40000
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v96
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v128, v6, s[8:11], 0 offen
	buffer_store_dword v130, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v97
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v129, v6, s[8:11], 0 offen
	buffer_store_dword v131, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v98
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v132, v6, s[8:11], 0 offen
	buffer_store_dword v134, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v99
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v133, v6, s[8:11], 0 offen
	buffer_store_dword v135, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v100
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v136, v6, s[8:11], 0 offen
	buffer_store_dword v138, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v101
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v137, v6, s[8:11], 0 offen
	buffer_store_dword v139, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v102
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v140, v6, s[8:11], 0 offen
	buffer_store_dword v142, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v103
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v141, v6, s[8:11], 0 offen
	buffer_store_dword v143, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v104
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v144, v6, s[8:11], 0 offen
	buffer_store_dword v146, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v105
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v145, v6, s[8:11], 0 offen
	buffer_store_dword v147, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v106
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v148, v6, s[8:11], 0 offen
	buffer_store_dword v150, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v107
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v149, v6, s[8:11], 0 offen
	buffer_store_dword v151, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v108
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 24
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 25
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v152, v6, s[8:11], 0 offen
	buffer_store_dword v154, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v109
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 26
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 27
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v153, v6, s[8:11], 0 offen
	buffer_store_dword v155, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v110
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 28
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 29
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v156, v6, s[8:11], 0 offen
	buffer_store_dword v158, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v111
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 30
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 31
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v157, v6, s[8:11], 0 offen
	buffer_store_dword v159, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	s_branch label_2072

0000000000005670 <label_0B5C>:
	ds_write_b64 v16, v[64:65]
	ds_write_b64 v16, v[68:69] offset:4352
	ds_write_b64 v16, v[72:73] offset:8704
	ds_write_b64 v16, v[76:77] offset:13056
	ds_write_b64 v16, v[80:81] offset:17408
	ds_write_b64 v16, v[84:85] offset:21760
	ds_write_b64 v16, v[88:89] offset:26112
	ds_write_b64 v16, v[92:93] offset:30464
	ds_write_b64 v16, v[96:97] offset:2176
	ds_write_b64 v16, v[100:101] offset:6528
	ds_write_b64 v16, v[104:105] offset:10880
	ds_write_b64 v16, v[108:109] offset:15232
	ds_write_b64 v16, v[112:113] offset:19584
	ds_write_b64 v16, v[116:117] offset:23936
	ds_write_b64 v16, v[120:121] offset:28288
	ds_write_b64 v16, v[124:125] offset:32640
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
	v_add_u32_e32 v96, v6, v7
	v_readlane_b32 s72, v3, 2
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 3
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v97, v6, v7
	v_readlane_b32 s72, v3, 4
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 5
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v98, v6, v7
	v_readlane_b32 s72, v3, 6
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 7
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v99, v6, v7
	v_readlane_b32 s72, v3, 8
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 9
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v100, v6, v7
	v_readlane_b32 s72, v3, 10
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 11
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v101, v6, v7
	v_readlane_b32 s72, v3, 12
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 13
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v102, v6, v7
	v_readlane_b32 s72, v3, 14
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 15
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v103, v6, v7
	v_readlane_b32 s72, v3, 16
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 17
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v104, v6, v7
	v_readlane_b32 s72, v3, 18
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 19
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v105, v6, v7
	v_readlane_b32 s72, v3, 20
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 21
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v106, v6, v7
	v_readlane_b32 s72, v3, 22
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 23
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v107, v6, v7
	v_readlane_b32 s72, v3, 24
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 25
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v108, v6, v7
	v_readlane_b32 s72, v3, 26
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 27
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v109, v6, v7
	v_readlane_b32 s72, v3, 28
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 29
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v110, v6, v7
	v_readlane_b32 s72, v3, 30
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 31
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v111, v6, v7
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 2, 4
	v_mul_lo_u32 v4, v4, s53
	v_and_b32_e64 v5, v0, 1
	v_add_u32_e32 v4, v4, v5
	v_lshlrev_b32_e32 v4, 2, v4
	v_add_u32_e32 v96, v96, v4
	v_add_u32_e32 v97, v97, v4
	v_add_u32_e32 v98, v98, v4
	v_add_u32_e32 v99, v99, v4
	v_add_u32_e32 v100, v100, v4
	v_add_u32_e32 v101, v101, v4
	v_add_u32_e32 v102, v102, v4
	v_add_u32_e32 v103, v103, v4
	v_add_u32_e32 v104, v104, v4
	v_add_u32_e32 v105, v105, v4
	v_add_u32_e32 v106, v106, v4
	v_add_u32_e32 v107, v107, v4
	v_add_u32_e32 v108, v108, v4
	v_add_u32_e32 v109, v109, v4
	v_add_u32_e32 v110, v110, v4
	v_add_u32_e32 v111, v111, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v64, v17
	ds_read_b32 v65, v17 offset:64
	ds_read_b32 v68, v17 offset:2176
	ds_read_b32 v69, v17 offset:2240
	ds_read_b32 v72, v17 offset:4352
	ds_read_b32 v73, v17 offset:4416
	ds_read_b32 v76, v17 offset:6528
	ds_read_b32 v77, v17 offset:6592
	ds_read_b32 v80, v17 offset:8704
	ds_read_b32 v81, v17 offset:8768
	ds_read_b32 v84, v17 offset:10880
	ds_read_b32 v85, v17 offset:10944
	ds_read_b32 v88, v17 offset:13056
	ds_read_b32 v89, v17 offset:13120
	ds_read_b32 v92, v17 offset:15232
	ds_read_b32 v93, v17 offset:15296
	ds_read_b32 v96, v17 offset:17408
	ds_read_b32 v97, v17 offset:17472
	ds_read_b32 v100, v17 offset:19584
	ds_read_b32 v101, v17 offset:19648
	ds_read_b32 v104, v17 offset:21760
	ds_read_b32 v105, v17 offset:21824
	ds_read_b32 v108, v17 offset:23936
	ds_read_b32 v109, v17 offset:24000
	ds_read_b32 v112, v17 offset:26112
	ds_read_b32 v113, v17 offset:26176
	ds_read_b32 v116, v17 offset:28288
	ds_read_b32 v117, v17 offset:28352
	ds_read_b32 v120, v17 offset:30464
	ds_read_b32 v121, v17 offset:30528
	ds_read_b32 v124, v17 offset:32640
	ds_read_b32 v125, v17 offset:32704
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v96
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v64, s[8:9]
	global_atomic_add_f32 v6, v68, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v97
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v65, s[8:9]
	global_atomic_add_f32 v6, v69, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v98
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v72, s[8:9]
	global_atomic_add_f32 v6, v76, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v99
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v73, s[8:9]
	global_atomic_add_f32 v6, v77, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v100
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v80, s[8:9]
	global_atomic_add_f32 v6, v84, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v101
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v81, s[8:9]
	global_atomic_add_f32 v6, v85, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v102
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v88, s[8:9]
	global_atomic_add_f32 v6, v92, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v103
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v89, s[8:9]
	global_atomic_add_f32 v6, v93, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v104
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v96, s[8:9]
	global_atomic_add_f32 v6, v100, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v105
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v97, s[8:9]
	global_atomic_add_f32 v6, v101, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v106
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v104, s[8:9]
	global_atomic_add_f32 v6, v108, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v107
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v105, s[8:9]
	global_atomic_add_f32 v6, v109, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v108
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 24
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 25
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v112, s[8:9]
	global_atomic_add_f32 v6, v116, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v109
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 26
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 27
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v113, s[8:9]
	global_atomic_add_f32 v6, v117, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v110
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 28
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 29
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v120, s[8:9]
	global_atomic_add_f32 v6, v124, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v111
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 30
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 31
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v121, s[8:9]
	global_atomic_add_f32 v6, v125, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[66:67]
	ds_write_b64 v16, v[70:71] offset:4352
	ds_write_b64 v16, v[74:75] offset:8704
	ds_write_b64 v16, v[78:79] offset:13056
	ds_write_b64 v16, v[82:83] offset:17408
	ds_write_b64 v16, v[86:87] offset:21760
	ds_write_b64 v16, v[90:91] offset:26112
	ds_write_b64 v16, v[94:95] offset:30464
	ds_write_b64 v16, v[98:99] offset:2176
	ds_write_b64 v16, v[102:103] offset:6528
	ds_write_b64 v16, v[106:107] offset:10880
	ds_write_b64 v16, v[110:111] offset:15232
	ds_write_b64 v16, v[114:115] offset:19584
	ds_write_b64 v16, v[118:119] offset:23936
	ds_write_b64 v16, v[122:123] offset:28288
	ds_write_b64 v16, v[126:127] offset:32640
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v66, v17
	ds_read_b32 v67, v17 offset:64
	ds_read_b32 v70, v17 offset:2176
	ds_read_b32 v71, v17 offset:2240
	ds_read_b32 v74, v17 offset:4352
	ds_read_b32 v75, v17 offset:4416
	ds_read_b32 v78, v17 offset:6528
	ds_read_b32 v79, v17 offset:6592
	ds_read_b32 v82, v17 offset:8704
	ds_read_b32 v83, v17 offset:8768
	ds_read_b32 v86, v17 offset:10880
	ds_read_b32 v87, v17 offset:10944
	ds_read_b32 v90, v17 offset:13056
	ds_read_b32 v91, v17 offset:13120
	ds_read_b32 v94, v17 offset:15232
	ds_read_b32 v95, v17 offset:15296
	ds_read_b32 v98, v17 offset:17408
	ds_read_b32 v99, v17 offset:17472
	ds_read_b32 v102, v17 offset:19584
	ds_read_b32 v103, v17 offset:19648
	ds_read_b32 v106, v17 offset:21760
	ds_read_b32 v107, v17 offset:21824
	ds_read_b32 v110, v17 offset:23936
	ds_read_b32 v111, v17 offset:24000
	ds_read_b32 v114, v17 offset:26112
	ds_read_b32 v115, v17 offset:26176
	ds_read_b32 v118, v17 offset:28288
	ds_read_b32 v119, v17 offset:28352
	ds_read_b32 v122, v17 offset:30464
	ds_read_b32 v123, v17 offset:30528
	ds_read_b32 v126, v17 offset:32640
	ds_read_b32 v127, v17 offset:32704
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v96
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v66, s[8:9] offset:8
	global_atomic_add_f32 v6, v70, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v97
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v67, s[8:9] offset:8
	global_atomic_add_f32 v6, v71, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v98
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v74, s[8:9] offset:8
	global_atomic_add_f32 v6, v78, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v99
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v75, s[8:9] offset:8
	global_atomic_add_f32 v6, v79, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v100
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v82, s[8:9] offset:8
	global_atomic_add_f32 v6, v86, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v101
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v83, s[8:9] offset:8
	global_atomic_add_f32 v6, v87, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v102
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v90, s[8:9] offset:8
	global_atomic_add_f32 v6, v94, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v103
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v91, s[8:9] offset:8
	global_atomic_add_f32 v6, v95, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v104
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v98, s[8:9] offset:8
	global_atomic_add_f32 v6, v102, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v105
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v99, s[8:9] offset:8
	global_atomic_add_f32 v6, v103, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v106
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v106, s[8:9] offset:8
	global_atomic_add_f32 v6, v110, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v107
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v107, s[8:9] offset:8
	global_atomic_add_f32 v6, v111, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v108
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 24
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 25
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v114, s[8:9] offset:8
	global_atomic_add_f32 v6, v118, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v109
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 26
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 27
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v115, s[8:9] offset:8
	global_atomic_add_f32 v6, v119, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v110
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 28
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 29
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v122, s[8:9] offset:8
	global_atomic_add_f32 v6, v126, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v111
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 30
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 31
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v123, s[8:9] offset:8
	global_atomic_add_f32 v6, v127, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[128:129]
	ds_write_b64 v16, v[132:133] offset:4352
	ds_write_b64 v16, v[136:137] offset:8704
	ds_write_b64 v16, v[140:141] offset:13056
	ds_write_b64 v16, v[144:145] offset:17408
	ds_write_b64 v16, v[148:149] offset:21760
	ds_write_b64 v16, v[152:153] offset:26112
	ds_write_b64 v16, v[156:157] offset:30464
	ds_write_b64 v16, v[160:161] offset:2176
	ds_write_b64 v16, v[164:165] offset:6528
	ds_write_b64 v16, v[168:169] offset:10880
	ds_write_b64 v16, v[172:173] offset:15232
	ds_write_b64 v16, v[176:177] offset:19584
	ds_write_b64 v16, v[180:181] offset:23936
	ds_write_b64 v16, v[184:185] offset:28288
	ds_write_b64 v16, v[188:189] offset:32640
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v128, v17
	ds_read_b32 v129, v17 offset:64
	ds_read_b32 v132, v17 offset:2176
	ds_read_b32 v133, v17 offset:2240
	ds_read_b32 v136, v17 offset:4352
	ds_read_b32 v137, v17 offset:4416
	ds_read_b32 v140, v17 offset:6528
	ds_read_b32 v141, v17 offset:6592
	ds_read_b32 v144, v17 offset:8704
	ds_read_b32 v145, v17 offset:8768
	ds_read_b32 v148, v17 offset:10880
	ds_read_b32 v149, v17 offset:10944
	ds_read_b32 v152, v17 offset:13056
	ds_read_b32 v153, v17 offset:13120
	ds_read_b32 v156, v17 offset:15232
	ds_read_b32 v157, v17 offset:15296
	ds_read_b32 v160, v17 offset:17408
	ds_read_b32 v161, v17 offset:17472
	ds_read_b32 v164, v17 offset:19584
	ds_read_b32 v165, v17 offset:19648
	ds_read_b32 v168, v17 offset:21760
	ds_read_b32 v169, v17 offset:21824
	ds_read_b32 v172, v17 offset:23936
	ds_read_b32 v173, v17 offset:24000
	ds_read_b32 v176, v17 offset:26112
	ds_read_b32 v177, v17 offset:26176
	ds_read_b32 v180, v17 offset:28288
	ds_read_b32 v181, v17 offset:28352
	ds_read_b32 v184, v17 offset:30464
	ds_read_b32 v185, v17 offset:30528
	ds_read_b32 v188, v17 offset:32640
	ds_read_b32 v189, v17 offset:32704
	s_mul_i32 s52, s61, 4
	s_add_u32 s8, s52, s8
	s_addc_u32 s9, 0, s9
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v96
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v128, s[8:9]
	global_atomic_add_f32 v6, v132, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v97
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v129, s[8:9]
	global_atomic_add_f32 v6, v133, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v98
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v136, s[8:9]
	global_atomic_add_f32 v6, v140, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v99
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v137, s[8:9]
	global_atomic_add_f32 v6, v141, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v100
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v144, s[8:9]
	global_atomic_add_f32 v6, v148, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v101
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v145, s[8:9]
	global_atomic_add_f32 v6, v149, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v102
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v152, s[8:9]
	global_atomic_add_f32 v6, v156, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v103
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v153, s[8:9]
	global_atomic_add_f32 v6, v157, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v104
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v160, s[8:9]
	global_atomic_add_f32 v6, v164, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v105
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v161, s[8:9]
	global_atomic_add_f32 v6, v165, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v106
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v168, s[8:9]
	global_atomic_add_f32 v6, v172, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v107
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v169, s[8:9]
	global_atomic_add_f32 v6, v173, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v108
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 24
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 25
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v176, s[8:9]
	global_atomic_add_f32 v6, v180, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v109
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 26
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 27
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v177, s[8:9]
	global_atomic_add_f32 v6, v181, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v110
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 28
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 29
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v184, s[8:9]
	global_atomic_add_f32 v6, v188, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v111
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 30
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 31
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v185, s[8:9]
	global_atomic_add_f32 v6, v189, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[130:131]
	ds_write_b64 v16, v[134:135] offset:4352
	ds_write_b64 v16, v[138:139] offset:8704
	ds_write_b64 v16, v[142:143] offset:13056
	ds_write_b64 v16, v[146:147] offset:17408
	ds_write_b64 v16, v[150:151] offset:21760
	ds_write_b64 v16, v[154:155] offset:26112
	ds_write_b64 v16, v[158:159] offset:30464
	ds_write_b64 v16, v[162:163] offset:2176
	ds_write_b64 v16, v[166:167] offset:6528
	ds_write_b64 v16, v[170:171] offset:10880
	ds_write_b64 v16, v[174:175] offset:15232
	ds_write_b64 v16, v[178:179] offset:19584
	ds_write_b64 v16, v[182:183] offset:23936
	ds_write_b64 v16, v[186:187] offset:28288
	ds_write_b64 v16, v[190:191] offset:32640
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v130, v17
	ds_read_b32 v131, v17 offset:64
	ds_read_b32 v134, v17 offset:2176
	ds_read_b32 v135, v17 offset:2240
	ds_read_b32 v138, v17 offset:4352
	ds_read_b32 v139, v17 offset:4416
	ds_read_b32 v142, v17 offset:6528
	ds_read_b32 v143, v17 offset:6592
	ds_read_b32 v146, v17 offset:8704
	ds_read_b32 v147, v17 offset:8768
	ds_read_b32 v150, v17 offset:10880
	ds_read_b32 v151, v17 offset:10944
	ds_read_b32 v154, v17 offset:13056
	ds_read_b32 v155, v17 offset:13120
	ds_read_b32 v158, v17 offset:15232
	ds_read_b32 v159, v17 offset:15296
	ds_read_b32 v162, v17 offset:17408
	ds_read_b32 v163, v17 offset:17472
	ds_read_b32 v166, v17 offset:19584
	ds_read_b32 v167, v17 offset:19648
	ds_read_b32 v170, v17 offset:21760
	ds_read_b32 v171, v17 offset:21824
	ds_read_b32 v174, v17 offset:23936
	ds_read_b32 v175, v17 offset:24000
	ds_read_b32 v178, v17 offset:26112
	ds_read_b32 v179, v17 offset:26176
	ds_read_b32 v182, v17 offset:28288
	ds_read_b32 v183, v17 offset:28352
	ds_read_b32 v186, v17 offset:30464
	ds_read_b32 v187, v17 offset:30528
	ds_read_b32 v190, v17 offset:32640
	ds_read_b32 v191, v17 offset:32704
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v96
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v130, s[8:9] offset:8
	global_atomic_add_f32 v6, v134, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v97
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v131, s[8:9] offset:8
	global_atomic_add_f32 v6, v135, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v98
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v138, s[8:9] offset:8
	global_atomic_add_f32 v6, v142, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v99
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v139, s[8:9] offset:8
	global_atomic_add_f32 v6, v143, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v100
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v146, s[8:9] offset:8
	global_atomic_add_f32 v6, v150, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v101
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v147, s[8:9] offset:8
	global_atomic_add_f32 v6, v151, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v102
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v154, s[8:9] offset:8
	global_atomic_add_f32 v6, v158, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v103
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v155, s[8:9] offset:8
	global_atomic_add_f32 v6, v159, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v104
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v162, s[8:9] offset:8
	global_atomic_add_f32 v6, v166, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v105
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v163, s[8:9] offset:8
	global_atomic_add_f32 v6, v167, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v106
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v170, s[8:9] offset:8
	global_atomic_add_f32 v6, v174, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v107
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v171, s[8:9] offset:8
	global_atomic_add_f32 v6, v175, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v108
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 24
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 25
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v178, s[8:9] offset:8
	global_atomic_add_f32 v6, v182, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v109
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 26
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 27
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v179, s[8:9] offset:8
	global_atomic_add_f32 v6, v183, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v110
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 28
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 29
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v186, s[8:9] offset:8
	global_atomic_add_f32 v6, v190, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v111
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 30
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 31
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v187, s[8:9] offset:8
	global_atomic_add_f32 v6, v191, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	s_branch label_2072

0000000000007018 <label_11C9>:
	s_waitcnt vmcnt(2) lgkmcnt(0)
	s_barrier
	v_mov_b32_e32 v48, v32
	v_mov_b32_e32 v49, v33
	v_mov_b32_e32 v50, v34
	v_mov_b32_e32 v51, v35
	v_mov_b32_e32 v52, v36
	v_mov_b32_e32 v53, v37
	v_mov_b32_e32 v54, v38
	v_mov_b32_e32 v55, v39
	v_mul_f32_dpp v4, v20, v48 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[128:135], a[0:7], 0
	buffer_load_dword v23, v19, s[32:35], 0 offen
	buffer_load_dwordx4 a[144:147], v60, s[76:79], 0 offen
	v_mul_f32_dpp v6, v20, v49 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[128:135], a[8:15], 0
	s_nop 5
	v_fma_f32 v64, v8, v4, v64
	v_fma_f32 v65, v9, v4, v65
	v_fma_f32 v66, v10, v4, v66
	v_fma_f32 v67, v11, v4, v67
	v_mul_f32_dpp v4, v20, v50 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[128:135], a[16:23], 0
	buffer_load_dwordx4 a[148:151], v60, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v68, v12, v6, v68
	v_fma_f32 v69, v13, v6, v69
	v_fma_f32 v70, v14, v6, v70
	v_fma_f32 v71, v15, v6, v71
	v_mul_f32_dpp v6, v20, v51 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[128:135], a[24:31], 0
	s_nop 5
	v_fma_f32 v72, v8, v4, v72
	v_fma_f32 v73, v9, v4, v73
	v_fma_f32 v74, v10, v4, v74
	v_fma_f32 v75, v11, v4, v75
	v_mul_f32_dpp v4, v20, v52 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[128:135], a[32:39], 0
	buffer_load_dwordx4 a[152:155], v61, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v76, v12, v6, v76
	v_fma_f32 v77, v13, v6, v77
	v_fma_f32 v78, v14, v6, v78
	v_fma_f32 v79, v15, v6, v79
	v_mul_f32_dpp v6, v20, v53 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[128:135], a[40:47], 0
	s_nop 5
	v_fma_f32 v80, v8, v4, v80
	v_fma_f32 v81, v9, v4, v81
	v_fma_f32 v82, v10, v4, v82
	v_fma_f32 v83, v11, v4, v83
	v_mul_f32_dpp v4, v20, v54 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[128:135], a[48:55], 0
	buffer_load_dwordx4 a[156:159], v61, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v84, v12, v6, v84
	v_fma_f32 v85, v13, v6, v85
	v_fma_f32 v86, v14, v6, v86
	v_fma_f32 v87, v15, v6, v87
	v_mul_f32_dpp v6, v20, v55 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[128:135], a[56:63], 0
	s_nop 5
	v_fma_f32 v88, v8, v4, v88
	v_fma_f32 v89, v9, v4, v89
	v_fma_f32 v90, v10, v4, v90
	v_fma_f32 v91, v11, v4, v91
	s_waitcnt vmcnt(5)
	v_mul_f32_dpp v4, v20, v48 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[136:143], a[0:7], 0
	buffer_load_dwordx4 v56, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s46
	s_nop 5
	v_fma_f32 v92, v12, v6, v92
	v_fma_f32 v93, v13, v6, v93
	v_fma_f32 v94, v14, v6, v94
	v_fma_f32 v95, v15, v6, v95
	v_mul_f32_dpp v6, v20, v49 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[136:143], a[8:15], 0
	s_nop 5
	v_fma_f32 v96, v8, v4, v96
	v_fma_f32 v97, v9, v4, v97
	v_fma_f32 v98, v10, v4, v98
	v_fma_f32 v99, v11, v4, v99
	v_mul_f32_dpp v4, v20, v50 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[136:143], a[16:23], 0
	buffer_load_dwordx4 v57, s[20:23], 0 offen lds
	s_add_u32 m0, 0x800, s46
	s_nop 5
	v_fma_f32 v100, v12, v6, v100
	v_fma_f32 v101, v13, v6, v101
	v_fma_f32 v102, v14, v6, v102
	v_fma_f32 v103, v15, v6, v103
	v_mul_f32_dpp v6, v20, v51 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[136:143], a[24:31], 0
	s_nop 5
	v_fma_f32 v104, v8, v4, v104
	v_fma_f32 v105, v9, v4, v105
	v_fma_f32 v106, v10, v4, v106
	v_fma_f32 v107, v11, v4, v107
	v_mul_f32_dpp v4, v20, v52 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[136:143], a[32:39], 0
	buffer_load_dwordx4 v58, s[20:23], 0 offen lds
	s_add_u32 m0, 0xc00, s46
	s_nop 5
	v_fma_f32 v108, v12, v6, v108
	v_fma_f32 v109, v13, v6, v109
	v_fma_f32 v110, v14, v6, v110
	v_fma_f32 v111, v15, v6, v111
	v_mul_f32_dpp v6, v20, v53 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[136:143], a[40:47], 0
	s_nop 5
	v_fma_f32 v112, v8, v4, v112
	v_fma_f32 v113, v9, v4, v113
	v_fma_f32 v114, v10, v4, v114
	v_fma_f32 v115, v11, v4, v115
	v_mul_f32_dpp v4, v20, v54 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[136:143], a[48:55], 0
	buffer_load_dwordx4 v59, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s47
	s_add_u32 s52, 0x80, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s73, s73, 0
	s_cselect_b32 s4, s4, 0
	s_nop 5
	v_fma_f32 v116, v12, v6, v116
	v_fma_f32 v117, v13, v6, v117
	v_fma_f32 v118, v14, v6, v118
	v_fma_f32 v119, v15, v6, v119
	v_mul_f32_dpp v6, v20, v55 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[136:143], a[56:63], 0
	s_add_u32 s32, s4, s32
	s_addc_u32 s33, 0, s33
	s_nop 5
	v_fma_f32 v120, v8, v4, v120
	v_fma_f32 v121, v9, v4, v121
	v_fma_f32 v122, v10, v4, v122
	v_fma_f32 v123, v11, v4, v123
	s_nop 5
	v_fma_f32 v124, v12, v6, v124
	v_fma_f32 v125, v13, v6, v125
	v_fma_f32 v126, v14, v6, v126
	v_fma_f32 v127, v15, v6, v127
	buffer_load_dword v32, v24, s[28:31], 0 offen
	buffer_load_dword v33, v25, s[28:31], 0 offen
	buffer_load_dword v34, v26, s[28:31], 0 offen
	buffer_load_dword v35, v27, s[28:31], 0 offen
	buffer_load_dword v36, v28, s[28:31], 0 offen
	buffer_load_dword v37, v29, s[28:31], 0 offen
	buffer_load_dword v38, v30, s[28:31], 0 offen
	buffer_load_dword v39, v31, s[28:31], 0 offen
	s_waitcnt vmcnt(12)
	v_mul_f32_dpp v4, v23, v48 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[0:7], 0
	buffer_load_dword v20, v18, s[32:35], 0 offen
	buffer_load_dwordx4 a[128:131], v60, s[24:27], 0 offen
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[0:7], 0
	ds_read_b128 a[64:67], v2 offset:16512
	ds_read_b128 a[68:71], v2 offset:16576
	s_nop 5
	v_fma_f32 v128, v8, v4, v128
	v_fma_f32 v129, v9, v4, v129
	v_fma_f32 v130, v10, v4, v130
	v_fma_f32 v131, v11, v4, v131
	v_mul_f32_dpp v6, v23, v49 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[8:15], 0
	buffer_load_dwordx4 a[132:135], v60, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v160, v12, v4, v160
	v_fma_f32 v161, v13, v4, v161
	v_fma_f32 v162, v14, v4, v162
	v_fma_f32 v163, v15, v4, v163
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[8:15], 0
	ds_read_b128 a[72:75], v2 offset:17024
	ds_read_b128 a[76:79], v2 offset:17088
	s_nop 5
	v_fma_f32 v132, v8, v6, v132
	v_fma_f32 v133, v9, v6, v133
	v_fma_f32 v134, v10, v6, v134
	v_fma_f32 v135, v11, v6, v135
	v_mul_f32_dpp v4, v23, v50 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[16:23], 0
	buffer_load_dwordx4 a[136:139], v61, s[24:27], 0 offen
	s_nop 5
	v_fma_f32 v164, v12, v6, v164
	v_fma_f32 v165, v13, v6, v165
	v_fma_f32 v166, v14, v6, v166
	v_fma_f32 v167, v15, v6, v167
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[16:23], 0
	ds_read_b128 a[80:83], v2 offset:17536
	ds_read_b128 a[84:87], v2 offset:17600
	s_nop 5
	v_fma_f32 v136, v8, v4, v136
	v_fma_f32 v137, v9, v4, v137
	v_fma_f32 v138, v10, v4, v138
	v_fma_f32 v139, v11, v4, v139
	v_mul_f32_dpp v6, v23, v51 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[24:31], 0
	buffer_load_dwordx4 a[140:143], v61, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v168, v12, v4, v168
	v_fma_f32 v169, v13, v4, v169
	v_fma_f32 v170, v14, v4, v170
	v_fma_f32 v171, v15, v4, v171
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[24:31], 0
	ds_read_b128 a[88:91], v2 offset:18048
	ds_read_b128 a[92:95], v2 offset:18112
	s_nop 5
	v_fma_f32 v140, v8, v6, v140
	v_fma_f32 v141, v9, v6, v141
	v_fma_f32 v142, v10, v6, v142
	v_fma_f32 v143, v11, v6, v143
	v_mul_f32_dpp v4, v23, v52 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[32:39], 0
	s_nop 5
	v_fma_f32 v172, v12, v6, v172
	v_fma_f32 v173, v13, v6, v173
	v_fma_f32 v174, v14, v6, v174
	v_fma_f32 v175, v15, v6, v175
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[32:39], 0
	ds_read_b128 a[96:99], v2 offset:18560
	ds_read_b128 a[100:103], v2 offset:18624
	s_nop 5
	v_fma_f32 v144, v8, v4, v144
	v_fma_f32 v145, v9, v4, v145
	v_fma_f32 v146, v10, v4, v146
	v_fma_f32 v147, v11, v4, v147
	v_mul_f32_dpp v6, v23, v53 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[40:47], 0
	s_nop 5
	v_fma_f32 v176, v12, v4, v176
	v_fma_f32 v177, v13, v4, v177
	v_fma_f32 v178, v14, v4, v178
	v_fma_f32 v179, v15, v4, v179
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[40:47], 0
	ds_read_b128 a[104:107], v2 offset:19072
	ds_read_b128 a[108:111], v2 offset:19136
	s_add_u32 s52, 0x100, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s58, s58, 0
	s_nop 5
	v_fma_f32 v148, v8, v6, v148
	v_fma_f32 v149, v9, v6, v149
	v_fma_f32 v150, v10, v6, v150
	v_fma_f32 v151, v11, v6, v151
	v_mul_f32_dpp v4, v23, v54 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[48:55], 0
	s_add_u32 s76, s73, s24
	s_addc_u32 s77, 0, s77
	s_nop 5
	v_fma_f32 v180, v12, v6, v180
	v_fma_f32 v181, v13, v6, v181
	v_fma_f32 v182, v14, v6, v182
	v_fma_f32 v183, v15, v6, v183
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[48:55], 0
	ds_read_b128 a[112:115], v2 offset:19584
	ds_read_b128 a[116:119], v2 offset:19648
	s_add_u32 s52, 0x180, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s57, s57, 0
	s_cselect_b32 s6, s6, 0
	s_nop 5
	v_fma_f32 v152, v8, v4, v152
	v_fma_f32 v153, v9, v4, v153
	v_fma_f32 v154, v10, v4, v154
	v_fma_f32 v155, v11, v4, v155
	v_mul_f32_dpp v6, v23, v55 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[56:63], 0
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	s_nop 5
	v_fma_f32 v184, v12, v4, v184
	v_fma_f32 v185, v13, v4, v185
	v_fma_f32 v186, v14, v4, v186
	v_fma_f32 v187, v15, v4, v187
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[56:63], 0
	ds_read_b128 a[120:123], v2 offset:20096
	ds_read_b128 a[124:127], v2 offset:20160
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_nop 5
	v_fma_f32 v156, v8, v6, v156
	v_fma_f32 v157, v9, v6, v157
	v_fma_f32 v158, v10, v6, v158
	v_fma_f32 v159, v11, v6, v159
	s_nop 5
	v_fma_f32 v188, v12, v6, v188
	v_fma_f32 v189, v13, v6, v189
	v_fma_f32 v190, v14, v6, v190
	v_fma_f32 v191, v15, v6, v191
	s_addk_i32 s70, 0x80
	s_cmp_lt_i32 s70, s71
	s_cbranch_scc0 label_15DE
	s_waitcnt vmcnt(2) lgkmcnt(0)
	s_barrier
	v_mov_b32_e32 v48, v40
	v_mov_b32_e32 v49, v41
	v_mov_b32_e32 v50, v42
	v_mov_b32_e32 v51, v43
	v_mov_b32_e32 v52, v44
	v_mov_b32_e32 v53, v45
	v_mov_b32_e32 v54, v46
	v_mov_b32_e32 v55, v47
	v_mul_f32_dpp v4, v20, v48 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[128:135], a[64:71], 0
	buffer_load_dword v23, v19, s[32:35], 0 offen
	buffer_load_dwordx4 a[144:147], v60, s[76:79], 0 offen
	v_mul_f32_dpp v6, v20, v49 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[128:135], a[72:79], 0
	s_nop 5
	v_fma_f32 v64, v8, v4, v64
	v_fma_f32 v65, v9, v4, v65
	v_fma_f32 v66, v10, v4, v66
	v_fma_f32 v67, v11, v4, v67
	v_mul_f32_dpp v4, v20, v50 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[128:135], a[80:87], 0
	buffer_load_dwordx4 a[148:151], v60, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v68, v12, v6, v68
	v_fma_f32 v69, v13, v6, v69
	v_fma_f32 v70, v14, v6, v70
	v_fma_f32 v71, v15, v6, v71
	v_mul_f32_dpp v6, v20, v51 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[128:135], a[88:95], 0
	s_nop 5
	v_fma_f32 v72, v8, v4, v72
	v_fma_f32 v73, v9, v4, v73
	v_fma_f32 v74, v10, v4, v74
	v_fma_f32 v75, v11, v4, v75
	v_mul_f32_dpp v4, v20, v52 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[128:135], a[96:103], 0
	buffer_load_dwordx4 a[152:155], v61, s[76:79], 0 offen
	s_nop 5
	v_fma_f32 v76, v12, v6, v76
	v_fma_f32 v77, v13, v6, v77
	v_fma_f32 v78, v14, v6, v78
	v_fma_f32 v79, v15, v6, v79
	v_mul_f32_dpp v6, v20, v53 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[128:135], a[104:111], 0
	s_nop 5
	v_fma_f32 v80, v8, v4, v80
	v_fma_f32 v81, v9, v4, v81
	v_fma_f32 v82, v10, v4, v82
	v_fma_f32 v83, v11, v4, v83
	v_mul_f32_dpp v4, v20, v54 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[128:135], a[112:119], 0
	buffer_load_dwordx4 a[156:159], v61, s[76:79], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v84, v12, v6, v84
	v_fma_f32 v85, v13, v6, v85
	v_fma_f32 v86, v14, v6, v86
	v_fma_f32 v87, v15, v6, v87
	v_mul_f32_dpp v6, v20, v55 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[128:135], a[120:127], 0
	s_nop 5
	v_fma_f32 v88, v8, v4, v88
	v_fma_f32 v89, v9, v4, v89
	v_fma_f32 v90, v10, v4, v90
	v_fma_f32 v91, v11, v4, v91
	s_waitcnt vmcnt(5)
	v_mul_f32_dpp v4, v20, v48 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[136:143], a[64:71], 0
	buffer_load_dwordx4 v56, s[20:23], 0 offen lds
	s_add_u32 m0, 0x400, s47
	s_nop 5
	v_fma_f32 v92, v12, v6, v92
	v_fma_f32 v93, v13, v6, v93
	v_fma_f32 v94, v14, v6, v94
	v_fma_f32 v95, v15, v6, v95
	v_mul_f32_dpp v6, v20, v49 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[136:143], a[72:79], 0
	s_nop 5
	v_fma_f32 v96, v8, v4, v96
	v_fma_f32 v97, v9, v4, v97
	v_fma_f32 v98, v10, v4, v98
	v_fma_f32 v99, v11, v4, v99
	v_mul_f32_dpp v4, v20, v50 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[136:143], a[80:87], 0
	buffer_load_dwordx4 v57, s[20:23], 0 offen lds
	s_add_u32 m0, 0x800, s47
	s_nop 5
	v_fma_f32 v100, v12, v6, v100
	v_fma_f32 v101, v13, v6, v101
	v_fma_f32 v102, v14, v6, v102
	v_fma_f32 v103, v15, v6, v103
	v_mul_f32_dpp v6, v20, v51 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[136:143], a[88:95], 0
	s_nop 5
	v_fma_f32 v104, v8, v4, v104
	v_fma_f32 v105, v9, v4, v105
	v_fma_f32 v106, v10, v4, v106
	v_fma_f32 v107, v11, v4, v107
	v_mul_f32_dpp v4, v20, v52 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[136:143], a[96:103], 0
	buffer_load_dwordx4 v58, s[20:23], 0 offen lds
	s_add_u32 m0, 0xc00, s47
	s_nop 5
	v_fma_f32 v108, v12, v6, v108
	v_fma_f32 v109, v13, v6, v109
	v_fma_f32 v110, v14, v6, v110
	v_fma_f32 v111, v15, v6, v111
	v_mul_f32_dpp v6, v20, v53 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[136:143], a[104:111], 0
	s_nop 5
	v_fma_f32 v112, v8, v4, v112
	v_fma_f32 v113, v9, v4, v113
	v_fma_f32 v114, v10, v4, v114
	v_fma_f32 v115, v11, v4, v115
	v_mul_f32_dpp v4, v20, v54 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[136:143], a[112:119], 0
	buffer_load_dwordx4 v59, s[20:23], 0 offen lds
	s_add_u32 m0, 0, s46
	s_add_u32 s52, 0x80, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s73, s73, 0
	s_cselect_b32 s4, s4, 0
	s_nop 5
	v_fma_f32 v116, v12, v6, v116
	v_fma_f32 v117, v13, v6, v117
	v_fma_f32 v118, v14, v6, v118
	v_fma_f32 v119, v15, v6, v119
	v_mul_f32_dpp v6, v20, v55 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[136:143], a[120:127], 0
	s_add_u32 s32, s4, s32
	s_addc_u32 s33, 0, s33
	s_nop 5
	v_fma_f32 v120, v8, v4, v120
	v_fma_f32 v121, v9, v4, v121
	v_fma_f32 v122, v10, v4, v122
	v_fma_f32 v123, v11, v4, v123
	s_nop 5
	v_fma_f32 v124, v12, v6, v124
	v_fma_f32 v125, v13, v6, v125
	v_fma_f32 v126, v14, v6, v126
	v_fma_f32 v127, v15, v6, v127
	buffer_load_dword v40, v24, s[28:31], 0 offen
	buffer_load_dword v41, v25, s[28:31], 0 offen
	buffer_load_dword v42, v26, s[28:31], 0 offen
	buffer_load_dword v43, v27, s[28:31], 0 offen
	buffer_load_dword v44, v28, s[28:31], 0 offen
	buffer_load_dword v45, v29, s[28:31], 0 offen
	buffer_load_dword v46, v30, s[28:31], 0 offen
	buffer_load_dword v47, v31, s[28:31], 0 offen
	s_waitcnt vmcnt(12)
	v_mul_f32_dpp v4, v23, v48 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[64:71], 0
	buffer_load_dword v20, v18, s[32:35], 0 offen
	buffer_load_dwordx4 a[128:131], v60, s[24:27], 0 offen
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[64:71], 0
	ds_read_b128 a[0:3], v2
	ds_read_b128 a[4:7], v2 offset:64
	s_nop 5
	v_fma_f32 v128, v8, v4, v128
	v_fma_f32 v129, v9, v4, v129
	v_fma_f32 v130, v10, v4, v130
	v_fma_f32 v131, v11, v4, v131
	v_mul_f32_dpp v6, v23, v49 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[72:79], 0
	buffer_load_dwordx4 a[132:135], v60, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v160, v12, v4, v160
	v_fma_f32 v161, v13, v4, v161
	v_fma_f32 v162, v14, v4, v162
	v_fma_f32 v163, v15, v4, v163
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[72:79], 0
	ds_read_b128 a[8:11], v2 offset:512
	ds_read_b128 a[12:15], v2 offset:576
	s_nop 5
	v_fma_f32 v132, v8, v6, v132
	v_fma_f32 v133, v9, v6, v133
	v_fma_f32 v134, v10, v6, v134
	v_fma_f32 v135, v11, v6, v135
	v_mul_f32_dpp v4, v23, v50 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[80:87], 0
	buffer_load_dwordx4 a[136:139], v61, s[24:27], 0 offen
	s_nop 5
	v_fma_f32 v164, v12, v6, v164
	v_fma_f32 v165, v13, v6, v165
	v_fma_f32 v166, v14, v6, v166
	v_fma_f32 v167, v15, v6, v167
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[80:87], 0
	ds_read_b128 a[16:19], v2 offset:1024
	ds_read_b128 a[20:23], v2 offset:1088
	s_nop 5
	v_fma_f32 v136, v8, v4, v136
	v_fma_f32 v137, v9, v4, v137
	v_fma_f32 v138, v10, v4, v138
	v_fma_f32 v139, v11, v4, v139
	v_mul_f32_dpp v6, v23, v51 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[88:95], 0
	buffer_load_dwordx4 a[140:143], v61, s[24:27], 0 offen offset:1024
	s_nop 5
	v_fma_f32 v168, v12, v4, v168
	v_fma_f32 v169, v13, v4, v169
	v_fma_f32 v170, v14, v4, v170
	v_fma_f32 v171, v15, v4, v171
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[88:95], 0
	ds_read_b128 a[24:27], v2 offset:1536
	ds_read_b128 a[28:31], v2 offset:1600
	s_nop 5
	v_fma_f32 v140, v8, v6, v140
	v_fma_f32 v141, v9, v6, v141
	v_fma_f32 v142, v10, v6, v142
	v_fma_f32 v143, v11, v6, v143
	v_mul_f32_dpp v4, v23, v52 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[96:103], 0
	s_nop 5
	v_fma_f32 v172, v12, v6, v172
	v_fma_f32 v173, v13, v6, v173
	v_fma_f32 v174, v14, v6, v174
	v_fma_f32 v175, v15, v6, v175
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[96:103], 0
	ds_read_b128 a[32:35], v2 offset:2048
	ds_read_b128 a[36:39], v2 offset:2112
	s_nop 5
	v_fma_f32 v144, v8, v4, v144
	v_fma_f32 v145, v9, v4, v145
	v_fma_f32 v146, v10, v4, v146
	v_fma_f32 v147, v11, v4, v147
	v_mul_f32_dpp v6, v23, v53 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[104:111], 0
	s_nop 5
	v_fma_f32 v176, v12, v4, v176
	v_fma_f32 v177, v13, v4, v177
	v_fma_f32 v178, v14, v4, v178
	v_fma_f32 v179, v15, v4, v179
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[104:111], 0
	ds_read_b128 a[40:43], v2 offset:2560
	ds_read_b128 a[44:47], v2 offset:2624
	s_add_u32 s52, 0x100, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s58, s58, 0
	s_nop 5
	v_fma_f32 v148, v8, v6, v148
	v_fma_f32 v149, v9, v6, v149
	v_fma_f32 v150, v10, v6, v150
	v_fma_f32 v151, v11, v6, v151
	v_mul_f32_dpp v4, v23, v54 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[112:119], 0
	s_add_u32 s76, s73, s24
	s_addc_u32 s77, 0, s77
	s_nop 5
	v_fma_f32 v180, v12, v6, v180
	v_fma_f32 v181, v13, v6, v181
	v_fma_f32 v182, v14, v6, v182
	v_fma_f32 v183, v15, v6, v183
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[112:119], 0
	ds_read_b128 a[48:51], v2 offset:3072
	ds_read_b128 a[52:55], v2 offset:3136
	s_add_u32 s52, 0x180, s70
	s_cmp_lt_u32 s52, s71
	s_cselect_b32 s57, s57, 0
	s_cselect_b32 s6, s6, 0
	s_nop 5
	v_fma_f32 v152, v8, v4, v152
	v_fma_f32 v153, v9, v4, v153
	v_fma_f32 v154, v10, v4, v154
	v_fma_f32 v155, v11, v4, v155
	v_mul_f32_dpp v6, v23, v55 row_newbcast:0 row_mask:0xf bank_mask:0xf
	v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[144:151], a[120:127], 0
	s_add_u32 s20, s57, s20
	s_addc_u32 s21, 0, s21
	s_add_u32 s28, s6, s28
	s_addc_u32 s29, 0, s29
	s_nop 5
	v_fma_f32 v184, v12, v4, v184
	v_fma_f32 v185, v13, v4, v185
	v_fma_f32 v186, v14, v4, v186
	v_fma_f32 v187, v15, v4, v187
	v_mfma_f32_16x16x128_f8f6f4 v[12:15], a[152:159], a[120:127], 0
	ds_read_b128 a[56:59], v2 offset:3584
	ds_read_b128 a[60:63], v2 offset:3648
	s_add_u32 s24, s58, s24
	s_addc_u32 s25, 0, s25
	s_nop 5
	v_fma_f32 v156, v8, v6, v156
	v_fma_f32 v157, v9, v6, v157
	v_fma_f32 v158, v10, v6, v158
	v_fma_f32 v159, v11, v6, v159
	s_nop 5
	v_fma_f32 v188, v12, v6, v188
	v_fma_f32 v189, v13, v6, v189
	v_fma_f32 v190, v14, v6, v190
	v_fma_f32 v191, v15, v6, v191
	s_addk_i32 s70, 0x80
	s_cmp_lt_i32 s70, s71
	s_cbranch_scc0 label_15DE
	s_branch label_11C9

000000000000806c <label_15DE>:
	s_cmp_eq_u32 s74, 0
	s_cbranch_scc0 label_1A08
	v_cvt_pk_bf16_f32 v64, v64, v65
	v_cvt_pk_bf16_f32 v65, v66, v67
	v_cvt_pk_bf16_f32 v66, v68, v69
	v_cvt_pk_bf16_f32 v67, v70, v71
	v_cvt_pk_bf16_f32 v68, v72, v73
	v_cvt_pk_bf16_f32 v69, v74, v75
	v_cvt_pk_bf16_f32 v70, v76, v77
	v_cvt_pk_bf16_f32 v71, v78, v79
	v_cvt_pk_bf16_f32 v72, v80, v81
	v_cvt_pk_bf16_f32 v73, v82, v83
	v_cvt_pk_bf16_f32 v74, v84, v85
	v_cvt_pk_bf16_f32 v75, v86, v87
	v_cvt_pk_bf16_f32 v76, v88, v89
	v_cvt_pk_bf16_f32 v77, v90, v91
	v_cvt_pk_bf16_f32 v78, v92, v93
	v_cvt_pk_bf16_f32 v79, v94, v95
	v_cvt_pk_bf16_f32 v80, v96, v97
	v_cvt_pk_bf16_f32 v81, v98, v99
	v_cvt_pk_bf16_f32 v82, v100, v101
	v_cvt_pk_bf16_f32 v83, v102, v103
	v_cvt_pk_bf16_f32 v84, v104, v105
	v_cvt_pk_bf16_f32 v85, v106, v107
	v_cvt_pk_bf16_f32 v86, v108, v109
	v_cvt_pk_bf16_f32 v87, v110, v111
	v_cvt_pk_bf16_f32 v88, v112, v113
	v_cvt_pk_bf16_f32 v89, v114, v115
	v_cvt_pk_bf16_f32 v90, v116, v117
	v_cvt_pk_bf16_f32 v91, v118, v119
	v_cvt_pk_bf16_f32 v92, v120, v121
	v_cvt_pk_bf16_f32 v93, v122, v123
	v_cvt_pk_bf16_f32 v94, v124, v125
	v_cvt_pk_bf16_f32 v95, v126, v127
	ds_write_b64 v16, v[64:65]
	ds_write_b64 v16, v[66:67] offset:4352
	ds_write_b64 v16, v[68:69] offset:8704
	ds_write_b64 v16, v[70:71] offset:13056
	ds_write_b64 v16, v[72:73] offset:17408
	ds_write_b64 v16, v[74:75] offset:21760
	ds_write_b64 v16, v[76:77] offset:26112
	ds_write_b64 v16, v[78:79] offset:30464
	ds_write_b64 v16, v[80:81] offset:2176
	ds_write_b64 v16, v[82:83] offset:6528
	ds_write_b64 v16, v[84:85] offset:10880
	ds_write_b64 v16, v[86:87] offset:15232
	ds_write_b64 v16, v[88:89] offset:19584
	ds_write_b64 v16, v[90:91] offset:23936
	ds_write_b64 v16, v[92:93] offset:28288
	ds_write_b64 v16, v[94:95] offset:32640
	v_cvt_pk_bf16_f32 v128, v128, v129
	v_cvt_pk_bf16_f32 v129, v130, v131
	v_cvt_pk_bf16_f32 v130, v132, v133
	v_cvt_pk_bf16_f32 v131, v134, v135
	v_cvt_pk_bf16_f32 v132, v136, v137
	v_cvt_pk_bf16_f32 v133, v138, v139
	v_cvt_pk_bf16_f32 v134, v140, v141
	v_cvt_pk_bf16_f32 v135, v142, v143
	v_cvt_pk_bf16_f32 v136, v144, v145
	v_cvt_pk_bf16_f32 v137, v146, v147
	v_cvt_pk_bf16_f32 v138, v148, v149
	v_cvt_pk_bf16_f32 v139, v150, v151
	v_cvt_pk_bf16_f32 v140, v152, v153
	v_cvt_pk_bf16_f32 v141, v154, v155
	v_cvt_pk_bf16_f32 v142, v156, v157
	v_cvt_pk_bf16_f32 v143, v158, v159
	v_cvt_pk_bf16_f32 v144, v160, v161
	v_cvt_pk_bf16_f32 v145, v162, v163
	v_cvt_pk_bf16_f32 v146, v164, v165
	v_cvt_pk_bf16_f32 v147, v166, v167
	v_cvt_pk_bf16_f32 v148, v168, v169
	v_cvt_pk_bf16_f32 v149, v170, v171
	v_cvt_pk_bf16_f32 v150, v172, v173
	v_cvt_pk_bf16_f32 v151, v174, v175
	v_cvt_pk_bf16_f32 v152, v176, v177
	v_cvt_pk_bf16_f32 v153, v178, v179
	v_cvt_pk_bf16_f32 v154, v180, v181
	v_cvt_pk_bf16_f32 v155, v182, v183
	v_cvt_pk_bf16_f32 v156, v184, v185
	v_cvt_pk_bf16_f32 v157, v186, v187
	v_cvt_pk_bf16_f32 v158, v188, v189
	v_cvt_pk_bf16_f32 v159, v190, v191
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
	v_add_u32_e32 v96, v6, v7
	v_readlane_b32 s72, v3, 2
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 3
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v97, v6, v7
	v_readlane_b32 s72, v3, 4
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 5
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v98, v6, v7
	v_readlane_b32 s72, v3, 6
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 7
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v99, v6, v7
	v_readlane_b32 s72, v3, 8
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 9
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v100, v6, v7
	v_readlane_b32 s72, v3, 10
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 11
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v101, v6, v7
	v_readlane_b32 s72, v3, 12
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 13
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v102, v6, v7
	v_readlane_b32 s72, v3, 14
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 15
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v103, v6, v7
	v_readlane_b32 s72, v3, 16
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 17
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v104, v6, v7
	v_readlane_b32 s72, v3, 18
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 19
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v105, v6, v7
	v_readlane_b32 s72, v3, 20
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 21
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v106, v6, v7
	v_readlane_b32 s72, v3, 22
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 23
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v107, v6, v7
	v_readlane_b32 s72, v3, 24
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 25
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v108, v6, v7
	v_readlane_b32 s72, v3, 26
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 27
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v109, v6, v7
	v_readlane_b32 s72, v3, 28
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 29
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v110, v6, v7
	v_readlane_b32 s72, v3, 30
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 31
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v111, v6, v7
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 2, 4
	v_mul_lo_u32 v4, v4, s53
	v_and_b32_e64 v5, v0, 1
	v_add_u32_e32 v4, v4, v5
	v_lshlrev_b32_e32 v4, 2, v4
	v_add_u32_e32 v96, v96, v4
	v_add_u32_e32 v97, v97, v4
	v_add_u32_e32 v98, v98, v4
	v_add_u32_e32 v99, v99, v4
	v_add_u32_e32 v100, v100, v4
	v_add_u32_e32 v101, v101, v4
	v_add_u32_e32 v102, v102, v4
	v_add_u32_e32 v103, v103, v4
	v_add_u32_e32 v104, v104, v4
	v_add_u32_e32 v105, v105, v4
	v_add_u32_e32 v106, v106, v4
	v_add_u32_e32 v107, v107, v4
	v_add_u32_e32 v108, v108, v4
	v_add_u32_e32 v109, v109, v4
	v_add_u32_e32 v110, v110, v4
	v_add_u32_e32 v111, v111, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v64, v17
	ds_read_b32 v65, v17 offset:64
	ds_read_b32 v66, v17 offset:2176
	ds_read_b32 v67, v17 offset:2240
	ds_read_b32 v68, v17 offset:4352
	ds_read_b32 v69, v17 offset:4416
	ds_read_b32 v70, v17 offset:6528
	ds_read_b32 v71, v17 offset:6592
	ds_read_b32 v72, v17 offset:8704
	ds_read_b32 v73, v17 offset:8768
	ds_read_b32 v74, v17 offset:10880
	ds_read_b32 v75, v17 offset:10944
	ds_read_b32 v76, v17 offset:13056
	ds_read_b32 v77, v17 offset:13120
	ds_read_b32 v78, v17 offset:15232
	ds_read_b32 v79, v17 offset:15296
	ds_read_b32 v80, v17 offset:17408
	ds_read_b32 v81, v17 offset:17472
	ds_read_b32 v82, v17 offset:19584
	ds_read_b32 v83, v17 offset:19648
	ds_read_b32 v84, v17 offset:21760
	ds_read_b32 v85, v17 offset:21824
	ds_read_b32 v86, v17 offset:23936
	ds_read_b32 v87, v17 offset:24000
	ds_read_b32 v88, v17 offset:26112
	ds_read_b32 v89, v17 offset:26176
	ds_read_b32 v90, v17 offset:28288
	ds_read_b32 v91, v17 offset:28352
	ds_read_b32 v92, v17 offset:30464
	ds_read_b32 v93, v17 offset:30528
	ds_read_b32 v94, v17 offset:32640
	ds_read_b32 v95, v17 offset:32704
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_or_b32 s9, s9, 0x40000
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v96
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v64, v6, s[8:11], 0 offen
	buffer_store_dword v66, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v97
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v65, v6, s[8:11], 0 offen
	buffer_store_dword v67, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v98
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v68, v6, s[8:11], 0 offen
	buffer_store_dword v70, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v99
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v69, v6, s[8:11], 0 offen
	buffer_store_dword v71, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v100
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v72, v6, s[8:11], 0 offen
	buffer_store_dword v74, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v101
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v73, v6, s[8:11], 0 offen
	buffer_store_dword v75, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v102
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v76, v6, s[8:11], 0 offen
	buffer_store_dword v78, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v103
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v77, v6, s[8:11], 0 offen
	buffer_store_dword v79, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v104
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v80, v6, s[8:11], 0 offen
	buffer_store_dword v82, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v105
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v81, v6, s[8:11], 0 offen
	buffer_store_dword v83, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v106
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v84, v6, s[8:11], 0 offen
	buffer_store_dword v86, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v107
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v85, v6, s[8:11], 0 offen
	buffer_store_dword v87, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v108
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 24
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 25
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v88, v6, s[8:11], 0 offen
	buffer_store_dword v90, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v109
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 26
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 27
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v89, v6, s[8:11], 0 offen
	buffer_store_dword v91, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v110
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 28
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 29
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v92, v6, s[8:11], 0 offen
	buffer_store_dword v94, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v111
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 30
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 31
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v93, v6, s[8:11], 0 offen
	buffer_store_dword v95, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_write_b64 v16, v[128:129]
	ds_write_b64 v16, v[130:131] offset:4352
	ds_write_b64 v16, v[132:133] offset:8704
	ds_write_b64 v16, v[134:135] offset:13056
	ds_write_b64 v16, v[136:137] offset:17408
	ds_write_b64 v16, v[138:139] offset:21760
	ds_write_b64 v16, v[140:141] offset:26112
	ds_write_b64 v16, v[142:143] offset:30464
	ds_write_b64 v16, v[144:145] offset:2176
	ds_write_b64 v16, v[146:147] offset:6528
	ds_write_b64 v16, v[148:149] offset:10880
	ds_write_b64 v16, v[150:151] offset:15232
	ds_write_b64 v16, v[152:153] offset:19584
	ds_write_b64 v16, v[154:155] offset:23936
	ds_write_b64 v16, v[156:157] offset:28288
	ds_write_b64 v16, v[158:159] offset:32640
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v128, v17
	ds_read_b32 v129, v17 offset:64
	ds_read_b32 v130, v17 offset:2176
	ds_read_b32 v131, v17 offset:2240
	ds_read_b32 v132, v17 offset:4352
	ds_read_b32 v133, v17 offset:4416
	ds_read_b32 v134, v17 offset:6528
	ds_read_b32 v135, v17 offset:6592
	ds_read_b32 v136, v17 offset:8704
	ds_read_b32 v137, v17 offset:8768
	ds_read_b32 v138, v17 offset:10880
	ds_read_b32 v139, v17 offset:10944
	ds_read_b32 v140, v17 offset:13056
	ds_read_b32 v141, v17 offset:13120
	ds_read_b32 v142, v17 offset:15232
	ds_read_b32 v143, v17 offset:15296
	ds_read_b32 v144, v17 offset:17408
	ds_read_b32 v145, v17 offset:17472
	ds_read_b32 v146, v17 offset:19584
	ds_read_b32 v147, v17 offset:19648
	ds_read_b32 v148, v17 offset:21760
	ds_read_b32 v149, v17 offset:21824
	ds_read_b32 v150, v17 offset:23936
	ds_read_b32 v151, v17 offset:24000
	ds_read_b32 v152, v17 offset:26112
	ds_read_b32 v153, v17 offset:26176
	ds_read_b32 v154, v17 offset:28288
	ds_read_b32 v155, v17 offset:28352
	ds_read_b32 v156, v17 offset:30464
	ds_read_b32 v157, v17 offset:30528
	ds_read_b32 v158, v17 offset:32640
	ds_read_b32 v159, v17 offset:32704
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_add_u32 s8, 0x100, s8
	s_addc_u32 s9, 0, s9
	s_or_b32 s9, s9, 0x40000
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v96
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v128, v6, s[8:11], 0 offen
	buffer_store_dword v130, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v97
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v129, v6, s[8:11], 0 offen
	buffer_store_dword v131, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v98
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v132, v6, s[8:11], 0 offen
	buffer_store_dword v134, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v99
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v133, v6, s[8:11], 0 offen
	buffer_store_dword v135, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v100
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v136, v6, s[8:11], 0 offen
	buffer_store_dword v138, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v101
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v137, v6, s[8:11], 0 offen
	buffer_store_dword v139, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v102
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v140, v6, s[8:11], 0 offen
	buffer_store_dword v142, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v103
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v141, v6, s[8:11], 0 offen
	buffer_store_dword v143, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v104
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v144, v6, s[8:11], 0 offen
	buffer_store_dword v146, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v105
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v145, v6, s[8:11], 0 offen
	buffer_store_dword v147, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v106
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v148, v6, s[8:11], 0 offen
	buffer_store_dword v150, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v107
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v149, v6, s[8:11], 0 offen
	buffer_store_dword v151, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v108
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 24
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 25
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v152, v6, s[8:11], 0 offen
	buffer_store_dword v154, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v109
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 26
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 27
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v153, v6, s[8:11], 0 offen
	buffer_store_dword v155, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v110
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 28
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 29
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v156, v6, s[8:11], 0 offen
	buffer_store_dword v158, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v111
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 30
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 31
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	buffer_store_dword v157, v6, s[8:11], 0 offen
	buffer_store_dword v159, v6, s[8:11], 0 offen offset:128
	s_mov_b64 exec, s[16:17]
	s_branch label_2072

0000000000009114 <label_1A08>:
	ds_write_b64 v16, v[64:65]
	ds_write_b64 v16, v[68:69] offset:4352
	ds_write_b64 v16, v[72:73] offset:8704
	ds_write_b64 v16, v[76:77] offset:13056
	ds_write_b64 v16, v[80:81] offset:17408
	ds_write_b64 v16, v[84:85] offset:21760
	ds_write_b64 v16, v[88:89] offset:26112
	ds_write_b64 v16, v[92:93] offset:30464
	ds_write_b64 v16, v[96:97] offset:2176
	ds_write_b64 v16, v[100:101] offset:6528
	ds_write_b64 v16, v[104:105] offset:10880
	ds_write_b64 v16, v[108:109] offset:15232
	ds_write_b64 v16, v[112:113] offset:19584
	ds_write_b64 v16, v[116:117] offset:23936
	ds_write_b64 v16, v[120:121] offset:28288
	ds_write_b64 v16, v[124:125] offset:32640
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
	v_add_u32_e32 v96, v6, v7
	v_readlane_b32 s72, v3, 2
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 3
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v97, v6, v7
	v_readlane_b32 s72, v3, 4
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 5
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v98, v6, v7
	v_readlane_b32 s72, v3, 6
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 7
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v99, v6, v7
	v_readlane_b32 s72, v3, 8
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 9
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v100, v6, v7
	v_readlane_b32 s72, v3, 10
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 11
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v101, v6, v7
	v_readlane_b32 s72, v3, 12
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 13
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v102, v6, v7
	v_readlane_b32 s72, v3, 14
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 15
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v103, v6, v7
	v_readlane_b32 s72, v3, 16
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 17
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v104, v6, v7
	v_readlane_b32 s72, v3, 18
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 19
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v105, v6, v7
	v_readlane_b32 s72, v3, 20
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 21
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v106, v6, v7
	v_readlane_b32 s72, v3, 22
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 23
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v107, v6, v7
	v_readlane_b32 s72, v3, 24
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 25
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v108, v6, v7
	v_readlane_b32 s72, v3, 26
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 27
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v109, v6, v7
	v_readlane_b32 s72, v3, 28
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 29
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v110, v6, v7
	v_readlane_b32 s72, v3, 30
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v6, v5, s72
	v_readlane_b32 s72, v3, 31
	s_mul_i32 s72, s72, s66
	v_mul_lo_u32 v7, v4, s72
	v_add_u32_e32 v111, v6, v7
	v_and_b32_e32 v4, 31, v0
	v_lshrrev_b32_e32 v4, 1, v4
	s_cmp_eq_u32 s74, 0
	s_cselect_b32 s53, 2, 4
	v_mul_lo_u32 v4, v4, s53
	v_and_b32_e64 v5, v0, 1
	v_add_u32_e32 v4, v4, v5
	v_lshlrev_b32_e32 v4, 2, v4
	v_add_u32_e32 v96, v96, v4
	v_add_u32_e32 v97, v97, v4
	v_add_u32_e32 v98, v98, v4
	v_add_u32_e32 v99, v99, v4
	v_add_u32_e32 v100, v100, v4
	v_add_u32_e32 v101, v101, v4
	v_add_u32_e32 v102, v102, v4
	v_add_u32_e32 v103, v103, v4
	v_add_u32_e32 v104, v104, v4
	v_add_u32_e32 v105, v105, v4
	v_add_u32_e32 v106, v106, v4
	v_add_u32_e32 v107, v107, v4
	v_add_u32_e32 v108, v108, v4
	v_add_u32_e32 v109, v109, v4
	v_add_u32_e32 v110, v110, v4
	v_add_u32_e32 v111, v111, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v64, v17
	ds_read_b32 v65, v17 offset:64
	ds_read_b32 v68, v17 offset:2176
	ds_read_b32 v69, v17 offset:2240
	ds_read_b32 v72, v17 offset:4352
	ds_read_b32 v73, v17 offset:4416
	ds_read_b32 v76, v17 offset:6528
	ds_read_b32 v77, v17 offset:6592
	ds_read_b32 v80, v17 offset:8704
	ds_read_b32 v81, v17 offset:8768
	ds_read_b32 v84, v17 offset:10880
	ds_read_b32 v85, v17 offset:10944
	ds_read_b32 v88, v17 offset:13056
	ds_read_b32 v89, v17 offset:13120
	ds_read_b32 v92, v17 offset:15232
	ds_read_b32 v93, v17 offset:15296
	ds_read_b32 v96, v17 offset:17408
	ds_read_b32 v97, v17 offset:17472
	ds_read_b32 v100, v17 offset:19584
	ds_read_b32 v101, v17 offset:19648
	ds_read_b32 v104, v17 offset:21760
	ds_read_b32 v105, v17 offset:21824
	ds_read_b32 v108, v17 offset:23936
	ds_read_b32 v109, v17 offset:24000
	ds_read_b32 v112, v17 offset:26112
	ds_read_b32 v113, v17 offset:26176
	ds_read_b32 v116, v17 offset:28288
	ds_read_b32 v117, v17 offset:28352
	ds_read_b32 v120, v17 offset:30464
	ds_read_b32 v121, v17 offset:30528
	ds_read_b32 v124, v17 offset:32640
	ds_read_b32 v125, v17 offset:32704
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s16, -1
	s_mov_b32 s17, -1
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v96
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v64, s[8:9]
	global_atomic_add_f32 v6, v68, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v97
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v65, s[8:9]
	global_atomic_add_f32 v6, v69, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v98
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v72, s[8:9]
	global_atomic_add_f32 v6, v76, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v99
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v73, s[8:9]
	global_atomic_add_f32 v6, v77, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v100
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v80, s[8:9]
	global_atomic_add_f32 v6, v84, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v101
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v81, s[8:9]
	global_atomic_add_f32 v6, v85, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v102
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v88, s[8:9]
	global_atomic_add_f32 v6, v92, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v103
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v89, s[8:9]
	global_atomic_add_f32 v6, v93, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v104
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v96, s[8:9]
	global_atomic_add_f32 v6, v100, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v105
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v97, s[8:9]
	global_atomic_add_f32 v6, v101, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v106
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v104, s[8:9]
	global_atomic_add_f32 v6, v108, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v107
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v105, s[8:9]
	global_atomic_add_f32 v6, v109, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v108
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 24
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 25
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v112, s[8:9]
	global_atomic_add_f32 v6, v116, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v109
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 26
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 27
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v113, s[8:9]
	global_atomic_add_f32 v6, v117, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v110
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 28
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 29
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v120, s[8:9]
	global_atomic_add_f32 v6, v124, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v111
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 30
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 31
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v121, s[8:9]
	global_atomic_add_f32 v6, v125, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[66:67]
	ds_write_b64 v16, v[70:71] offset:4352
	ds_write_b64 v16, v[74:75] offset:8704
	ds_write_b64 v16, v[78:79] offset:13056
	ds_write_b64 v16, v[82:83] offset:17408
	ds_write_b64 v16, v[86:87] offset:21760
	ds_write_b64 v16, v[90:91] offset:26112
	ds_write_b64 v16, v[94:95] offset:30464
	ds_write_b64 v16, v[98:99] offset:2176
	ds_write_b64 v16, v[102:103] offset:6528
	ds_write_b64 v16, v[106:107] offset:10880
	ds_write_b64 v16, v[110:111] offset:15232
	ds_write_b64 v16, v[114:115] offset:19584
	ds_write_b64 v16, v[118:119] offset:23936
	ds_write_b64 v16, v[122:123] offset:28288
	ds_write_b64 v16, v[126:127] offset:32640
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v66, v17
	ds_read_b32 v67, v17 offset:64
	ds_read_b32 v70, v17 offset:2176
	ds_read_b32 v71, v17 offset:2240
	ds_read_b32 v74, v17 offset:4352
	ds_read_b32 v75, v17 offset:4416
	ds_read_b32 v78, v17 offset:6528
	ds_read_b32 v79, v17 offset:6592
	ds_read_b32 v82, v17 offset:8704
	ds_read_b32 v83, v17 offset:8768
	ds_read_b32 v86, v17 offset:10880
	ds_read_b32 v87, v17 offset:10944
	ds_read_b32 v90, v17 offset:13056
	ds_read_b32 v91, v17 offset:13120
	ds_read_b32 v94, v17 offset:15232
	ds_read_b32 v95, v17 offset:15296
	ds_read_b32 v98, v17 offset:17408
	ds_read_b32 v99, v17 offset:17472
	ds_read_b32 v102, v17 offset:19584
	ds_read_b32 v103, v17 offset:19648
	ds_read_b32 v106, v17 offset:21760
	ds_read_b32 v107, v17 offset:21824
	ds_read_b32 v110, v17 offset:23936
	ds_read_b32 v111, v17 offset:24000
	ds_read_b32 v114, v17 offset:26112
	ds_read_b32 v115, v17 offset:26176
	ds_read_b32 v118, v17 offset:28288
	ds_read_b32 v119, v17 offset:28352
	ds_read_b32 v122, v17 offset:30464
	ds_read_b32 v123, v17 offset:30528
	ds_read_b32 v126, v17 offset:32640
	ds_read_b32 v127, v17 offset:32704
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v96
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v66, s[8:9] offset:8
	global_atomic_add_f32 v6, v70, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v97
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v67, s[8:9] offset:8
	global_atomic_add_f32 v6, v71, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v98
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v74, s[8:9] offset:8
	global_atomic_add_f32 v6, v78, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v99
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v75, s[8:9] offset:8
	global_atomic_add_f32 v6, v79, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v100
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v82, s[8:9] offset:8
	global_atomic_add_f32 v6, v86, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v101
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v83, s[8:9] offset:8
	global_atomic_add_f32 v6, v87, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v102
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v90, s[8:9] offset:8
	global_atomic_add_f32 v6, v94, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v103
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v91, s[8:9] offset:8
	global_atomic_add_f32 v6, v95, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v104
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v98, s[8:9] offset:8
	global_atomic_add_f32 v6, v102, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v105
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v99, s[8:9] offset:8
	global_atomic_add_f32 v6, v103, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v106
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v106, s[8:9] offset:8
	global_atomic_add_f32 v6, v110, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v107
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v107, s[8:9] offset:8
	global_atomic_add_f32 v6, v111, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v108
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 24
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 25
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v114, s[8:9] offset:8
	global_atomic_add_f32 v6, v118, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v109
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 26
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 27
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v115, s[8:9] offset:8
	global_atomic_add_f32 v6, v119, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v110
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 28
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 29
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v122, s[8:9] offset:8
	global_atomic_add_f32 v6, v126, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v111
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 30
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 31
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v123, s[8:9] offset:8
	global_atomic_add_f32 v6, v127, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[128:129]
	ds_write_b64 v16, v[132:133] offset:4352
	ds_write_b64 v16, v[136:137] offset:8704
	ds_write_b64 v16, v[140:141] offset:13056
	ds_write_b64 v16, v[144:145] offset:17408
	ds_write_b64 v16, v[148:149] offset:21760
	ds_write_b64 v16, v[152:153] offset:26112
	ds_write_b64 v16, v[156:157] offset:30464
	ds_write_b64 v16, v[160:161] offset:2176
	ds_write_b64 v16, v[164:165] offset:6528
	ds_write_b64 v16, v[168:169] offset:10880
	ds_write_b64 v16, v[172:173] offset:15232
	ds_write_b64 v16, v[176:177] offset:19584
	ds_write_b64 v16, v[180:181] offset:23936
	ds_write_b64 v16, v[184:185] offset:28288
	ds_write_b64 v16, v[188:189] offset:32640
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v128, v17
	ds_read_b32 v129, v17 offset:64
	ds_read_b32 v132, v17 offset:2176
	ds_read_b32 v133, v17 offset:2240
	ds_read_b32 v136, v17 offset:4352
	ds_read_b32 v137, v17 offset:4416
	ds_read_b32 v140, v17 offset:6528
	ds_read_b32 v141, v17 offset:6592
	ds_read_b32 v144, v17 offset:8704
	ds_read_b32 v145, v17 offset:8768
	ds_read_b32 v148, v17 offset:10880
	ds_read_b32 v149, v17 offset:10944
	ds_read_b32 v152, v17 offset:13056
	ds_read_b32 v153, v17 offset:13120
	ds_read_b32 v156, v17 offset:15232
	ds_read_b32 v157, v17 offset:15296
	ds_read_b32 v160, v17 offset:17408
	ds_read_b32 v161, v17 offset:17472
	ds_read_b32 v164, v17 offset:19584
	ds_read_b32 v165, v17 offset:19648
	ds_read_b32 v168, v17 offset:21760
	ds_read_b32 v169, v17 offset:21824
	ds_read_b32 v172, v17 offset:23936
	ds_read_b32 v173, v17 offset:24000
	ds_read_b32 v176, v17 offset:26112
	ds_read_b32 v177, v17 offset:26176
	ds_read_b32 v180, v17 offset:28288
	ds_read_b32 v181, v17 offset:28352
	ds_read_b32 v184, v17 offset:30464
	ds_read_b32 v185, v17 offset:30528
	ds_read_b32 v188, v17 offset:32640
	ds_read_b32 v189, v17 offset:32704
	s_mul_i32 s52, s61, 4
	s_add_u32 s8, s52, s8
	s_addc_u32 s9, 0, s9
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v96
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v128, s[8:9]
	global_atomic_add_f32 v6, v132, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v97
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v129, s[8:9]
	global_atomic_add_f32 v6, v133, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v98
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v136, s[8:9]
	global_atomic_add_f32 v6, v140, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v99
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v137, s[8:9]
	global_atomic_add_f32 v6, v141, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v100
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v144, s[8:9]
	global_atomic_add_f32 v6, v148, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v101
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v145, s[8:9]
	global_atomic_add_f32 v6, v149, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v102
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v152, s[8:9]
	global_atomic_add_f32 v6, v156, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v103
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v153, s[8:9]
	global_atomic_add_f32 v6, v157, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v104
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v160, s[8:9]
	global_atomic_add_f32 v6, v164, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v105
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v161, s[8:9]
	global_atomic_add_f32 v6, v165, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v106
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v168, s[8:9]
	global_atomic_add_f32 v6, v172, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v107
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v169, s[8:9]
	global_atomic_add_f32 v6, v173, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v108
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 24
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 25
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v176, s[8:9]
	global_atomic_add_f32 v6, v180, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v109
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 26
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 27
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v177, s[8:9]
	global_atomic_add_f32 v6, v181, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v110
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 28
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 29
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v184, s[8:9]
	global_atomic_add_f32 v6, v188, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v111
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 30
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 31
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v185, s[8:9]
	global_atomic_add_f32 v6, v189, s[8:9] offset:256
	s_mov_b64 exec, s[16:17]
	ds_write_b64 v16, v[130:131]
	ds_write_b64 v16, v[134:135] offset:4352
	ds_write_b64 v16, v[138:139] offset:8704
	ds_write_b64 v16, v[142:143] offset:13056
	ds_write_b64 v16, v[146:147] offset:17408
	ds_write_b64 v16, v[150:151] offset:21760
	ds_write_b64 v16, v[154:155] offset:26112
	ds_write_b64 v16, v[158:159] offset:30464
	ds_write_b64 v16, v[162:163] offset:2176
	ds_write_b64 v16, v[166:167] offset:6528
	ds_write_b64 v16, v[170:171] offset:10880
	ds_write_b64 v16, v[174:175] offset:15232
	ds_write_b64 v16, v[178:179] offset:19584
	ds_write_b64 v16, v[182:183] offset:23936
	ds_write_b64 v16, v[186:187] offset:28288
	ds_write_b64 v16, v[190:191] offset:32640
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b32 v130, v17
	ds_read_b32 v131, v17 offset:64
	ds_read_b32 v134, v17 offset:2176
	ds_read_b32 v135, v17 offset:2240
	ds_read_b32 v138, v17 offset:4352
	ds_read_b32 v139, v17 offset:4416
	ds_read_b32 v142, v17 offset:6528
	ds_read_b32 v143, v17 offset:6592
	ds_read_b32 v146, v17 offset:8704
	ds_read_b32 v147, v17 offset:8768
	ds_read_b32 v150, v17 offset:10880
	ds_read_b32 v151, v17 offset:10944
	ds_read_b32 v154, v17 offset:13056
	ds_read_b32 v155, v17 offset:13120
	ds_read_b32 v158, v17 offset:15232
	ds_read_b32 v159, v17 offset:15296
	ds_read_b32 v162, v17 offset:17408
	ds_read_b32 v163, v17 offset:17472
	ds_read_b32 v166, v17 offset:19584
	ds_read_b32 v167, v17 offset:19648
	ds_read_b32 v170, v17 offset:21760
	ds_read_b32 v171, v17 offset:21824
	ds_read_b32 v174, v17 offset:23936
	ds_read_b32 v175, v17 offset:24000
	ds_read_b32 v178, v17 offset:26112
	ds_read_b32 v179, v17 offset:26176
	ds_read_b32 v182, v17 offset:28288
	ds_read_b32 v183, v17 offset:28352
	ds_read_b32 v186, v17 offset:30464
	ds_read_b32 v187, v17 offset:30528
	ds_read_b32 v190, v17 offset:32640
	ds_read_b32 v191, v17 offset:32704
	s_waitcnt lgkmcnt(0)
	v_mov_b32_e32 v7, 0
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v96
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 0
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 1
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v130, s[8:9] offset:8
	global_atomic_add_f32 v6, v134, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v97
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 2
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 3
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v131, s[8:9] offset:8
	global_atomic_add_f32 v6, v135, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v98
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 4
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 5
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v138, s[8:9] offset:8
	global_atomic_add_f32 v6, v142, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v99
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 6
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 7
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v139, s[8:9] offset:8
	global_atomic_add_f32 v6, v143, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v100
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 8
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 9
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v146, s[8:9] offset:8
	global_atomic_add_f32 v6, v150, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v101
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 10
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 11
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v147, s[8:9] offset:8
	global_atomic_add_f32 v6, v151, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v102
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 12
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 13
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v154, s[8:9] offset:8
	global_atomic_add_f32 v6, v158, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v103
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 14
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 15
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v155, s[8:9] offset:8
	global_atomic_add_f32 v6, v159, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v104
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 16
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 17
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v162, s[8:9] offset:8
	global_atomic_add_f32 v6, v166, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v105
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 18
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 19
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v163, s[8:9] offset:8
	global_atomic_add_f32 v6, v167, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v106
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 20
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 21
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v170, s[8:9] offset:8
	global_atomic_add_f32 v6, v174, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v107
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 22
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 23
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v171, s[8:9] offset:8
	global_atomic_add_f32 v6, v175, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v108
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 24
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 25
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v178, s[8:9] offset:8
	global_atomic_add_f32 v6, v182, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v109
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 26
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 27
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v179, s[8:9] offset:8
	global_atomic_add_f32 v6, v183, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v110
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 28
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 29
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v186, s[8:9] offset:8
	global_atomic_add_f32 v6, v190, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	v_mov_b32_e32 v6, v111
	s_mov_b64 s[52:53], 0
	v_readlane_b32 s72, v3, 30
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s20, s16, s52
	v_readlane_b32 s72, v3, 31
	s_cmp_lt_u32 s72, s62
	s_cselect_b32 s21, s16, s52
	s_mov_b64 exec, s[20:21]
	global_atomic_add_f32 v6, v187, s[8:9] offset:8
	global_atomic_add_f32 v6, v191, s[8:9] offset:264
	s_mov_b64 exec, s[16:17]
	s_branch label_2072

000000000000aabc <label_2072>:
	s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
	s_endpgm
