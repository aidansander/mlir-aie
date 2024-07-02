; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare <8 x i64> @_Z10getExpBf16Dv16_u6__bf16(<16 x bfloat>)

declare <16 x bfloat> @llvm.aie2.v16accfloat.to.v16bf16(<8 x i64>)

define void @dut(ptr %0, ptr %1) {
  %3 = ptrtoint ptr %0 to i64
  %4 = and i64 %3, 31
  %5 = icmp eq i64 %4, 0
  call void @llvm.assume(i1 %5)
  %6 = ptrtoint ptr %1 to i64
  %7 = and i64 %6, 31
  %8 = icmp eq i64 %7, 0
  call void @llvm.assume(i1 %8)
  br label %9

9:                                                ; preds = %12, %2
  %10 = phi i64 [ %18, %12 ], [ 0, %2 ]
  %11 = icmp slt i64 %10, 1024
  br i1 %11, label %12, label %19

12:                                               ; preds = %9
  %13 = getelementptr bfloat, ptr %0, i64 %10
  %14 = load <16 x bfloat>, ptr %13, align 2
  %15 = call <8 x i64> @_Z10getExpBf16Dv16_u6__bf16(<16 x bfloat> %14)
  %16 = call <16 x bfloat> @llvm.aie2.v16accfloat.to.v16bf16(<8 x i64> %15)
  %17 = getelementptr bfloat, ptr %1, i64 %10
  store <16 x bfloat> %16, ptr %17, align 2
  %18 = add i64 %10, 16
  br label %9

19:                                               ; preds = %9
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
