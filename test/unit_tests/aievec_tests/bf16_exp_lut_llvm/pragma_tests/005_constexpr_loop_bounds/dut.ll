; ModuleID = 'dut.cc'
source_filename = "dut.cc"
target datalayout = "e-m:e-p:20:32-i1:8:32-i8:8:32-i16:16:32-i32:32:32-f32:32:32-i64:32-f64:32-a:0:32-n32"
target triple = "aie2"

@exp_ilut_ab = external dso_local global [512 x i16], align 32
@exp_ilut_cd = external dso_local global [512 x i16], align 32
@exp_flut_ab = external dso_local global [512 x i16], align 32
@exp_flut_cd = external dso_local global [512 x i16], align 32
@m_inv_lut = external dso_local local_unnamed_addr global [128 x i8], align 32

; Function Attrs: alwaysinline mustprogress nofree nounwind willreturn memory(read)
define dso_local noundef <8 x i64> @_Z10getExpBf16Dv16_u6__bf16(<16 x bfloat> noundef %0) local_unnamed_addr #0 {
  %2 = tail call noundef <16 x i32> @llvm.aie2.v16int32()
  %3 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 1023)
  %4 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 0)
  %5 = tail call noundef <16 x bfloat> @llvm.aie2.v16bfloat16()
  %6 = tail call noundef <8 x i64> @llvm.aie2.v16accfloat()
  %7 = tail call noundef <16 x i32> @llvm.aie2.v16bf16.to.v16i32(<16 x bfloat> %0, i32 8)
  %8 = tail call noundef <32 x i16> @llvm.aie2.v32int16()
  %9 = bitcast <32 x i16> %8 to <16 x i32>
  %10 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %7, <16 x i32> %9, i32 2)
  %11 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %10, i32 0)
  %12 = bitcast <8 x i32> %11 to <16 x i16>
  %13 = tail call noundef <32 x bfloat> @llvm.aie2.v32bfloat16()
  %14 = tail call noundef <16 x i64> @llvm.aie2.v16acc64()
  %15 = tail call noundef <16 x i64> @llvm.aie2.acc64.v16.I256.ups(<16 x i16> %12, i32 0, i32 0)
  %16 = tail call noundef <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64> %15, i32 6, i32 1)
  %17 = zext i20 ptrtoint (ptr @exp_ilut_ab to i20) to i32
  %18 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 %17)
  %19 = zext i20 ptrtoint (ptr @exp_ilut_cd to i20) to i32
  %20 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 %19)
  %21 = tail call noundef <16 x i32> @llvm.aie2.vsel32(<16 x i32> %18, <16 x i32> %20, i32 52428)
  %22 = add <16 x i32> %21, %16
  %23 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %22, i32 0)
  %24 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %23), !noalias !2
  %25 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %24, i32 0)
  %26 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %23), !noalias !2
  %27 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %25, <8 x i32> %26, i32 1)
  %28 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %22, i32 1)
  %29 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %28), !noalias !2
  %30 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %29, i32 0)
  %31 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %28), !noalias !2
  %32 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %30, <8 x i32> %31, i32 1)
  %33 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %27, <16 x i32> %32, i32 24)
  %34 = bitcast <16 x i32> %33 to <32 x bfloat>
  %35 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %34, i32 0)
  %36 = tail call noundef <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64> %15, i32 -2, i32 1)
  %37 = and <16 x i32> %36, %3
  %38 = zext i20 ptrtoint (ptr @exp_flut_ab to i20) to i32
  %39 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 %38)
  %40 = zext i20 ptrtoint (ptr @exp_flut_cd to i20) to i32
  %41 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 %40)
  %42 = tail call noundef <16 x i32> @llvm.aie2.vsel32(<16 x i32> %39, <16 x i32> %41, i32 52428)
  %43 = add <16 x i32> %42, %37
  %44 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %43, i32 0)
  %45 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %44), !noalias !7
  %46 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %45, i32 0)
  %47 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %44), !noalias !7
  %48 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %46, <8 x i32> %47, i32 1)
  %49 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %43, i32 1)
  %50 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %49), !noalias !7
  %51 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %50, i32 0)
  %52 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %49), !noalias !7
  %53 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %51, <8 x i32> %52, i32 1)
  %54 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %48, <16 x i32> %53, i32 24)
  %55 = bitcast <16 x i32> %54 to <32 x bfloat>
  %56 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %55, i32 0)
  %57 = tail call noundef <32 x bfloat> @llvm.aie2.vbroadcast16.bf512(bfloat 0xR0000)
  %58 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %57, i32 0)
  %59 = tail call <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat> %35, i32 0)
  %60 = tail call <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat> %59, <16 x bfloat> %58, i32 1)
  %61 = tail call <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat> %56, i32 0)
  %62 = tail call <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat> %61, <16 x bfloat> %58, i32 1)
  %63 = tail call noundef <8 x i64> @llvm.aie2.bf.mul16.conf(<32 x bfloat> %60, <32 x bfloat> %62, i32 60)
  ret <8 x i64> %63
}

; Function Attrs: alwaysinline mustprogress nofree norecurse nosync nounwind willreturn memory(read, argmem: none, inaccessiblemem: none)
define dso_local noundef bfloat @_Z10getInvBf16f(float noundef %0) local_unnamed_addr #1 {
  %2 = bitcast float %0 to i32
  %3 = add i32 %2, 32768
  %4 = lshr i32 %3, 23
  %5 = lshr i32 %3, 16
  %6 = and i32 %5, 127
  %7 = icmp eq i32 %6, 0
  %8 = zext i1 %7 to i32
  %9 = and i32 %4, 255
  %10 = sub nsw i32 %8, %9
  %11 = shl nsw i32 %10, 7
  %12 = add nsw i32 %11, 32384
  %13 = trunc i32 %6 to i20
  %14 = getelementptr inbounds [128 x i8], ptr @m_inv_lut, i20 0, i20 %13
  %15 = load i8, ptr %14, align 1, !tbaa !12
  %16 = zext i8 %15 to i32
  %17 = add nsw i32 %12, %16
  %18 = trunc i32 %17 to i16
  %19 = bitcast i16 %18 to bfloat
  ret bfloat %19
}

; Function Attrs: mustprogress nofree nounwind memory(read, argmem: readwrite)
define dso_local void @dut(ptr noalias nocapture readonly %0, ptr noalias nocapture writeonly %1) local_unnamed_addr #2 {
  %3 = tail call noundef <16 x i32> @llvm.aie2.v16int32()
  %4 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 1023)
  %5 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 0)
  %6 = tail call noundef <16 x bfloat> @llvm.aie2.v16bfloat16()
  %7 = tail call noundef <8 x i64> @llvm.aie2.v16accfloat()
  %8 = zext i20 ptrtoint (ptr @exp_ilut_ab to i20) to i32
  %9 = zext i20 ptrtoint (ptr @exp_ilut_cd to i20) to i32
  %10 = zext i20 ptrtoint (ptr @exp_flut_ab to i20) to i32
  %11 = zext i20 ptrtoint (ptr @exp_flut_cd to i20) to i32
  br label %13

12:                                               ; preds = %13
  ret void

13:                                               ; preds = %13, %2
  %14 = phi i32 [ 0, %2 ], [ %132, %13 ]
  %15 = trunc i32 %14 to i20
  %16 = getelementptr inbounds bfloat, ptr %0, i20 %15
  %17 = load <16 x bfloat>, ptr %16, align 32, !tbaa !12
  %18 = tail call noundef <16 x i32> @llvm.aie2.v16bf16.to.v16i32(<16 x bfloat> %17, i32 8)
  %19 = tail call noundef <32 x i16> @llvm.aie2.v32int16()
  %20 = bitcast <32 x i16> %19 to <16 x i32>
  %21 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %18, <16 x i32> %20, i32 2)
  %22 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %21, i32 0)
  %23 = bitcast <8 x i32> %22 to <16 x i16>
  %24 = tail call noundef <32 x bfloat> @llvm.aie2.v32bfloat16()
  %25 = tail call noundef <16 x i64> @llvm.aie2.v16acc64()
  %26 = tail call noundef <16 x i64> @llvm.aie2.acc64.v16.I256.ups(<16 x i16> %23, i32 0, i32 0)
  %27 = tail call noundef <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64> %26, i32 6, i32 1)
  %28 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 %8)
  %29 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 %9)
  %30 = tail call noundef <16 x i32> @llvm.aie2.vsel32(<16 x i32> %28, <16 x i32> %29, i32 52428)
  %31 = add <16 x i32> %30, %27
  %32 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %31, i32 0)
  %33 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %32), !noalias !15
  %34 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %33, i32 0)
  %35 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %32), !noalias !15
  %36 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %34, <8 x i32> %35, i32 1)
  %37 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %31, i32 1)
  %38 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %37), !noalias !15
  %39 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %38, i32 0)
  %40 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %37), !noalias !15
  %41 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %39, <8 x i32> %40, i32 1)
  %42 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %36, <16 x i32> %41, i32 24)
  %43 = bitcast <16 x i32> %42 to <32 x bfloat>
  %44 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %43, i32 0)
  %45 = tail call noundef <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64> %26, i32 -2, i32 1)
  %46 = and <16 x i32> %45, %4
  %47 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 %10)
  %48 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 %11)
  %49 = tail call noundef <16 x i32> @llvm.aie2.vsel32(<16 x i32> %47, <16 x i32> %48, i32 52428)
  %50 = add <16 x i32> %49, %46
  %51 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %50, i32 0)
  %52 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %51), !noalias !20
  %53 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %52, i32 0)
  %54 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %51), !noalias !20
  %55 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %53, <8 x i32> %54, i32 1)
  %56 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %50, i32 1)
  %57 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %56), !noalias !20
  %58 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %57, i32 0)
  %59 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %56), !noalias !20
  %60 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %58, <8 x i32> %59, i32 1)
  %61 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %55, <16 x i32> %60, i32 24)
  %62 = bitcast <16 x i32> %61 to <32 x bfloat>
  %63 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %62, i32 0)
  %64 = tail call noundef <32 x bfloat> @llvm.aie2.vbroadcast16.bf512(bfloat 0xR0000)
  %65 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %64, i32 0)
  %66 = tail call <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat> %44, i32 0)
  %67 = tail call <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat> %66, <16 x bfloat> %65, i32 1)
  %68 = tail call <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat> %63, i32 0)
  %69 = tail call <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat> %68, <16 x bfloat> %65, i32 1)
  %70 = tail call noundef <8 x i64> @llvm.aie2.bf.mul16.conf(<32 x bfloat> %67, <32 x bfloat> %69, i32 60)
  %71 = tail call noundef <16 x bfloat> @llvm.aie2.v16accfloat.to.v16bf16(<8 x i64> %70)
  %72 = getelementptr inbounds bfloat, ptr %1, i20 %15
  store <16 x bfloat> %71, ptr %72, align 32, !tbaa !12
  %73 = or disjoint i32 %14, 16
  %74 = trunc i32 %73 to i20
  %75 = getelementptr inbounds bfloat, ptr %0, i20 %74
  %76 = load <16 x bfloat>, ptr %75, align 32, !tbaa !12
  %77 = tail call noundef <16 x i32> @llvm.aie2.v16bf16.to.v16i32(<16 x bfloat> %76, i32 8)
  %78 = tail call noundef <32 x i16> @llvm.aie2.v32int16()
  %79 = bitcast <32 x i16> %78 to <16 x i32>
  %80 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %77, <16 x i32> %79, i32 2)
  %81 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %80, i32 0)
  %82 = bitcast <8 x i32> %81 to <16 x i16>
  %83 = tail call noundef <32 x bfloat> @llvm.aie2.v32bfloat16()
  %84 = tail call noundef <16 x i64> @llvm.aie2.v16acc64()
  %85 = tail call noundef <16 x i64> @llvm.aie2.acc64.v16.I256.ups(<16 x i16> %82, i32 0, i32 0)
  %86 = tail call noundef <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64> %85, i32 6, i32 1)
  %87 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 %8)
  %88 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 %9)
  %89 = tail call noundef <16 x i32> @llvm.aie2.vsel32(<16 x i32> %87, <16 x i32> %88, i32 52428)
  %90 = add <16 x i32> %89, %86
  %91 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %90, i32 0)
  %92 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %91), !noalias !15
  %93 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %92, i32 0)
  %94 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %91), !noalias !15
  %95 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %93, <8 x i32> %94, i32 1)
  %96 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %90, i32 1)
  %97 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %96), !noalias !15
  %98 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %97, i32 0)
  %99 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %96), !noalias !15
  %100 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %98, <8 x i32> %99, i32 1)
  %101 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %95, <16 x i32> %100, i32 24)
  %102 = bitcast <16 x i32> %101 to <32 x bfloat>
  %103 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %102, i32 0)
  %104 = tail call noundef <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64> %85, i32 -2, i32 1)
  %105 = and <16 x i32> %104, %4
  %106 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 %10)
  %107 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 %11)
  %108 = tail call noundef <16 x i32> @llvm.aie2.vsel32(<16 x i32> %106, <16 x i32> %107, i32 52428)
  %109 = add <16 x i32> %108, %105
  %110 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %109, i32 0)
  %111 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %110), !noalias !20
  %112 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %111, i32 0)
  %113 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %110), !noalias !20
  %114 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %112, <8 x i32> %113, i32 1)
  %115 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %109, i32 1)
  %116 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %115), !noalias !20
  %117 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %116, i32 0)
  %118 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %115), !noalias !20
  %119 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %117, <8 x i32> %118, i32 1)
  %120 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %114, <16 x i32> %119, i32 24)
  %121 = bitcast <16 x i32> %120 to <32 x bfloat>
  %122 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %121, i32 0)
  %123 = tail call noundef <32 x bfloat> @llvm.aie2.vbroadcast16.bf512(bfloat 0xR0000)
  %124 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %123, i32 0)
  %125 = tail call <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat> %103, i32 0)
  %126 = tail call <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat> %125, <16 x bfloat> %124, i32 1)
  %127 = tail call <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat> %122, i32 0)
  %128 = tail call <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat> %127, <16 x bfloat> %124, i32 1)
  %129 = tail call noundef <8 x i64> @llvm.aie2.bf.mul16.conf(<32 x bfloat> %126, <32 x bfloat> %128, i32 60)
  %130 = tail call noundef <16 x bfloat> @llvm.aie2.v16accfloat.to.v16bf16(<8 x i64> %129)
  %131 = getelementptr inbounds bfloat, ptr %1, i20 %74
  store <16 x bfloat> %130, ptr %131, align 32, !tbaa !12
  %132 = add nuw nsw i32 %14, 32
  %133 = icmp ult i32 %73, 1008
  br i1 %133, label %13, label %12, !llvm.loop !25
}

; Function Attrs: nofree nosync nounwind memory(none)
declare <8 x i64> @llvm.aie2.v16accfloat() #3

; Function Attrs: nofree nounwind memory(inaccessiblemem: read)
declare <16 x i32> @llvm.aie2.v16bf16.to.v16i32(<16 x bfloat>, i32) #4

; Function Attrs: nofree nosync nounwind memory(none)
declare <32 x bfloat> @llvm.aie2.v32bfloat16() #3

; Function Attrs: nofree nosync nounwind memory(none)
declare <32 x bfloat> @llvm.aie2.vbroadcast16.bf512(bfloat) #3

; Function Attrs: nofree nosync nounwind memory(none)
declare <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat>, i32) #3

; Function Attrs: nofree nosync nounwind memory(none)
declare <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat>, i32) #3

; Function Attrs: nofree nosync nounwind memory(none)
declare <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat>, <16 x bfloat>, i32) #3

; Function Attrs: nofree nounwind memory(inaccessiblemem: read)
declare <8 x i64> @llvm.aie2.bf.mul16.conf(<32 x bfloat>, <32 x bfloat>, i32) #4

; Function Attrs: nofree nounwind memory(inaccessiblemem: read)
declare <16 x bfloat> @llvm.aie2.v16accfloat.to.v16bf16(<8 x i64>) #4

; Function Attrs: nofree nosync nounwind memory(none)
declare <16 x i32> @llvm.aie2.v16int32() #3

; Function Attrs: nofree nosync nounwind memory(none)
declare <16 x i32> @llvm.aie2.vbroadcast32.I512(i32) #3

; Function Attrs: nofree nosync nounwind memory(none)
declare <16 x bfloat> @llvm.aie2.v16bfloat16() #3

; Function Attrs: nofree nosync nounwind memory(none)
declare <16 x i32> @llvm.aie2.vshuffle(<16 x i32>, <16 x i32>, i32) #3

; Function Attrs: nofree nosync nounwind memory(none)
declare <32 x i16> @llvm.aie2.v32int16() #3

; Function Attrs: nofree nosync nounwind memory(none)
declare <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32>, i32) #3

; Function Attrs: nofree nosync nounwind memory(none)
declare <16 x i64> @llvm.aie2.v16acc64() #3

; Function Attrs: nofree nounwind memory(inaccessiblemem: read)
declare <16 x i64> @llvm.aie2.acc64.v16.I256.ups(<16 x i16>, i32, i32) #4

; Function Attrs: nofree nounwind memory(inaccessiblemem: read)
declare <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64>, i32, i32) #4

; Function Attrs: nofree nosync nounwind memory(none)
declare <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32>, <8 x i32>, i32) #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.aie2.vsel32(<16 x i32>, <16 x i32>, i32) #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32>) #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32>) #6

attributes #0 = { alwaysinline mustprogress nofree nounwind willreturn memory(read) "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { alwaysinline mustprogress nofree norecurse nosync nounwind willreturn memory(read, argmem: none, inaccessiblemem: none) "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #2 = { mustprogress nofree nounwind memory(read, argmem: readwrite) "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #3 = { nofree nosync nounwind memory(none) }
attributes #4 = { nofree nounwind memory(inaccessiblemem: read) }
attributes #5 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #6 = { mustprogress nocallback nofree nosync nounwind willreturn memory(read) }

!llvm.linker.options = !{}
!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 18.0.0git"}
!2 = !{!3, !5}
!3 = distinct !{!3, !4, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4Eu6__bf16u6__bf16EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrS9_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS7_Iu6__bf16XT0_EEERKT_: argument 0"}
!4 = distinct !{!4, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4Eu6__bf16u6__bf16EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrS9_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS7_Iu6__bf16XT0_EEERKT_"}
!5 = distinct !{!5, !6, !"_ZN3aie15parallel_lookupItNS_3lutILj4Eu6__bf16u6__bf16EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS7_Iu6__bf16XT0_EEERKT_: argument 0"}
!6 = distinct !{!6, !"_ZN3aie15parallel_lookupItNS_3lutILj4Eu6__bf16u6__bf16EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS7_Iu6__bf16XT0_EEERKT_"}
!7 = !{!8, !10}
!8 = distinct !{!8, !9, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4Eu6__bf16u6__bf16EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrS9_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS7_Iu6__bf16XT0_EEERKT_: argument 0"}
!9 = distinct !{!9, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4Eu6__bf16u6__bf16EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrS9_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS7_Iu6__bf16XT0_EEERKT_"}
!10 = distinct !{!10, !11, !"_ZN3aie15parallel_lookupItNS_3lutILj4Eu6__bf16u6__bf16EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS7_Iu6__bf16XT0_EEERKT_: argument 0"}
!11 = distinct !{!11, !"_ZN3aie15parallel_lookupItNS_3lutILj4Eu6__bf16u6__bf16EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS7_Iu6__bf16XT0_EEERKT_"}
!12 = !{!13, !13, i64 0}
!13 = !{!"omnipotent char", !14, i64 0}
!14 = !{!"Simple C++ TBAA"}
!15 = !{!16, !18}
!16 = distinct !{!16, !17, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4Eu6__bf16u6__bf16EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrS9_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS7_Iu6__bf16XT0_EEERKT_: argument 0"}
!17 = distinct !{!17, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4Eu6__bf16u6__bf16EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrS9_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS7_Iu6__bf16XT0_EEERKT_"}
!18 = distinct !{!18, !19, !"_ZN3aie15parallel_lookupItNS_3lutILj4Eu6__bf16u6__bf16EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS7_Iu6__bf16XT0_EEERKT_: argument 0"}
!19 = distinct !{!19, !"_ZN3aie15parallel_lookupItNS_3lutILj4Eu6__bf16u6__bf16EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS7_Iu6__bf16XT0_EEERKT_"}
!20 = !{!21, !23}
!21 = distinct !{!21, !22, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4Eu6__bf16u6__bf16EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrS9_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS7_Iu6__bf16XT0_EEERKT_: argument 0"}
!22 = distinct !{!22, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4Eu6__bf16u6__bf16EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrS9_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS7_Iu6__bf16XT0_EEERKT_"}
!23 = distinct !{!23, !24, !"_ZN3aie15parallel_lookupItNS_3lutILj4Eu6__bf16u6__bf16EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS7_Iu6__bf16XT0_EEERKT_: argument 0"}
!24 = distinct !{!24, !"_ZN3aie15parallel_lookupItNS_3lutILj4Eu6__bf16u6__bf16EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS7_Iu6__bf16XT0_EEERKT_"}
!25 = distinct !{!25, !26}
!26 = !{!"llvm.loop.itercount.range", i32 32, i32 32}
