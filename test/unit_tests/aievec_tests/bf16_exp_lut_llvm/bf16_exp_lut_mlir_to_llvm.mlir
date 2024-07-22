// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Copyright (C) 2023, Advanced Micro Devices, Inc.

// REQUIRES: valid_xchess_license
// REQUIRES: peano
// RUN: mkdir -p %t/data; cd %t
// RUN: aie-opt %s -affine-super-vectorize="virtual-vector-size=16" %vector-to-llvmir% -o llvmir.mlir
// RUN: aie-translate --mlir-to-llvmir llvmir.mlir -o dut_part.ll
// RUN: cp %S/lut_based_ops.ll .
// RUN: cp %S/dut_simple.ll .
// RUN: llvm-link -S lut_based_ops.ll dut_part.ll -o dut_lut.ll
// RUN: llvm-link -S dut_lut.ll dut_simple.ll -o dut.ll
// RUN: %PEANO_INSTALL_DIR/bin/clang %clang_aie2_args -c dut.ll -o dut.o
// RUN: xchesscc_wrapper aie2 -f -g +s +w work +o work -I%S -I%aie_runtime_lib%/AIE2 -I %aietools/include -D__AIEARCH__=20 -D__AIENGINE__ -I. %S/testbench.cc dut.o 
// RUN: xca_udm_dbg --aiearch aie-ml -qf -T -P %aietools/data/aie_ml/lib/ -t "%S/../profiling.tcl ./work/a.out" >& xca_udm_dbg.stdout
// RUN: FileCheck --input-file=./xca_udm_dbg.stdout %s
// CHECK: TEST PASSED

module {
  func.func @dut(%arg0: memref<1024xbf16>, %arg1: memref<1024xbf16>) {
    memref.assume_alignment %arg0, 32 : memref<1024xbf16>
    memref.assume_alignment %arg1, 32 : memref<1024xbf16>
    affine.for %arg3 = 0 to 1024 {
      %0 = affine.load %arg0[%arg3] : memref<1024xbf16>
      %1 = math.exp %0 : bf16
      affine.store %1, %arg1[%arg3] : memref<1024xbf16>
    }
    return
  }
}
