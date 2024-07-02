module {
  llvm.func @_Z10getExpBf16Dv16_u6__bf16(vector<16xbf16>) -> vector<8xi64> attributes {sym_visibility = "private"}
  llvm.func @llvm.aie2.v16accfloat.to.v16bf16(vector<8xi64>) -> vector<16xbf16> attributes {sym_visibility = "private"}
  llvm.func @dut(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64) {
    %0 = llvm.mlir.constant(31 : index) : i64
    %1 = llvm.mlir.constant(16 : index) : i64
    %2 = llvm.mlir.constant(1024 : index) : i64
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %5 = llvm.and %4, %0  : i64
    %6 = llvm.icmp "eq" %5, %3 : i64
    "llvm.intr.assume"(%6) : (i1) -> ()
    %7 = llvm.ptrtoint %arg6 : !llvm.ptr to i64
    %8 = llvm.and %7, %0  : i64
    %9 = llvm.icmp "eq" %8, %3 : i64
    "llvm.intr.assume"(%9) : (i1) -> ()
    llvm.br ^bb1(%3 : i64)
  ^bb1(%10: i64):  // 2 preds: ^bb0, ^bb2
    %11 = llvm.icmp "slt" %10, %2 : i64
    llvm.cond_br %11, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %12 = llvm.getelementptr %arg1[%10] : (!llvm.ptr, i64) -> !llvm.ptr, bf16
    %13 = llvm.load %12 {alignment = 2 : i64} : !llvm.ptr -> vector<16xbf16>
    %14 = llvm.call @_Z10getExpBf16Dv16_u6__bf16(%13) : (vector<16xbf16>) -> vector<8xi64>
    %15 = llvm.call @llvm.aie2.v16accfloat.to.v16bf16(%14) : (vector<8xi64>) -> vector<16xbf16>
    %16 = llvm.getelementptr %arg6[%10] : (!llvm.ptr, i64) -> !llvm.ptr, bf16
    llvm.store %15, %16 {alignment = 2 : i64} : vector<16xbf16>, !llvm.ptr
    %17 = llvm.add %10, %1 : i64
    llvm.br ^bb1(%17 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}

