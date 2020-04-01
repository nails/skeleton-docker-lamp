# Nails Docker Environment SSL self-signed certificate

The certificates used by the Nails Docker Envieonment are self-signed. They are pre-generated so that all instances use the same certificate meaning it can be trusted by development environments to enable the padlock.

If needed, you may generate a new certificate by executing `./generate.sh` in this directory - update the config as required for your setup.