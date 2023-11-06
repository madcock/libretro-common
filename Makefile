
MIPS = /opt/mips32-mti-elf/2019.09-03-2/bin/mips-mti-elf-
CC = $(MIPS)gcc
AR = $(MIPS)ar

CFLAGS = -EL -march=mips32 -mtune=mips32 -msoft-float
CFLAGS += -ffast-math -fomit-frame-pointer
CFLAGS += -G0 -mno-abicalls -fno-pic
CFLAGS += -ffunction-sections -fdata-sections
CFLAGS += -DSF2000

CFLAGS += -O2 -DNDEBUG
CFLAGS += -Iinclude -I./include/compat/zlib
CFLAGS += -D_7ZIP_ST

TARGET=libretro-common.a

SOURCES_C += \
	compat/compat_strl.c \
	compat/compat_strcasestr.c \
	encodings/encoding_crc32.c \
	encodings/encoding_utf.c \
	file/config_file.c \
	file/file_path.c \
	file/file_path_io.c \
	libco/libco.c \
	streams/file_stream.c \
	streams/file_stream_transforms.c \
	streams/memory_stream.c \
	streams/interface_stream.c \
	string/stdstring.c \
	vfs/vfs_implementation.c

DEPS_DIR = deps
SOURCES_C += \
        $(DEPS_DIR)/libz/adler32.c \
        $(DEPS_DIR)/libz/crc32.c \
        $(DEPS_DIR)/libz/deflate.c \
        $(DEPS_DIR)/libz/gzclose.c \
        $(DEPS_DIR)/libz/gzlib.c \
        $(DEPS_DIR)/libz/gzread.c \
        $(DEPS_DIR)/libz/inffast.c \
        $(DEPS_DIR)/libz/inflate.c \
        $(DEPS_DIR)/libz/inftrees.c \
        $(DEPS_DIR)/libz/trees.c \
        $(DEPS_DIR)/libz/uncompr.c \
        $(DEPS_DIR)/libz/zutil.c

SOURCES_C += \
        $(DEPS_DIR)/7zip/7zArcIn.c \
        $(DEPS_DIR)/7zip/7zBuf.c \
        $(DEPS_DIR)/7zip/7zCrc.c \
        $(DEPS_DIR)/7zip/7zCrcOpt.c \
        $(DEPS_DIR)/7zip/7zDec.c \
        $(DEPS_DIR)/7zip/7zFile.c \
        $(DEPS_DIR)/7zip/7zStream.c \
        $(DEPS_DIR)/7zip/Bcj2.c \
        $(DEPS_DIR)/7zip/Bra.c \
        $(DEPS_DIR)/7zip/Bra86.c \
        $(DEPS_DIR)/7zip/BraIA64.c \
        $(DEPS_DIR)/7zip/CpuArch.c \
        $(DEPS_DIR)/7zip/Delta.c \
        $(DEPS_DIR)/7zip/Lzma2Dec.c \
        $(DEPS_DIR)/7zip/LzmaDec.c \
        $(DEPS_DIR)/7zip/LzmaEnc.c \
        $(DEPS_DIR)/7zip/LzFind.c

OBJECTS := $(SOURCES_C:.c=.o)

all: $(TARGET)

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(TARGET): $(OBJECTS)
	$(AR) rcs $@ $(OBJECTS)

clean:
	rm -f $(TARGET) $(OBJECTS)

.PHONY: clean
