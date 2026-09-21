# Herdr config

This directory is the local Herdr configuration for this machine.

## Plugin install/update flow

Use the central installer script to keep the configured plugins in sync:

```bash
./install-plugins.sh
```

This installs and refreshes the managed plugins used by this config.

## Plugins

Current Herdr plugins for this config:

- `ogulcancelik/herdr-plugin-examples/agent-telegram-notify`
- `levi-qiao/herdr-agent-quota`

These are installed via the Herdr plugin manager and can be managed with commands such as:

```bash
herdr plugin list
herdr plugin action list --plugin examples.agent-telegram-notify
herdr plugin action list --plugin herdr-agent-quota
```

To reinstall or update a plugin from GitHub, rerun the installer script. For local development, use `herdr plugin link /path/to/plugin`.
