#
# Copyright (C) 2021 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_PREBUILT_KERNEL),)
SSV6051_PATH    := $(abspath $(call my-dir))/ssv6051
SSV_HWIF_CTRL_PATH    := $(abspath $(call my-dir))/ssv_hwif_ctrl
SSV6X5X_PATH := $(abspath $(call my-dir))/ssv6x5x
SSV6051_CONFIGS := CONFIG_SSV6XXX=m
SSV_6X5X := CONFIG_SSV6X5X=m

include $(CLEAR_VARS)

LOCAL_MODULE        := ssv6051
LOCAL_MODULE_SUFFIX := .ko
LOCAL_MODULE_CLASS  := ETC
LOCAL_MODULE_PATH   := $(TARGET_OUT_VENDOR)/lib/modules

_ssv6051_intermediates := $(call intermediates-dir-for,$(LOCAL_MODULE_CLASS),$(LOCAL_MODULE))
_ssv6051_ko := $(_ssv6051_intermediates)/$(LOCAL_MODULE)$(LOCAL_MODULE_SUFFIX)
KERNEL_OUT := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ
SSV6051_CFLAGS := -I$(abspath $(_ssv6051_intermediates))/include

$(_ssv6051_ko): $(INTERMEDIATES_KERNEL)
	@mkdir -p $(dir $@)
	@cp -R $(SSV6051_PATH)/* $(_ssv6051_intermediates)/
	$(hide) +$(MAKE) $(PATH_OVERRIDE) $(KERNEL_MAKE_FLAGS) -C $(KERNEL_OUT) EXTRA_CFLAGS="$(SSV6051_CFLAGS)" M=$(abspath $(_ssv6051_intermediates)) ARCH=$(KERNEL_ARCH) CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) $(SSV6051_CONFIGS) modules
	$(KERNEL_TOOLCHAIN_PATH)strip --strip-unneeded $@;


include $(CLEAR_VARS)
LOCAL_MODULE        := ssv6x5x
LOCAL_MODULE_SUFFIX := .ko
LOCAL_MODULE_CLASS  := ETC
LOCAL_MODULE_PATH   := $(TARGET_OUT_VENDOR)/lib/modules

_ssv6x5x_intermediates := $(call intermediates-dir-for,$(LOCAL_MODULE_CLASS),$(LOCAL_MODULE))
_ssv6x5x_ko := $(_ssv6x5x_intermediates)/$(LOCAL_MODULE)$(LOCAL_MODULE_SUFFIX)
KERNEL_OUT := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ
SSV6X5X_CFLAGS := -I$(abspath $(_ssv6x5x_intermediates))/include


$(_ssv6x5x_ko): $(INTERMEDIATES_KERNEL)
	@mkdir -p $(dir $@)
	@cp -R $(SSV6X5X_PATH)/* $(_ssv6x5x_intermediates)/
	$(hide) +$(MAKE) $(PATH_OVERRIDE) $(KERNEL_MAKE_FLAGS) -C $(KERNEL_OUT) EXTRA_CFLAGS="$(SSV6X5X_CFLAGS)" M=$(abspath $(_ssv6x5x_intermediates)) ARCH=$(KERNEL_ARCH) CROSS_COMPILE=$(PREFIX_CROSS_COMPILE) $(SSV6X5X_CONFIGS) modules
	$(KERNEL_TOOLCHAIN_PATH)strip --strip-unneeded $@;


include $(BUILD_SYSTEM)/base_rules.mk

endif
