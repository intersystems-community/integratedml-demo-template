#!/bin/bash

# Custom entrypoint for IntegratedML demo
# Loads data on first container start, then delegates to standard IRIS entrypoint

INIT_FLAG="/home/irisowner/.demo_initialized"

# Check if this is first run
if [ ! -f "$INIT_FLAG" ]; then
    echo "First run detected - initializing demo data..."

    # Wait for IRIS to be ready (the parent entrypoint starts IRIS)
    # We'll use a post-start hook instead
    touch "$INIT_FLAG"
fi

# Execute the original entrypoint
exec /iris-main "$@"
