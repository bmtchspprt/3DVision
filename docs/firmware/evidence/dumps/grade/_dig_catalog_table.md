| Dig dump | Bytes | First-line purpose (from dump header) |
|----------|------:|----------------------------------------|
| `dig_07420_entry_arena.txt` | 9788 | ===== 20207420 entry through MOVE R7=P4 ===== |
| `dig_147a_dma_count_near_start.txt` | 30454 | Hunt 0x147A / 0x28F4 / 0xA4A as DMA X_COUNT near START programming |
| `dig_147b_memcpy_grade_dest.txt` | 57437 | ===== IMM Grade-length sites (0x147A/B, 0x28F4) ===== |
| `dig_15060_writers_07c24.txt` | 27718 | ===== ALL 0x5060 / 0x15060 materializations ===== |
| `dig_2020bb32_grade_cand.txt` | 10902 | ===== 2020BA80..2020BD00 ===== |
| `dig_20211d_grade_memcpy.txt` | 19797 | ===== FULL 0x20211C00..0x20212080 ===== |
| `dig_20211d26_before_memset.txt` | 3894 | 20211D26 STORE [P5+0x44]=R0 immediately before Grade memset â€” what is R0? |
| `dig_20212a64_between_emit.txt` | 10964 | 0x20212A64 called from FFA0487A between convert and Grade emit â€” classify |
| `dig_20212c_float_convert_chain.txt` | 17720 | ===== ENTRY + FULL body around 0x20212C5E ===== |
| `dig_20212c5e_convert_loop.txt` | 7644 | ===== 20212C20..20212D40 convert loop ===== |
| `dig_20220b2e_f330_args.txt` | 2605 | Deep context for CALL 0x2020F330 @ 0x20220B2E â€” resolve R0/R1/R2/stack count |
| `dig_20220b2e_walk.txt` | 6417 | ===== Walk to CALL and 40 after ===== |
| `dig_20224500_full.txt` | 23299 | Full disasm 0x20224200..0x20224800 â€” hunt Grade twin of False E fill |
| `dig_2022d2a8_ffa0bf.txt` | 12652 | ===== FIND ENTRY + FULL 0x2022D2A8 region ===== |
| `dig_2022d7ce_grade_ptr_use.txt` | 18120 | ===== FN containing 0x2022D7CE ===== |
| `dig_579c_and_ffa043c4.txt` | 31751 | ===== LOAD/STORE of imm 0x579c / 0x579C ===== |
| `dig_acquire_call_p1_targets.txt` | 2268 | Resolve CALL (P1) absolute targets in acquire 0x20220636..0x20221100 |
| `dig_acquire_call_targets_grade.txt` | 3261 | ===== CALL targets in acquire 20220636..20221100 ===== |
| `dig_acquire_entry_fp3c.txt` | 3402 | Acquire entry through STORE FP-0x3c â€” what is P1? |
| `dig_all_ffa07a84_and_r5.txt` | 7277 | ===== All refs to 0x7a84 / FFA07A84 ===== |
| `dig_alloc_081a4_softinstall.txt` | 10668 | ===== 0x202081A4 full (buffer alloc? returns R0 -> soft+0x14) ===== |
| `dig_alt_dma_start_paths.txt` | 35048 | ===== FFA07C14 full ===== |
| `dig_arena_soft14_grade.txt` | 10379 | Near 0x578 / arena setup: STORE [P+0x14] that might bind Grade to soft-desc |
| `dig_beam_1770_writers.txt` | 10891 | LAYOUT: Grade=[beam+0x44 .. beam+0x2938); pulse slot beam+0x1770 IS INSIDE that span |
| `dig_beam_init_hwdesc_grade.txt` | 1429 | ===== Back to LINK from 20211D5C ===== |
| `dig_between_convert_and_emit.txt` | 18402 | FFA0467E: from CALL convert (after P1=0x2022d05e) until FFA04B90 Grade emit |
| `dig_bufptr_076d8.txt` | 34344 | ===== 20207400..07A00 DMA soft-struct setup ===== |
| `dig_bypass_start_channel_obj.txt` | 214071 | Hunt STORE [*+0x8]/[*+0x4] that may program MDMA START without FFA07A84 |
| `dig_callers_07a84.txt` | 4161 | ===== CALLERS of DMA START program helpers ===== |
| `dig_callers_20207774.txt` | 13773 | 0x20207774: soft-desc at FF804708+idx; STORE [desc+0x14]=R0; later FFA0BF14 START |
| `dig_callers_2020f330.txt` | 2794 | All CALL sites to 0x2020F330 / motif P1=0x2020F330 â€” dump arg setup |
| `dig_callers_ffa0bf14_start.txt` | 20467 | FFA0BF14 = DMA SM case 2 = FFA1040A = CALL FFA07A84 with R1=[P5+0x14] buffer |
| `dig_cand_202b5066_p5ptr14.txt` | 32805 | ===== FUN 0x202B5066 ===== |
| `dig_completion_irq_ffa02a.txt` | 9742 | ===== Function back to LINK from FFA02AB2 ===== |
| `dig_convert_2022d05e_full.txt` | 10362 | ===== FULL convert 0x2022D05E (until RTS) ===== |
| `dig_correlator_dest_grade.txt` | 12222 | FFA03C8A correlator â€” stores and callers; can dest be Grade? |
| `dig_correlator_out_dma_start_reg.txt` | 73061 | ===== FFA03C8A correlator (STORE / ptr args) ===== |
| `dig_ctrl_202060dc_plus14.txt` | 3286 | At 20205832: R2=0x202060DC passed into FFA0BF14; SM uses P5=R2; START buf=[P5+0x14] |
| `dig_desc_5bc_consumers.txt` | 70586 | ===== BM4 PACKER AROUND 0x202B5202 ===== |
| `dig_desc_buf_field_writers.txt` | 70766 | ===== FFA07A80 START program full ===== |
| `dig_direct_mdma_start_pokes.txt` | 24796 | ===== DMA registry FF803690 ===== |
| `dig_dma_043c4_fill.txt` | 134311 | ===== FFA043C4 beam float mix full ===== |
| `dig_dma_enable_before_convert.txt` | 34176 | ===== Callers of DMA soft helpers ===== |
| `dig_dma_jumptable_hwdesc.txt` | 5071 | ===== Jump table @ FF803BDC (16 entries?) ===== |
| `dig_dma_start_via_desc8.txt` | 15801 | ===== LOAD [P+0x8] then STORE [same-ish P] within 12 insn ===== |
| `dig_emit_prologue_wrapper.txt` | 15672 | ===== EMIT 0x2022E118 until convert/RTS ===== |
| `dig_falsee_caller_grade_twin.txt` | 22500 | False E. fill lives ~0x202246F0. Dump containing fn + callers; hunt twin Grade fill nearby. |
| `dig_falsee_pattern_twin_grade.txt` | 6082 | ===== PROVEN False E. fill 0x202246F0..0x20224726 ===== |
| `dig_ffa077ee_0bb32.txt` | 8756 | ===== FFA077E0..FFA07880 (soft init + 0x44) ===== |
| `dig_ffa100d4_convention.txt` | 24166 | ===== FFA100D4 full (DMA SM entry) ===== |
| `dig_ffa103_dma_statemachine.txt` | 20258 | ===== LINK walk back from FFA10318 ===== |
| `dig_ffa104_07a84_reach.txt` | 7600 | ===== L1 0xFFA10400..0xFFA10580 ===== |
| `dig_flag_806ee0_writers.txt` | 20216 | FFA06008 polls FF806EE0 â€” find who STOREs to it (completion signal) |
| `dig_float_grade_writers_all.txt` | 10698 | All materializations of 0x5060 / 0x15060 (float Grade workbuf) |
| `dig_float_grade_writers_emit_order.txt` | 11143 | ===== SITES loading 0x5060 (float Grade @0x20215060) ===== |
| `dig_generic_storew_helpers.txt` | 205 | Find small helpers: early MOVE P0=R0 then LSETUP STORE W [P0++] |
| `dig_grade_dma_pivot.txt` | 62231 | ===== FFA10300..10480 START dispatcher ===== |
| `dig_grade_fill_next.txt` | 57838 | ===== 202B5380 packer/acquire wrap ===== |
| `dig_grade_ptr_install_anywhere.txt` | 59668 | Find all sites that COMPUTE beam+0x44 (or arena+0x5BC) and STORE the pointer somewhere |
| `dig_grade_ptr_uses.txt` | 9900 | ===== Materializations of 0x5d04 / 0x25d04 ===== |
| `dig_hwdesc_buf_fields.txt` | 73202 | ===== STORE W [P+0x2] with ptr-ish context (578/44/5cfc/ff80/202) ===== |
| `dig_hwdesc_start_halfword_writers.txt` | 27785 | FFA07C14/FFA0816A rebuild START from W[desc+0x4]<<16 / W[desc+0x2] |
| `dig_irq_vectors_dma_sm.txt` | 2000 | ===== Scan for EVT-like tables pointing at FFA0BFxx / FFA100xx / FFA07xxx ===== |
| `dig_jump_07a84.txt` | 4327 | ===== JUMP/CALL (P1) resolving to FFA07A84..07B40 ===== |
| `dig_jump_p1_acquire.txt` | 1365 | JUMP (P1) / JUMP.L (P1) in pulse+acquire windows â€” resolve table targets |
| `dig_l1_to_grade_copy.txt` | 4903 | Hypothesis: DMA fills L1 FF803EA0 (soft FF8046A0+0x14), then CPU copies to beam+0x44 |
| `dig_load44_dma_store.txt` | 8878 | ===== LOAD = 0x44 then within 30: ADD then STORE ptr-sized (not STORE W to +0x44) ===== |
| `dig_loaded_offset_grade_store.txt` | 3470 | Hunt: LOAD offset from mem (not imm 0x44), ADD to beam/arena, STORE W loop |
| `dig_matched_desc_origin.txt` | 36307 | ===== 20207EB6 desc builder ===== |
| `dig_mdma_ppi_grade_len.txt` | 59421 | ===== 0x147a/0x28f4 then DMA-ish STORE/CALL ===== |
| `dig_memcpy_grade_len.txt` | 103389 | ===== CALLS to memset/memcpy family with Grade-len imms in -40 ===== |
| `dig_outer_acquire_5bc.txt` | 8295 | ===== IMM 0x5bc / 0x05BC materializations ===== |
| `dig_outer_acquire_fill_loops.txt` | 18022 | ===== SITE 20224700 (back 40 + forward 35) ===== |
| `dig_outer_preacquire_calls.txt` | 1185 | ===== CALLS 0x20224000..0x20224130 ===== |
| `dig_peakobj_grade_ptr_consumers.txt` | 4825 | Peak obj 0x20225D04: +0x8 = grade_ptr (proven at FFA0393E); +0x14 = meta |
| `dig_peakobj_grade_writers.txt` | 1529 | ===== materialize 0x5d04 / 0x25d04 ===== |
| `dig_pre_bm4_fill_window.txt` | 21514 | ===== TIMING: Grade must exist before 0x20220EF0 (bm4 packer) ===== |
| `dig_preacquire_and_peak_caller.txt` | 12532 | ===== CALLERS of acquire 0x20220636 ===== |
| `dig_preacquire_grade_store.txt` | 42604 | ===== After grade-ptr ADD (0x44+0x578): next action ===== |
| `dig_preconvert_storew_07a84deep.txt` | 44963 | ===== FFA07A84 extended (200 insn) ===== |
| `dig_preconvert_timeline.txt` | 9506 | ===== ACQUIRE 0x20220636 CALL TIMELINE until first convert-family ===== |
| `dig_preemit_acquire_fill.txt` | 21588 | ===== LSETUP-2022083c ===== |
| `dig_pulse_afe_alt_start.txt` | 14325 | ===== FFA070E0..FFA07200 (DMA MMR poke helpers) ===== |
| `dig_pulse_ec5de_dma_wait.txt` | 14662 | ===== FULL 0x202EC5DE ===== |
| `dig_pulse_memcpy_into_grade_span.txt` | 22978 | ===== FFA05F92 memcpy prologue (args) ===== |
| `dig_runtime_dest_storew.txt` | 55033 | LSETUP + STORE W where dest base may come from object field (no local imm 0x44) |
| `dig_runtime_len_hop.txt` | 193310 | ===== ALL CALL => FFA05F92 (memcpy) ===== |
| `dig_soft_46a0_consumers.txt` | 8820 | ===== 20203c4e (back 30 + fwd 40) ===== |
| `dig_soft14_overwrite_deep_acq.txt` | 37809 | ===== L1 soft+0x14 STORE with prior 40 (DMA soft-desc band) ===== |
| `dig_soft14_writers_irq_fills.txt` | 85862 | ===== ALL STORE [P+0x14] (excl SP/FP) ===== |
| `dig_softdesc_586c_e876.txt` | 39270 | ===== FFA0763C soft-desc walker extended ===== |
| `dig_softdesc_buf_installers.txt` | 22224 | ===== WRAP ffa0bf00 ===== |
| `dig_softdesc_bufptrs_image.txt` | 3582 | ===== Known soft-desc field dump ===== |
| `dig_softdesc_start_grade_compute.txt` | 9600 | ===== 0x44 compute then soft-desc START program ===== |
| `dig_sqrt_acq_02894.txt` | 41942 | ===== acquire around sqrt 20220d42 ===== |
| `dig_startaddr_buffers.txt` | 19933 | ===== 2020ED00..F100 START_ADDR write region ===== |
| `dig_store_p14_beam.txt` | 10984 | ===== STORE [P+0x14] with 578/44/5cfc/5bc in -40 ===== |
| `dig_store_plus44_sites.txt` | 36728 | ===== STORE +0x44 @20205ae4 ===== |
| `dig_suspect_fill_helpers.txt` | 34043 | ===== callee-20210be6 @20210be6 ===== |
| `dig_unknown_acquire_targets.txt` | 4887 | ========== 2020f330 ========== |
| `dig_word_store_grade_span.txt` | 64209 | Word STORE loops that might fill Grade span (as float/int32) without STORE W |

