; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare <8 x i64> @_Z10getExpBf16Dv16_u6__bf16(<16 x bfloat>)

declare <16 x bfloat> @llvm.aie2.v16accfloat.to.v16bf16(<8 x i64>)

define void @dut(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, ptr %5, ptr %6, i64 %7, i64 %8, i64 %9) {
  %11 = ptrtoint ptr %1 to i64
  %12 = and i64 %11, 31
  %13 = icmp eq i64 %12, 0
  call void @llvm.assume(i1 %13)
  %14 = ptrtoint ptr %6 to i64
  %15 = and i64 %14, 31
  %16 = icmp eq i64 %15, 0
  call void @llvm.assume(i1 %16)
  br label %17

17:                                               ; preds = %20, %10
  %18 = phi i64 [ %26, %20 ], [ 0, %10 ]
  %19 = icmp slt i64 %18, 1024
  br i1 %19, label %20, label %27

20:                                               ; preds = %17
  %21 = getelementptr bfloat, ptr %1, i64 %18
  %22 = load <16 x bfloat>, ptr %21, align 2
  %23 = call <8 x i64> @_Z10getExpBf16Dv16_u6__bf16(<16 x bfloat> %22)
  %24 = call <16 x bfloat> @llvm.aie2.v16accfloat.to.v16bf16(<8 x i64> %23)
  %25 = getelementptr bfloat, ptr %6, i64 %18
  store <16 x bfloat> %24, ptr %25, align 2
  %26 = add i64 %18, 16
  br label %17

27:                                               ; preds = %17
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
