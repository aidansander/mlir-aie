//===- test.cpp -------------------------------------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// (c) Copyright 2021 Xilinx Inc.
//
//===----------------------------------------------------------------------===//

#include "test_library.h"
#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstring>
#include <fcntl.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <thread>
#include <unistd.h>
#include <xaiengine.h>

#include "aie_inc.cpp"

int main(int argc, char *argv[]) {
  int n = 1;
  u32 pc0_times[n];
  u32 pc1_times[n];
  u32 pc2_times[n];

  printf("13_Program_Counter test start.\n");
  printf("Running %d times ...\n", n);

  int total_errors = 0;

  auto col = 7;

  for (int iters = 0; iters < n; iters++) {

    aie_libxaie_ctx_t *_xaie = mlir_aie_init_libxaie();
    mlir_aie_init_device(_xaie);
    mlir_aie_configure_cores(_xaie);
    mlir_aie_configure_switchboxes(_xaie);
    mlir_aie_initialize_locks(_xaie);
    mlir_aie_configure_dmas(_xaie);

    // EventMonitor pc0(&TileInst[7][3], 0, XAIETILE_EVENT_CORE_ACTIVE,
    // XAIETILE_EVENT_CORE_DISABLED, XAIETILE_EVENT_CORE_NONE, MODE_CORE);
    // pc0.set();

    XAie_EventPCEnable(&(_xaie->DevInst), XAie_TileLoc(7, 3), 0, 0x00);
    XAie_EventPCEnable(&(_xaie->DevInst), XAie_TileLoc(7, 3), 1, 0x088);

    EventMonitor pc1(_xaie, 7, 3, 1, XAIE_EVENT_PC_0_CORE, XAIE_EVENT_PC_1_CORE,
                     XAIE_EVENT_NONE_CORE, XAIE_CORE_MOD);
    pc1.set();

    mlir_aie_print_tile_status(_xaie, 7, 3);

    mlir_aie_start_cores(_xaie);

    u64 tileAddr = mlir_aie_get_tile_addr(_xaie, 7, 3);
    u_int32_t pc0_reg = mlir_aie_read32(_xaie, tileAddr + 0x32020);
    u_int32_t pc1_reg = mlir_aie_read32(_xaie, tileAddr + 0x32024);
    u_int32_t event_status = mlir_aie_read32(_xaie, tileAddr + 0x34200);

    // printf("\n PC0 and PC1: %x, %x \n", pc0_reg, pc1_reg);
    printf("\n Event Status: %x\n", event_status);

    mlir_aie_print_tile_status(_xaie, 7, 3);
    // printf("PC0: %x ", pc0.diff());
    pc1_times[iters] = pc1.diff();

    mlir_aie_deinit_libxaie(_xaie);
  }

  computeStats(pc1_times, n);
}