# Secure STM32MP2 Project

Comprehensive secure boot and trusted execution environment setup for STM32MP2 SoC.

## Project Structure

```
/opt/enterprise-pki/                    # Phase 1: Primary PKI Workspace (Secure)
/data/org_bckup/04-Sources/              # Main Development Workspace
├── MYD-LD25X-Uboot-L2022.10-V1.0.0/
│   └── Bootloader/
│       ├── myir-st-external-dt/plat/st/stm32mp2/fdts/stm32mp257x-myb.dts
│       ├── myir-st-optee/core/arch/arm/plat-stm32mp2/conf.mk
│       ├── myir-st-optee/ta/app_verify/ (TA Source)
│       ├── myir-st-u-boot/configs/stm32mp25_defconfig
│       ├── Makefile.sdk
│       ├── compile_secure_tfa.sh
│       └── build/
├── MYD-LD25X-Linux-L6.1.82-V1.1.0/
│   └── arch/arm64/configs/stm32mp2_secure_defconfig
├── MYD-LD25X-Yocto-mickledore-V1.0.0/
│   └── build/tmp/deploy/images/myd-ld25x/
├── payloads/
│   ├── fitImage.its
│   ├── kcmdline.txt
│   ├── rootfs_verity.img
│   ├── hashtree.bin
│   └── verity_metadata.txt
├── verification_agent/
│   └── agent.c
└── build_signed_fit.sh

/opt/factory-tools/                     # Phase 8: Factory Scripts
└── provision_device.sh
```

## Build Phases

1. **Phase 1**: PKI Setup (Enterprise PKI materials)
2. **Phase 2**: Trusted Firmware-A (Secure boot foundation)
3. **Phase 3**: OP-TEE Configuration (Trusted execution environment)
4. **Phase 4**: U-Boot & FIT Image (Secure bootloader)
5. **Phase 5**: Linux Kernel & Rootfs (Secure OS)
6. **Phase 6**: Root Filesystem Integrity (DM-Verity)
7. **Phase 7**: Verification Agents (TA + Linux module)
8. **Phase 8**: Factory Provisioning

## Security Features

- Secure Boot with signature verification
- Trusted Execution Environment (OP-TEE)
- Kernel integrity measurement (IMA)
- Root filesystem verification (DM-Verity)
- SELinux enforcing
- Hardware-backed key storage

## License

Confidential - MYIR Technologies
