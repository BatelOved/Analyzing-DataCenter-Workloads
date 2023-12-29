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
STREAM_ARRAY_SIZE = 67108864

ifdef size
STREAM_ARRAY_SIZE = $(size)
endif
STREAM_CPP_OPTS  += -DSTREAM_ARRAY_SIZE=$(STREAM_ARRAY_SIZE)

# Intel Compiler options to control the generated ISA
AVX_COPTS      = -xAVX
AVX2_COPTS     = -xCORE-AVX2
AVX512_COPTS   = -xCORE-AVX512 -qopt-zmm-usage=high

# Common Intel Compiler options that are independent of ISA
COMMON_COPTS   = -Wall -O3 -mcmodel=medium -qopenmp -shared-intel

# Generic Compiler options
GEN_COPTS      = -Wall -O3 -fopenmp

ifdef rfo
COMMON_COPTS += -qopt-streaming-stores never -fno-builtin
else
COMMON_COPTS += -qopt-streaming-stores always
endif

AVX_OBJS    = $(BASE_DIR)/stream_avx.o
AVX2_OBJS   = $(BASE_DIR)/stream_avx2.o
AVX512_OBJS = $(BASE_DIR)/stream_avx512.o
GEN_OBJS    = $(BASE_DIR)/stream.o

ifdef cpu
all: $(BASE_DIR)/stream_$(cpu).bin
else
all: $(BASE_DIR)/stream_avx.bin $(BASE_DIR)/stream_avx2.bin $(BASE_DIR)/stream_avx512.bin $(BASE_DIR)/stream.bin
endif

SRC = $(BASE_DIR)/stream.c

$(BASE_DIR)/stream_avx.o: $(SRC)
	$(ICC) $(COMMON_COPTS) $(AVX_COPTS) $(STREAM_CPP_OPTS) -c $(SRC) -o $@
$(BASE_DIR)/stream_avx2.o: $(SRC)
	$(ICC) $(COMMON_COPTS) $(AVX2_COPTS) $(STREAM_CPP_OPTS) -c $(SRC) -o $@
$(BASE_DIR)/stream_avx512.o: $(SRC)
	$(ICC) $(COMMON_COPTS) $(AVX512_COPTS) $(STREAM_CPP_OPTS) -c $(SRC) -o $@
$(BASE_DIR)/stream.o: $(SRC)
	$(GCC) $(GEN_COPTS) $(STREAM_CPP_OPTS) -c $(SRC) -o $@

$(BASE_DIR)/stream_avx.bin: $(AVX_OBJS)
	$(ICC) $(COMMON_COPTS) $(AVX_COPTS) $^ -o $@
$(BASE_DIR)/stream_avx2.bin: $(AVX2_OBJS)
	$(ICC) $(COMMON_COPTS) $(AVX2_COPTS) $^ -o $@
$(BASE_DIR)/stream_avx512.bin: $(AVX512_OBJS)
	$(ICC) $(COMMON_COPTS) $(AVX512_COPTS) $^ -o $@
$(BASE_DIR)/stream.bin: $(GEN_OBJS)
	$(GCC) $(GEN_COPTS) $^ -o $@


help:
	@echo -e "Running 'make' with no options would compile the STREAM benchmark with $(STREAM_ARRAY_SIZE) FP64 elements per array for following Intel CPU's:\n"
	@echo -e "\tstream_avx.bin        => Targeted for Intel CPU's that support AVX ISA"
	@echo -e "\tstream_avx2.bin       => Targeted for Intel CPU's that support AVX2 ISA"
	@echo -e "\tstream_avx512.bin     => Targeted for Intel CPU's that support AVX512 ISA"
	@echo -e "\nThe following options are supported:"
	@echo -e "\tsize=<number_of_elements_per_array>"
	@echo ""
	@echo -e "\tcpu=<avx,avx2,avx512>"
	@echo ""
	@echo -e "\trfo=1 forces to use regular cached stores instead of non-temporal stores"
	@echo ""
	@echo -e "\nFew examples:"
	@echo -e "To compile STREAM benchmark only for Intel AVX512 CPU's, do:"
	@echo -e "\tmake cpu=avx512"
	@echo ""
	@echo -e "To compile STREAM benchmark for Intel AVX512 CPU's with each buffer containing 67108864 elements, do:"
	@echo -e "\tmake size=67108864 cpu=avx512"

clean:
	rm -rf $(BASE_DIR)/*.o $(BASE_DIR)/*.bin 

.PHONY: all clean help
