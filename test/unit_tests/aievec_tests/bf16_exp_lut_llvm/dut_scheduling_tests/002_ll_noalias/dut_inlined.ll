; ModuleID = 'dut_inlined.cc'
source_filename = "dut_inlined.cc"
target datalayout = "e-m:e-p:20:32-i1:8:32-i8:8:32-i16:16:32-i32:32:32-f32:32:32-i64:32-f64:32-a:0:32-n32"
target triple = "aie2"

%class.bfloat16 = type { bfloat }

@exp_ilut_ab = external dso_local global [512 x i16], align 32
@exp_ilut_cd = external dso_local global [512 x i16], align 32
@exp_flut_ab = external dso_local global [512 x i16], align 32
@exp_flut_cd = external dso_local global [512 x i16], align 32

; Function Attrs: mustprogress nofree nounwind memory(read, argmem: readwrite)
define dso_local void @_Z3dutP8bfloat16S0_(ptr noalias nocapture readonly %0, ptr noalias nocapture writeonly %1) local_unnamed_addr #0 {
  %3 = tail call noundef <16 x i32> @llvm.aie2.v16int32()
  %4 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 1023)
  %5 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 0)
  %6 = tail call noundef <16 x bfloat> @llvm.aie2.v16bfloat16()
  %7 = tail call noundef <8 x i64> @llvm.aie2.v16accfloat()
  %8 = tail call noundef <16 x i16> @llvm.aie2.v16int16()
  %9 = load <16 x bfloat>, ptr %0, align 32, !tbaa !2
  %10 = getelementptr inbounds %class.bfloat16, ptr %0, i20 16
  %11 = load <16 x bfloat>, ptr %10, align 32, !tbaa !2
  %12 = tail call noundef <16 x i32> @llvm.aie2.v16bf16.to.v16i32(<16 x bfloat> %9, i32 8)
  %13 = tail call noundef <32 x i16> @llvm.aie2.v32int16()
  %14 = bitcast <32 x i16> %13 to <16 x i32>
  %15 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %12, <16 x i32> %14, i32 2)
  %16 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %15, i32 0)
  %17 = getelementptr inbounds %class.bfloat16, ptr %0, i20 32
  %18 = load <16 x bfloat>, ptr %17, align 32, !tbaa !2
  %19 = tail call noundef <16 x i32> @llvm.aie2.v16bf16.to.v16i32(<16 x bfloat> %11, i32 8)
  %20 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %19, <16 x i32> %14, i32 2)
  %21 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %20, i32 0)
  %22 = bitcast <8 x i32> %16 to <16 x i16>
  %23 = tail call noundef <32 x bfloat> @llvm.aie2.v32bfloat16()
  %24 = tail call noundef <16 x i64> @llvm.aie2.v16acc64()
  %25 = tail call noundef <16 x i64> @llvm.aie2.acc64.v16.I256.ups(<16 x i16> %22, i32 0, i32 0)
  %26 = tail call noundef <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64> %25, i32 6, i32 1)
  %27 = zext i20 ptrtoint (ptr @exp_ilut_ab to i20) to i32
  %28 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 %27)
  %29 = zext i20 ptrtoint (ptr @exp_ilut_cd to i20) to i32
  %30 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 %29)
  %31 = tail call noundef <16 x i32> @llvm.aie2.vsel32(<16 x i32> %28, <16 x i32> %30, i32 52428)
  %32 = add <16 x i32> %31, %26
  %33 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %32, i32 0)
  %34 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %33), !noalias !5
  %35 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %34, i32 0)
  %36 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %33), !noalias !5
  %37 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %35, <8 x i32> %36, i32 1)
  %38 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %32, i32 1)
  %39 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %38), !noalias !5
  %40 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %39, i32 0)
  %41 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %38), !noalias !5
  %42 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %40, <8 x i32> %41, i32 1)
  %43 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %37, <16 x i32> %42, i32 24)
  %44 = bitcast <16 x i32> %43 to <32 x bfloat>
  %45 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %44, i32 0)
  %46 = tail call noundef <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64> %25, i32 -2, i32 1)
  %47 = and <16 x i32> %46, %4
  %48 = zext i20 ptrtoint (ptr @exp_flut_ab to i20) to i32
  %49 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 %48)
  %50 = zext i20 ptrtoint (ptr @exp_flut_cd to i20) to i32
  %51 = tail call noundef <16 x i32> @llvm.aie2.vbroadcast32.I512(i32 %50)
  %52 = tail call noundef <16 x i32> @llvm.aie2.vsel32(<16 x i32> %49, <16 x i32> %51, i32 52428)
  %53 = add <16 x i32> %52, %47
  %54 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %53, i32 0)
  %55 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %54), !noalias !10
  %56 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %55, i32 0)
  %57 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %54), !noalias !10
  %58 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %56, <8 x i32> %57, i32 1)
  %59 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %53, i32 1)
  %60 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %59), !noalias !10
  %61 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %60, i32 0)
  %62 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %59), !noalias !10
  %63 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %61, <8 x i32> %62, i32 1)
  %64 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %58, <16 x i32> %63, i32 24)
  %65 = bitcast <16 x i32> %64 to <32 x bfloat>
  %66 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %65, i32 0)
  %67 = getelementptr %class.bfloat16, ptr %0, i20 48
  br label %159

68:                                               ; preds = %159
  %69 = bitcast <8 x i32> %171 to <16 x i16>
  %70 = tail call noundef <16 x i32> @llvm.aie2.v16bf16.to.v16i32(<16 x bfloat> %168, i32 8)
  %71 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %70, <16 x i32> %14, i32 2)
  %72 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %71, i32 0)
  %73 = tail call noundef <16 x i64> @llvm.aie2.acc64.v16.I256.ups(<16 x i16> %69, i32 0, i32 0)
  %74 = tail call noundef <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64> %73, i32 6, i32 1)
  %75 = add <16 x i32> %74, %31
  %76 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %75, i32 0)
  %77 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %76), !noalias !15
  %78 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %77, i32 0)
  %79 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %76), !noalias !15
  %80 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %78, <8 x i32> %79, i32 1)
  %81 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %75, i32 1)
  %82 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %81), !noalias !15
  %83 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %82, i32 0)
  %84 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %81), !noalias !15
  %85 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %83, <8 x i32> %84, i32 1)
  %86 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %80, <16 x i32> %85, i32 24)
  %87 = bitcast <16 x i32> %86 to <32 x bfloat>
  %88 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %87, i32 0)
  %89 = tail call noundef <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64> %73, i32 -2, i32 1)
  %90 = and <16 x i32> %89, %4
  %91 = add <16 x i32> %90, %52
  %92 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %91, i32 0)
  %93 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %92), !noalias !20
  %94 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %93, i32 0)
  %95 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %92), !noalias !20
  %96 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %94, <8 x i32> %95, i32 1)
  %97 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %91, i32 1)
  %98 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %97), !noalias !20
  %99 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %98, i32 0)
  %100 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %97), !noalias !20
  %101 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %99, <8 x i32> %100, i32 1)
  %102 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %96, <16 x i32> %101, i32 24)
  %103 = bitcast <16 x i32> %102 to <32 x bfloat>
  %104 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %103, i32 0)
  %105 = tail call <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat> %187, i32 0)
  %106 = tail call <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat> %105, <16 x bfloat> %205, i32 1)
  %107 = tail call <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat> %203, i32 0)
  %108 = tail call <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat> %107, <16 x bfloat> %205, i32 1)
  %109 = tail call noundef <8 x i64> @llvm.aie2.bf.mul16.conf(<32 x bfloat> %106, <32 x bfloat> %108, i32 60)
  %110 = tail call noundef <16 x bfloat> @llvm.aie2.v16accfloat.to.v16bf16(<8 x i64> %109)
  %111 = getelementptr inbounds %class.bfloat16, ptr %1, i20 976
  store <16 x bfloat> %110, ptr %111, align 32, !tbaa !2
  %112 = bitcast <8 x i32> %72 to <16 x i16>
  %113 = tail call noundef <16 x i64> @llvm.aie2.acc64.v16.I256.ups(<16 x i16> %112, i32 0, i32 0)
  %114 = tail call noundef <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64> %113, i32 6, i32 1)
  %115 = add <16 x i32> %114, %31
  %116 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %115, i32 0)
  %117 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %116), !noalias !25
  %118 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %117, i32 0)
  %119 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %116), !noalias !25
  %120 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %118, <8 x i32> %119, i32 1)
  %121 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %115, i32 1)
  %122 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %121), !noalias !25
  %123 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %122, i32 0)
  %124 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %121), !noalias !25
  %125 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %123, <8 x i32> %124, i32 1)
  %126 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %120, <16 x i32> %125, i32 24)
  %127 = bitcast <16 x i32> %126 to <32 x bfloat>
  %128 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %127, i32 0)
  %129 = tail call noundef <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64> %113, i32 -2, i32 1)
  %130 = and <16 x i32> %129, %4
  %131 = add <16 x i32> %130, %52
  %132 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %131, i32 0)
  %133 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %132), !noalias !30
  %134 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %133, i32 0)
  %135 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %132), !noalias !30
  %136 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %134, <8 x i32> %135, i32 1)
  %137 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %131, i32 1)
  %138 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %137), !noalias !30
  %139 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %138, i32 0)
  %140 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %137), !noalias !30
  %141 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %139, <8 x i32> %140, i32 1)
  %142 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %136, <16 x i32> %141, i32 24)
  %143 = bitcast <16 x i32> %142 to <32 x bfloat>
  %144 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %143, i32 0)
  %145 = tail call <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat> %88, i32 0)
  %146 = tail call <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat> %145, <16 x bfloat> %205, i32 1)
  %147 = tail call <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat> %104, i32 0)
  %148 = tail call <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat> %147, <16 x bfloat> %205, i32 1)
  %149 = tail call noundef <8 x i64> @llvm.aie2.bf.mul16.conf(<32 x bfloat> %146, <32 x bfloat> %148, i32 60)
  %150 = tail call noundef <16 x bfloat> @llvm.aie2.v16accfloat.to.v16bf16(<8 x i64> %149)
  %151 = getelementptr inbounds %class.bfloat16, ptr %1, i20 992
  store <16 x bfloat> %150, ptr %151, align 32, !tbaa !2
  %152 = tail call <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat> %128, i32 0)
  %153 = tail call <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat> %152, <16 x bfloat> %205, i32 1)
  %154 = tail call <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat> %144, i32 0)
  %155 = tail call <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat> %154, <16 x bfloat> %205, i32 1)
  %156 = tail call noundef <8 x i64> @llvm.aie2.bf.mul16.conf(<32 x bfloat> %153, <32 x bfloat> %155, i32 60)
  %157 = tail call noundef <16 x bfloat> @llvm.aie2.v16accfloat.to.v16bf16(<8 x i64> %156)
  %158 = getelementptr inbounds %class.bfloat16, ptr %1, i20 1008
  store <16 x bfloat> %157, ptr %158, align 32, !tbaa !2
  ret void

159:                                              ; preds = %214, %2
  %160 = phi i32 [ 0, %2 ], [ %264, %214 ]
  %161 = phi <16 x bfloat> [ %18, %2 ], [ %219, %214 ]
  %162 = phi <16 x bfloat> [ %45, %2 ], [ %238, %214 ]
  %163 = phi <16 x bfloat> [ %66, %2 ], [ %254, %214 ]
  %164 = phi <8 x i32> [ %21, %2 ], [ %222, %214 ]
  %165 = bitcast <8 x i32> %164 to <16 x i16>
  %166 = trunc i32 %160 to i20
  %167 = getelementptr %class.bfloat16, ptr %67, i20 %166
  %168 = load <16 x bfloat>, ptr %167, align 32, !tbaa !2
  %169 = tail call noundef <16 x i32> @llvm.aie2.v16bf16.to.v16i32(<16 x bfloat> %161, i32 8)
  %170 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %169, <16 x i32> %14, i32 2)
  %171 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %170, i32 0)
  %172 = tail call noundef <16 x i64> @llvm.aie2.acc64.v16.I256.ups(<16 x i16> %165, i32 0, i32 0)
  %173 = tail call noundef <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64> %172, i32 6, i32 1)
  %174 = add <16 x i32> %173, %31
  %175 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %174, i32 0)
  %176 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %175), !noalias !35
  %177 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %176, i32 0)
  %178 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %175), !noalias !35
  %179 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %177, <8 x i32> %178, i32 1)
  %180 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %174, i32 1)
  %181 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %180), !noalias !35
  %182 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %181, i32 0)
  %183 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %180), !noalias !35
  %184 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %182, <8 x i32> %183, i32 1)
  %185 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %179, <16 x i32> %184, i32 24)
  %186 = bitcast <16 x i32> %185 to <32 x bfloat>
  %187 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %186, i32 0)
  %188 = tail call noundef <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64> %172, i32 -2, i32 1)
  %189 = and <16 x i32> %188, %4
  %190 = add <16 x i32> %189, %52
  %191 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %190, i32 0)
  %192 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %191), !noalias !40
  %193 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %192, i32 0)
  %194 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %191), !noalias !40
  %195 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %193, <8 x i32> %194, i32 1)
  %196 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %190, i32 1)
  %197 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %196), !noalias !40
  %198 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %197, i32 0)
  %199 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %196), !noalias !40
  %200 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %198, <8 x i32> %199, i32 1)
  %201 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %195, <16 x i32> %200, i32 24)
  %202 = bitcast <16 x i32> %201 to <32 x bfloat>
  %203 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %202, i32 0)
  %204 = tail call noundef <32 x bfloat> @llvm.aie2.vbroadcast16.bf512(bfloat 0xR0000)
  %205 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %204, i32 0)
  %206 = tail call <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat> %162, i32 0)
  %207 = tail call <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat> %206, <16 x bfloat> %205, i32 1)
  %208 = tail call <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat> %163, i32 0)
  %209 = tail call <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat> %208, <16 x bfloat> %205, i32 1)
  %210 = tail call noundef <8 x i64> @llvm.aie2.bf.mul16.conf(<32 x bfloat> %207, <32 x bfloat> %209, i32 60)
  %211 = tail call noundef <16 x bfloat> @llvm.aie2.v16accfloat.to.v16bf16(<8 x i64> %210)
  %212 = getelementptr inbounds %class.bfloat16, ptr %1, i20 %166
  store <16 x bfloat> %211, ptr %212, align 32, !tbaa !2, !noalias !35
  %213 = icmp ult i32 %160, 960
  br i1 %213, label %214, label %68, !llvm.loop !45

214:                                              ; preds = %159
  %215 = or disjoint i32 %160, 16
  %216 = bitcast <8 x i32> %171 to <16 x i16>
  %217 = trunc i32 %215 to i20
  %218 = getelementptr %class.bfloat16, ptr %67, i20 %217
  %219 = load <16 x bfloat>, ptr %218, align 32, !tbaa !2
  %220 = tail call noundef <16 x i32> @llvm.aie2.v16bf16.to.v16i32(<16 x bfloat> %168, i32 8)
  %221 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %220, <16 x i32> %14, i32 2)
  %222 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %221, i32 0)
  %223 = tail call noundef <16 x i64> @llvm.aie2.acc64.v16.I256.ups(<16 x i16> %216, i32 0, i32 0)
  %224 = tail call noundef <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64> %223, i32 6, i32 1)
  %225 = add <16 x i32> %224, %31
  %226 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %225, i32 0)
  %227 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %226), !noalias !35
  %228 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %227, i32 0)
  %229 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %226), !noalias !35
  %230 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %228, <8 x i32> %229, i32 1)
  %231 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %225, i32 1)
  %232 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %231), !noalias !35
  %233 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %232, i32 0)
  %234 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %231), !noalias !35
  %235 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %233, <8 x i32> %234, i32 1)
  %236 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %230, <16 x i32> %235, i32 24)
  %237 = bitcast <16 x i32> %236 to <32 x bfloat>
  %238 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %237, i32 0)
  %239 = tail call noundef <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64> %223, i32 -2, i32 1)
  %240 = and <16 x i32> %239, %4
  %241 = add <16 x i32> %240, %52
  %242 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %241, i32 0)
  %243 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %242), !noalias !40
  %244 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %243, i32 0)
  %245 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %242), !noalias !40
  %246 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %244, <8 x i32> %245, i32 1)
  %247 = tail call <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32> %241, i32 1)
  %248 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32> %247), !noalias !40
  %249 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> undef, <8 x i32> %248, i32 0)
  %250 = tail call noundef <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32> %247), !noalias !40
  %251 = tail call <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32> %249, <8 x i32> %250, i32 1)
  %252 = tail call <16 x i32> @llvm.aie2.vshuffle(<16 x i32> %246, <16 x i32> %251, i32 24)
  %253 = bitcast <16 x i32> %252 to <32 x bfloat>
  %254 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %253, i32 0)
  %255 = tail call noundef <32 x bfloat> @llvm.aie2.vbroadcast16.bf512(bfloat 0xR0000)
  %256 = tail call <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat> %255, i32 0)
  %257 = tail call <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat> %187, i32 0)
  %258 = tail call <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat> %257, <16 x bfloat> %256, i32 1)
  %259 = tail call <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat> %203, i32 0)
  %260 = tail call <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat> %259, <16 x bfloat> %256, i32 1)
  %261 = tail call noundef <8 x i64> @llvm.aie2.bf.mul16.conf(<32 x bfloat> %258, <32 x bfloat> %260, i32 60)
  %262 = tail call noundef <16 x bfloat> @llvm.aie2.v16accfloat.to.v16bf16(<8 x i64> %261)
  %263 = getelementptr inbounds %class.bfloat16, ptr %1, i20 %217
  store <16 x bfloat> %262, ptr %263, align 32, !tbaa !2
  %264 = add nuw nsw i32 %160, 32
  br label %159
}

; Function Attrs: nofree nosync nounwind memory(none)
declare <8 x i64> @llvm.aie2.v16accfloat() #1

; Function Attrs: nofree nounwind memory(inaccessiblemem: read)
declare <16 x i32> @llvm.aie2.v16bf16.to.v16i32(<16 x bfloat>, i32) #2

; Function Attrs: nofree nosync nounwind memory(none)
declare <32 x bfloat> @llvm.aie2.v32bfloat16() #1

; Function Attrs: nofree nosync nounwind memory(none)
declare <32 x bfloat> @llvm.aie2.vbroadcast16.bf512(bfloat) #1

; Function Attrs: nofree nosync nounwind memory(none)
declare <16 x bfloat> @llvm.aie2.ext.bf256.bf512(<32 x bfloat>, i32) #1

; Function Attrs: nofree nosync nounwind memory(none)
declare <32 x bfloat> @llvm.aie2.set.bf512.bf256(<16 x bfloat>, i32) #1

; Function Attrs: nofree nosync nounwind memory(none)
declare <32 x bfloat> @llvm.aie2.upd.bf512.bf256(<32 x bfloat>, <16 x bfloat>, i32) #1

; Function Attrs: nofree nounwind memory(inaccessiblemem: read)
declare <8 x i64> @llvm.aie2.bf.mul16.conf(<32 x bfloat>, <32 x bfloat>, i32) #2

; Function Attrs: nofree nounwind memory(inaccessiblemem: read)
declare <16 x bfloat> @llvm.aie2.v16accfloat.to.v16bf16(<8 x i64>) #2

; Function Attrs: nofree nosync nounwind memory(none)
declare <16 x i32> @llvm.aie2.v16int32() #1

; Function Attrs: nofree nosync nounwind memory(none)
declare <16 x i32> @llvm.aie2.vbroadcast32.I512(i32) #1

; Function Attrs: nofree nosync nounwind memory(none)
declare <16 x bfloat> @llvm.aie2.v16bfloat16() #1

; Function Attrs: nofree nosync nounwind memory(none)
declare <16 x i16> @llvm.aie2.v16int16() #1

; Function Attrs: nofree nosync nounwind memory(none)
declare <16 x i32> @llvm.aie2.vshuffle(<16 x i32>, <16 x i32>, i32) #1

; Function Attrs: nofree nosync nounwind memory(none)
declare <32 x i16> @llvm.aie2.v32int16() #1

; Function Attrs: nofree nosync nounwind memory(none)
declare <8 x i32> @llvm.aie2.ext.I256.I512(<16 x i32>, i32) #1

; Function Attrs: nofree nosync nounwind memory(none)
declare <16 x i64> @llvm.aie2.v16acc64() #1

; Function Attrs: nofree nounwind memory(inaccessiblemem: read)
declare <16 x i64> @llvm.aie2.acc64.v16.I256.ups(<16 x i16>, i32, i32) #2

; Function Attrs: nofree nounwind memory(inaccessiblemem: read)
declare <16 x i32> @llvm.aie2.I512.v16.acc64.srs(<16 x i64>, i32, i32) #2

; Function Attrs: nofree nosync nounwind memory(none)
declare <16 x i32> @llvm.aie2.upd.I512.I256(<16 x i32>, <8 x i32>, i32) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.aie2.vsel32(<16 x i32>, <16 x i32>, i32) #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <8 x i32> @llvm.aie2.load.4x16.lo(<8 x i32>) #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <8 x i32> @llvm.aie2.load.4x16.hi(<8 x i32>) #4

attributes #0 = { mustprogress nofree nounwind memory(read, argmem: readwrite) "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { nofree nosync nounwind memory(none) }
attributes #2 = { nofree nounwind memory(inaccessiblemem: read) }
attributes #3 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #4 = { mustprogress nocallback nofree nosync nounwind willreturn memory(read) }

!llvm.linker.options = !{}
!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 18.0.0git"}
!2 = !{!3, !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C++ TBAA"}
!5 = !{!6, !8}
!6 = distinct !{!6, !7, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4E8bfloat16S3_EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrSA_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS8_IS3_XT0_EEERKT_: argument 0"}
!7 = distinct !{!7, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4E8bfloat16S3_EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrSA_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS8_IS3_XT0_EEERKT_"}
!8 = distinct !{!8, !9, !"_ZN3aie15parallel_lookupItNS_3lutILj4E8bfloat16S2_EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS8_IS2_XT0_EEERKT_: argument 0"}
!9 = distinct !{!9, !"_ZN3aie15parallel_lookupItNS_3lutILj4E8bfloat16S2_EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS8_IS2_XT0_EEERKT_"}
!10 = !{!11, !13}
!11 = distinct !{!11, !12, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4E8bfloat16S3_EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrSA_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS8_IS3_XT0_EEERKT_: argument 0"}
!12 = distinct !{!12, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4E8bfloat16S3_EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrSA_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS8_IS3_XT0_EEERKT_"}
!13 = distinct !{!13, !14, !"_ZN3aie15parallel_lookupItNS_3lutILj4E8bfloat16S2_EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS8_IS2_XT0_EEERKT_: argument 0"}
!14 = distinct !{!14, !"_ZN3aie15parallel_lookupItNS_3lutILj4E8bfloat16S2_EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS8_IS2_XT0_EEERKT_"}
!15 = !{!16, !18}
!16 = distinct !{!16, !17, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4E8bfloat16S3_EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrSA_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS8_IS3_XT0_EEERKT_: argument 0"}
!17 = distinct !{!17, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4E8bfloat16S3_EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrSA_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS8_IS3_XT0_EEERKT_"}
!18 = distinct !{!18, !19, !"_ZN3aie15parallel_lookupItNS_3lutILj4E8bfloat16S2_EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS8_IS2_XT0_EEERKT_: argument 0"}
!19 = distinct !{!19, !"_ZN3aie15parallel_lookupItNS_3lutILj4E8bfloat16S2_EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS8_IS2_XT0_EEERKT_"}
!20 = !{!21, !23}
!21 = distinct !{!21, !22, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4E8bfloat16S3_EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrSA_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS8_IS3_XT0_EEERKT_: argument 0"}
!22 = distinct !{!22, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4E8bfloat16S3_EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrSA_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS8_IS3_XT0_EEERKT_"}
!23 = distinct !{!23, !24, !"_ZN3aie15parallel_lookupItNS_3lutILj4E8bfloat16S2_EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS8_IS2_XT0_EEERKT_: argument 0"}
!24 = distinct !{!24, !"_ZN3aie15parallel_lookupItNS_3lutILj4E8bfloat16S2_EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS8_IS2_XT0_EEERKT_"}
!25 = !{!26, !28}
!26 = distinct !{!26, !27, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4E8bfloat16S3_EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrSA_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS8_IS3_XT0_EEERKT_: argument 0"}
!27 = distinct !{!27, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4E8bfloat16S3_EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrSA_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS8_IS3_XT0_EEERKT_"}
!28 = distinct !{!28, !29, !"_ZN3aie15parallel_lookupItNS_3lutILj4E8bfloat16S2_EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS8_IS2_XT0_EEERKT_: argument 0"}
!29 = distinct !{!29, !"_ZN3aie15parallel_lookupItNS_3lutILj4E8bfloat16S2_EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS8_IS2_XT0_EEERKT_"}
!30 = !{!31, !33}
!31 = distinct !{!31, !32, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4E8bfloat16S3_EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrSA_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS8_IS3_XT0_EEERKT_: argument 0"}
!32 = distinct !{!32, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4E8bfloat16S3_EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrSA_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS8_IS3_XT0_EEERKT_"}
!33 = distinct !{!33, !34, !"_ZN3aie15parallel_lookupItNS_3lutILj4E8bfloat16S2_EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS8_IS2_XT0_EEERKT_: argument 0"}
!34 = distinct !{!34, !"_ZN3aie15parallel_lookupItNS_3lutILj4E8bfloat16S2_EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS8_IS2_XT0_EEERKT_"}
!35 = !{!36, !38}
!36 = distinct !{!36, !37, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4E8bfloat16S3_EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrSA_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS8_IS3_XT0_EEERKT_: argument 0"}
!37 = distinct !{!37, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4E8bfloat16S3_EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrSA_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS8_IS3_XT0_EEERKT_"}
!38 = distinct !{!38, !39, !"_ZN3aie15parallel_lookupItNS_3lutILj4E8bfloat16S2_EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS8_IS2_XT0_EEERKT_: argument 0"}
!39 = distinct !{!39, !"_ZN3aie15parallel_lookupItNS_3lutILj4E8bfloat16S2_EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS8_IS2_XT0_EEERKT_"}
!40 = !{!41, !43}
!41 = distinct !{!41, !42, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4E8bfloat16S3_EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrSA_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS8_IS3_XT0_EEERKT_: argument 0"}
!42 = distinct !{!42, !"_ZN3aie6detail15parallel_lookupItNS0_3lutILj4E8bfloat16S3_EELNS0_14lut_oor_policyE1EE5fetchINS_6vectorItLj16EEELj16EQaaaaleclsrTL0__4sizeELi32EleTL0_0_clsrSA_4sizeEleTL0_0_sr20native_vector_lengthIT0_EE5valueEENS8_IS3_XT0_EEERKT_"}
!43 = distinct !{!43, !44, !"_ZN3aie15parallel_lookupItNS_3lutILj4E8bfloat16S2_EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS8_IS2_XT0_EEERKT_: argument 0"}
!44 = distinct !{!44, !"_ZN3aie15parallel_lookupItNS_3lutILj4E8bfloat16S2_EELNS_6detail14lut_oor_policyE1EE5fetchITkNS_6VectorENS_6vectorItLj16EEELj16EEENS8_IS2_XT0_EEERKT_"}
!45 = distinct !{!45, !46}
!46 = !{!"llvm.loop.mustprogress"}
