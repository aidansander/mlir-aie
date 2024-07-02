#include "lut_based_ops.h"
void dut(bfloat16 *restrict v1, bfloat16 *restrict v2) {
  size_t v3 = 0;
  size_t v4 = 1024;
  size_t v5 = 16;
	//this is bypassing the AIE_API, going straight to intrinsic
	//implementation + lib implementation
  for (size_t v6 = v3; v6 < v4; v6 += v5)
    chess_prepare_for_pipelining chess_loop_range(64, 64) {
      v16bfloat16 v7 = *(v16bfloat16 *)(v1 + v6);
			//interestingly, lib implementation uses aie_api
			//we need to get an mlir representation of the stuff in 
			//getExpBf16 that is appropriate for whatever stage of 
			//transformation we are in (aievec?) and output that
      v16accfloat v8 = getExpBf16(v7);
      v16bfloat16 v9 = to_v16bfloat16(v8);
      *(v16bfloat16 *)(v2 + v6) = v9;
    }
  return;
}
