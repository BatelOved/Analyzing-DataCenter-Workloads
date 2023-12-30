# Copyright (C) 2021 Intel Corporation
# SPDX-License-Identifier: BSD-3-Clause

ICC = icx
GCC = gcc

BASE_DIR = $(WA)/stream

# STREAM options:
# -DNTIMES control the number of times each stream kernel is executed
# -DOFFSET controls the number of bytes between each of the buffers
# -DSTREAM_TYPE specifies the data-type of elements in the buffers
# -DSTREAM_ARRAY_SIZE specifies the number of elements in each buffer
STREAM_CPP_OPTS   = -DNTIMES=100 -DOFFSET=0 -DSTREAM_TYPE=double
# Size per array is approx. ~2GB. Delibrately using non-power of 2 elements
# 256*1024*1024 elements = 268435456 elements = 2GiB with FP64
STREAM_ARRAY_SIZE = 134217728

ifdef size
STREAM_ARRAY_SIZE = $(size)
endif
STREAM_CPP_OPTS  += -DSTREAM_ARRAY_SIZE=$(STREAM_ARRAY_SIZE)

# Intel Compiler options to control the generated ISA
AVX512_COPTS   = -xCORE-AVX512 -qopt-zmm-usage=high

CFLAGS = -Wall -O3 -mcmodel=medium -Ofast -mavx2 -fno-builtin

GCC_FLAGS = -fopenmp
ICC_FLAGS = -qopenmp -shared-intel 
#-qopt-streaming-stores never

AVX512_OBJS = $(BASE_DIR)/stream_avx512.o
GEN_OBJS    = $(BASE_DIR)/stream.o

all: $(BASE_DIR)/stream_avx.bin $(BASE_DIR)/stream_avx2.bin $(BASE_DIR)/stream_avx512.bin $(BASE_DIR)/stream.bin

SRC = $(BASE_DIR)/stream.c

$(BASE_DIR)/stream_avx512.o: $(SRC)
	$(ICC) $(CFLAGS) $(ICC_FLAGS) $(AVX512_COPTS) $(STREAM_CPP_OPTS) -c $(SRC) -o $@
$(BASE_DIR)/stream.o: $(SRC)
	$(GCC) $(CFLAGS) $(GCC_FLAGS) $(STREAM_CPP_OPTS) -c $(SRC) -o $@

$(BASE_DIR)/stream_avx512.bin: $(AVX512_OBJS)
	$(ICC) $(CFLAGS) $(ICC_FLAGS) $(AVX512_COPTS) $^ -o $@
$(BASE_DIR)/stream.bin: $(GEN_OBJS)
	$(GCC) $(CFLAGS) $(GCC_FLAGS) $^ -o $@

clean:
	rm -rf $(BASE_DIR)/*.o $(BASE_DIR)/*.bin 

.PHONY: all clean help
