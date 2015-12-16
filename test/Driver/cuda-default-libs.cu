// Checks that we add -L /path/to/cuda/lib{,64} and -lcudart_static -ldl -lrt
// -lpthread as appropriate when compiling CUDA code.

// REQUIRES: clang-driver
// REQUIRES: x86-registered-target
// REQUIRES: nvptx-registered-target

// RUN: %clang -### -v --target=i386-unknown-linux \
// RUN:   -lfoo --sysroot=%S/Inputs/CUDA %s 2>&1 \
// RUN:   | FileCheck %s -check-prefix CUDA -check-prefix CUDA-x86_32
//
// RUN: %clang -### -v --target=x86_64-unknown-linux \
// RUN:   -lfoo --sysroot=%S/Inputs/CUDA %s 2>&1 \
// RUN:   | FileCheck %s -check-prefix CUDA -check-prefix CUDA-x86_64
//
// # Our new flags should come after user-specified flags.
// CUDA: -lfoo
// CUDA-x86_32: "-L" "{{.*}}/Inputs/CUDA/usr/local/cuda/lib"
// CUDA-x86_64: "-L" "{{.*}}/Inputs/CUDA/usr/local/cuda/lib64"
// CUDA-x86_32-NOT: "-L" "{{.*}}/Inputs/CUDA/usr/local/cuda/lib64"
// CUDA-x86_64-NOT: "-L" "{{.*}}/Inputs/CUDA/usr/local/cuda/lib"
// CUDA-DAG: "-lcudart_static"
// CUDA-DAG: "-ldl"
// CUDA-DAG: "-lrt"
// CUDA-DAG: "-lpthread"

// If we can't find CUDA, don't include it in our library search path, and
// don't include any additional libraries via -l.
// RUN: %clang -### -v --target=i386-unknown-linux \
// RUN:   --sysroot=%S/Inputs/no-cuda-there %s 2>&1 | FileCheck %s -check-prefix NOCUDA
//
// Also don't add anything if we pass -nocudalib.
// RUN: %clang -### -v --target=x86_64-unknown-linux -nocudalib \
// RUN:   --sysroot=%S/Inputs/CUDA %s 2>&1 | FileCheck %s -check-prefix NOCUDA
//
// NOCUDA-NOT: "-L" "{{.*}}/no-cuda-there/{{.*}}"
// NOCUDA-NOT: "-lcudart_static"
// NOCUDA-NOT: "-ldl"
// NOCUDA-NOT: "-lrt"
// NOCUDA-NOT: "-lpthread"
// NOCUDA-NOT: "-L" "{{.*}}/Inputs/CUDA/usr/local/cuda/lib"
// NOCUDA-NOT: "-L" "{{.*}}/Inputs/CUDA/usr/local/cuda/lib64"
