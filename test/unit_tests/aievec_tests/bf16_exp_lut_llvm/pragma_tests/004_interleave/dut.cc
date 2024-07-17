#include "lut_based_ops.h"
extern "C" void dut(bfloat16 *restrict v1, bfloat16 *restrict v2) {
  size_t v3 = 0;
  const size_t v4 = 1024;
  const size_t v5 = 16;
#pragma clang loop min_iteration_count(64) 
#pragma clang loop max_iteration_count(64) 
#pragma clang loop interleave_count(3)
  for (size_t v6 = v3; v6 < v4; v6 += v5){
      v16bfloat16 v7 = *(v16bfloat16 *)(v1 + v6);
      v16accfloat v8 = getExpBf16(v7);
      v16bfloat16 v9 = to_v16bfloat16(v8);
      *(v16bfloat16 *)(v2 + v6) = v9;
  }
  return;
}
