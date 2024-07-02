; ModuleID = 'lowered.ll'
source_filename = "LLVMDialectModule"

declare <8 x i64> @_Z10getExpBf16Dv16_u6__bf16(<16 x bfloat>) local_unnamed_addr

; Function Attrs: nofree nounwind memory(inaccessiblemem: read)
declare <16 x bfloat> @llvm.aie2.v16accfloat.to.v16bf16(<8 x i64>) #0

define void @dut(ptr nocapture readnone %0, ptr noalias %1, i64 %2, i64 %3, i64 %4, ptr nocapture readnone %5, ptr noalias %6, i64 %7, i64 %8, i64 %9) local_unnamed_addr {
  %11 = ptrtoint ptr %1 to i64
  %12 = and i64 %11, 31
  %13 = icmp eq i64 %12, 0
  tail call void @llvm.assume(i1 %13)
  %14 = ptrtoint ptr %6 to i64
  %15 = and i64 %14, 31
  %16 = icmp eq i64 %15, 0
  tail call void @llvm.assume(i1 %16)
  br label %17

17:                                               ; preds = %10, %17
  %18 = phi i64 [ 0, %10 ], [ %24, %17 ]
  %19 = getelementptr bfloat, ptr %1, i64 %18
  %20 = load <16 x bfloat>, ptr %19, align 32
  %21 = tail call <8 x i64> @_Z10getExpBf16Dv16_u6__bf16(<16 x bfloat> %20)
  %22 = tail call <16 x bfloat> @llvm.aie2.v16accfloat.to.v16bf16(<8 x i64> %21)
  %23 = getelementptr bfloat, ptr %6, i64 %18
  store <16 x bfloat> %22, ptr %23, align 32
  %24 = add nuw nsw i64 %18, 16
  %25 = icmp ult i64 %18, 1008
  br i1 %25, label %17, label %26

26:                                               ; preds = %17
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #1

attributes #0 = { nofree nounwind memory(inaccessiblemem: read) }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
