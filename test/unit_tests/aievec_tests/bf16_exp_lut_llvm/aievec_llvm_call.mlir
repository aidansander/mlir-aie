// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Copyright (C) 2024, Advanced Micro Devices, Inc.

// REQUIRES: valid_xchess_license
// REQUIRES: peano
// RUN: mkdir -p %t/data; cd %t
// RUN: aie-opt %s %vector-to-llvmir% -o llvmir.mlir
// RUN: aie-translate llvmir.mlir %llvmir-to-ll% -o mlir-part.ll
// RUN: cp %S/dut_simple.ll .
// RUN: cp %S/lut_based_ops.ll .
// RUN: llvm-link -S mlir-part.ll dut_simple.ll lut_based_ops.ll -o dut.ll
// RUN: %PEANO_INSTALL_DIR/bin/clang %clang_aie2_args -c dut.ll -o dut.o
// RUN: xchesscc_wrapper %xchesscc_aie2_args -DTO_LLVM +w work +o work -I%S -I. %S/testbench.cc dut.o
// RUN: xca_udm_dbg --aiearch aie-ml -qf -T -P %aietools/data/aie_ml/lib/ -t "%S/../profiling.tcl ./work/a.out" >& xca_udm_dbg.stdout
// RUN: FileCheck --input-file=./xca_udm_dbg.stdout %s
// CHECK: TEST PASSED

module {
  func.func private @_Z10getExpBf16Dv16_u6__bf16(vector<16xbf16>) -> vector<8xi64>
  func.func private @llvm.aie2.v16accfloat.to.v16bf16(vector<8xi64>) -> vector<16xbf16>
  func.func @dut(%arg0: memref<1024xbf16>, %arg1: memref<1024xbf16>) {
    %c0_i32 = arith.constant 0 : i32
    %cst = arith.constant 0.000000e+00 : bf16
    memref.assume_alignment %arg0, 32 : memref<1024xbf16>
    memref.assume_alignment %arg1, 32 : memref<1024xbf16>
    %c0 = arith.constant 0 : index
    %c1024 = arith.constant 1024 : index
    %c16 = arith.constant 16 : index
    scf.for %arg2 = %c0 to %c1024 step %c16 {
      %0 = vector.transfer_read %arg0[%arg2], %cst {in_bounds = [true]} : memref<1024xbf16>, vector<16xbf16>
      %1 = func.call @_Z10getExpBf16Dv16_u6__bf16(%0) : (vector<16xbf16>) -> vector<8xi64>
      %4 = func.call @llvm.aie2.v16accfloat.to.v16bf16(%1) : (vector<8xi64>)->vector<16xbf16>
      vector.transfer_write %4, %arg1[%arg2] {in_bounds = [true]} : vector<16xbf16>, memref<1024xbf16>
    }
    return
  }
}

