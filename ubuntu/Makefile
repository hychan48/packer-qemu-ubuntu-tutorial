#!/usr/bin/make -f
# modified from:
# https://github.com/canonical/packer-maas/blob/main/ubuntu/Makefile

# Packer
# include ../../packer-maas/scripts/check.mk
# typo of mass
# include ../../packer-mass/scripts/check.mk
# todo readd
# basically have to because packer can't do it


PACKER ?= packer
PACKER_LOG ?= 0
export PACKER_LOG
# Ubuntu 24.04 LTS Noble
SERIES ?= noble
ARCH ?= amd64
URL ?= http://releases.ubuntu.com
SUMS ?= SHA256SUMS
TIMEOUT ?= 1h
# pkr variables
PKR_VAR_host_hostname ?= $(shell hostname -I | awk '{print $$1}')
export PKR_VAR_host_hostname
PKR_VAR_output_directory ?= output
export PKR_VAR_output_directory


# if OVMF_CODE.fd is not found, use OVMF_CODE_4M.fd
ifeq ($(wildcard /usr/share/OVMF/OVMF_CODE.fd),)
	OVMF_SFX ?= _4M
else
	OVMF_SFX ?= 
endif
# https://releases.ubuntu.com/noble/SHA256SUMS
# https://releases.ubuntu.com/noble/SHA256SUMS
# server iso...
# ISO=$(shell wget -O- -q ${URL}/${SERIES}/${SUMS} | grep live-server | cut -d'*' -f2)

# copies to current directory
lint:
	packer validate .
	packer fmt -check -diff .


# creates the seed.iso in current directory
# revisit later...
# seeds-server-live.iso: user-data-server-live meta-data
# cloud-localds $@ $^


# Dev
HOSTIP=hostname -I | awk '{print $$1}'
show-variables:
	@echo "SERIES=${SERIES}"
	@echo "HOSTNAME=${shell hostname}"
	@echo "ARCH=${ARCH}"
	@echo "URL=${URL}"
	@echo "ISO=${ISO}"
	@echo "SUMS=${SUMS}"
	@echo "TIMEOUT=${TIMEOUT}"
	@echo "wget=${URL}/${SERIES}/${SUMS}"
	@echo "OVMF_SFX =${OVMF_SFX}"
	@echo "wildcard cmd=$(wildcard /usr/share/OVMF/OVMF_CODE.fd)"
	@echo "wildcard4M cmd=$(wildcard /usr/share/OVMF/OVMF_CODE_4M.fd)"
	@echo "HOSTIP=${shell hostname -I | awk '{print $$1}'}"
	@echo "PKR_VAR_host_hostname=${PKR_VAR_host_hostname}"
	@echo "PKR_VAR_output_directory=${PKR_VAR_output_directory}"


# var.output_directory right now... should probably use ENV instead
# PKR_VAR_output_directory=output/
# ubuntu_iso_base_uri

# packer inspect -only "ub-cloudinit*" .
clean:
	@echo "make clean (all)"
# todo make better and cleaner for output directory and artifacts
	rm -rf ${PKR_VAR_output_directory}/

configure:
# @make clean
	@echo "make configure"
	packer build -only "ub-cloudinit*" .
build: clean configure
	@echo "make build (all)"
# rm -rf output/ub24-server
	packer init .
# local
	packer build -only "ub24.qemu.ub2*" \
	-on-error=ask \
	.
	tree -f output

build-ub24-server:
	rm -rf ${PKR_VAR_output_directory}/ub24-server
	packer build -only "ub24.qemu.ub24-server" \
	-on-error=ask \
	.
	tree -f ${PKR_VAR_output_directory}/ub24-server
dev-build-ub24-server:
	rm -rf ${PKR_VAR_output_directory}/ub24-server
	packer build -only "ub24.qemu.ub24-server" \
	-on-error=ask \
	.
	tree -f ${PKR_VAR_output_directory}/ub24-server
build-ub22-server:
	rm -rf ${PKR_VAR_output_directory}/ub22-server
	packer build -only "ub24.qemu.ub22-server" \
	-on-error=ask \
	.
	tree -f ${PKR_VAR_output_directory}/ub22-server
build-ub24-desktop:
	rm -rf ${PKR_VAR_output_directory}/ub24-desktop
	packer build -only "ub24.qemu.ub24-desktop" \
	-on-error=ask \
	.
	tree -f ${PKR_VAR_output_directory}/ub24-server
# DEBUG / DEV Section
inspect_build:
	@echo "make inspect_build (all)"
# rm -rf output/ub24-server
	packer init .
	packer inspect -only "ub24.qemu.ub2*" \
	-var uri_ub24_server="file:///var/lib/qemu/images/ubuntu-24.04-live-server-amd64.iso" \
	-var uri_ub22_server="file:///var/lib/qemu/images/ubuntu-22.04-live-server-amd64.iso" \
	-var uri_ub24_desktop="file:///var/lib/qemu/images/ubuntu-24.04-live-desktop-amd64.iso" \
	.
debug-build:
	rm -rf output/debug.txt
	export PKR_VAR_enable_debug=true
	packer build -only "debug.file.debug" \
	-on-error=ask \
	.
	tree -f output



# todo
# create all http directory. shuold rename to http-