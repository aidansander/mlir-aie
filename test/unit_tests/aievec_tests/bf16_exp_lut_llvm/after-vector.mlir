module {
  emitc.include "lut_based_ops.h"
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
      %1 = builtin.unrealized_conversion_cast %0 : vector<16xbf16> to !emitc.opaque<"v16bfloat16">
      %2 = emitc.call_opaque "getExpBf16"(%1) : (!emitc.opaque<"v16bfloat16">) -> !emitc.opaque<"v16accfloat">
      %3 = builtin.unrealized_conversion_cast %2 : !emitc.opaque<"v16accfloat"> to vector<16xf32>
      %4 = aievec.srs %3, %c0_i32 : vector<16xf32>, i32, vector<16xbf16>
      vector.transfer_write %4, %arg1[%arg2] {in_bounds = [true]} : vector<16xbf16>, memref<1024xbf16>
    }
    return
  }
}

