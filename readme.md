# KCL vCluster Config

This repository provides KCL schemas for [vCluster](https://github.com/loft-sh/vcluster) configuration, based on the official vCluster config definitions.

## Overview

The KCL schemas in this repository are synchronized with the vCluster config package from the [vcluster-config](https://github.com/loft-sh/vcluster-config) repository (a separate repository by Loft that provides the vCluster configuration definitions), currently tracking **tag vcluster-v0.30**.

The vcluster-config repository is included as a git submodule in `vcluster-config-ref/` for reference.

## Schema Generation

Since the KCL import tool currently doesn't work properly with the vCluster JSON schemas, we use LLM-assisted conversion to maintain schema synchronization between the Go structs and KCL schemas.

The conversion process:

1. Reference the official Go structs in `vcluster-config-ref/config/config.go`
2. Use LLM to analyze and convert Go struct definitions to KCL schemas
3. Validate the generated KCL schemas match the Go type definitions
4. Apply fixes for any differences or missing fields

## Structure

```
.
├── vcluster_config/           # KCL schemas for vCluster configuration
│   ├── kcl.mod               # KCL module definition
│   ├── main.k                # Main entry point
│   └── vcluster_config.k     # Complete vCluster config schemas
└── vcluster-config-ref/      # Git submodule - official vCluster config (reference)
    └── config/
        └── config.go         # Source of truth for schema definitions
```

## Usage

Import the vCluster config schemas in your KCL code:

```kcl
import vcluster_config

config: vcluster_config.ClusterConfig = {
    controlPlane: {
        distro: {
            k8s: {
                enabled: True
            }
        }
    }
    sync: {
        toHost: {
            pods: {
                enabled: True
            }
        }
    }
}
```

## Updating Schemas

To update the schemas to a new vCluster version:

1. Update the submodule to the desired vCluster tag:

   ```bash
   cd vcluster-config-ref
   git fetch --tags
   git checkout vcluster-vX.XX
   cd ..
   git add vcluster-config-ref
   ```

2. Use LLM to compare the Go structs with existing KCL schemas and generate updates

3. Verify the updated schemas are correct and complete

## License

This project is based on the vCluster project. Please refer to the [vCluster LICENSE](https://github.com/loft-sh/vcluster/blob/main/LICENSE) for licensing information.
