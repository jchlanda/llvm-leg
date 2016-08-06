; NOTE: Assertions have been autogenerated by update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gn -mcpu=knl | FileCheck %s --check-prefix=ALL --check-prefix=KNL
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gn -mcpu=skx | FileCheck %s --check-prefix=ALL --check-prefix=SKX


define void @any_extend_load_v8i64(<8 x i8> * %ptr) {
; ALL-LABEL: any_extend_load_v8i64:
; ALL:       # BB#0:
; ALL-NEXT:    vpmovzxbq (%rdi), %zmm0
; ALL-NEXT:    vpaddq {{.*}}(%rip){1to8}, %zmm0, %zmm0
; ALL-NEXT:    vpmovqb %zmm0, (%rdi)
; ALL-NEXT:    retq
  %wide.load = load <8 x i8>, <8 x i8>* %ptr, align 1
  %1 = zext <8 x i8> %wide.load to <8 x i64>
  %2 = add nuw nsw <8 x i64> %1, <i64 4, i64 4, i64 4, i64 4, i64 4, i64 4, i64 4, i64 4>
  %3 = xor <8 x i64> %2, zeroinitializer
  %4 = trunc <8 x i64> %3 to <8 x i8>
  store <8 x i8> %4, <8 x i8>* %ptr, align 1
  ret void
}

define void @any_extend_load_v8i32(<8 x i8> * %ptr) {
; KNL-LABEL: any_extend_load_v8i32:
; KNL:       # BB#0:
; KNL-NEXT:    vpmovzxbd {{.*#+}} ymm0 = mem[0],zero,zero,zero,mem[1],zero,zero,zero,mem[2],zero,zero,zero,mem[3],zero,zero,zero,mem[4],zero,zero,zero,mem[5],zero,zero,zero,mem[6],zero,zero,zero,mem[7],zero,zero,zero
; KNL-NEXT:    vpbroadcastd {{.*}}(%rip), %ymm1
; KNL-NEXT:    vpaddd %ymm1, %ymm0, %ymm0
; KNL-NEXT:    vpmovdw %zmm0, %ymm0
; KNL-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u]
; KNL-NEXT:    vmovq %xmm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: any_extend_load_v8i32:
; SKX:       # BB#0:
; SKX-NEXT:    vpmovzxbd (%rdi), %ymm0
; SKX-NEXT:    vpaddd {{.*}}(%rip){1to8}, %ymm0, %ymm0
; SKX-NEXT:    vpmovdb %ymm0, (%rdi)
; SKX-NEXT:    retq
  %wide.load = load <8 x i8>, <8 x i8>* %ptr, align 1
  %1 = zext <8 x i8> %wide.load to <8 x i32>
  %2 = add nuw nsw <8 x i32> %1, <i32 4, i32 4, i32 4, i32 4, i32 4, i32 4, i32 4, i32 4>
  %3 = xor <8 x i32> %2, zeroinitializer
  %4 = trunc <8 x i32> %3 to <8 x i8>
  store <8 x i8> %4, <8 x i8>* %ptr, align 1
  ret void
}

define void @any_extend_load_v8i16(<8 x i8> * %ptr) {
; KNL-LABEL: any_extend_load_v8i16:
; KNL:       # BB#0:
; KNL-NEXT:    vpmovzxbw {{.*#+}} xmm0 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero
; KNL-NEXT:    vpaddb {{.*}}(%rip), %xmm0, %xmm0
; KNL-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u]
; KNL-NEXT:    vmovq %xmm0, (%rdi)
; KNL-NEXT:    retq
;
; SKX-LABEL: any_extend_load_v8i16:
; SKX:       # BB#0:
; SKX-NEXT:    vpmovzxbw (%rdi), %xmm0
; SKX-NEXT:    vpaddw {{.*}}(%rip), %xmm0, %xmm0
; SKX-NEXT:    vpmovwb %xmm0, (%rdi)
; SKX-NEXT:    retq
  %wide.load = load <8 x i8>, <8 x i8>* %ptr, align 1
  %1 = zext <8 x i8> %wide.load to <8 x i16>
  %2 = add nuw nsw <8 x i16> %1, <i16 4, i16 4, i16 4, i16 4, i16 4, i16 4, i16 4, i16 4>
  %3 = xor <8 x i16> %2, zeroinitializer
  %4 = trunc <8 x i16> %3 to <8 x i8>
  store <8 x i8> %4, <8 x i8>* %ptr, align 1
  ret void
}
