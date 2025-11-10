# Home Assistant Add-on: Cribl Edge

Cribl Edge&trade; for Home Assistant&trade;

![Current Version 4.14.1][version-shield]
![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Doesn't Support armhf Architecture][armhf-shield]
![Doesn't Support arm7 Architecture][arm7-shield]
![Doesn't Support i386 Architecture][i386-shield]

![Registry Release][release-shield]
![GitHub Actions builder Workflow Status][builder-shield]
![GitHub Actions lint Workflow Status][lint-shield]
![GitHub Issues Status][issues-shield]

## About

This add-on installs the [Cribl Edge] agent for exploring, collecting, transforming, and routing logs and metrics. 

Every Cribl Edge install comes with a Free license that allows for processing of up to 1 TB/day. This license requires sending anonymized [Telemetry Data] to Cribl. You may also sign up for a [Cribl.Cloud] account to get free access to Stream, Search, and Lake as well as a Leader to manage them all. See the [Cribl Docs] and [Cribl University] to learn more.

## Security

Home Assistant add-ons start locked down pretty tightly. We've opened up a few things for Edge to get access to to make it more usable for typical uses. The addition access granted to the add-on are listed below.

1. host network access so it can option ports for Sources like Syslog, SNMP Traps, Metrics, and others
1. read-only access to Home Assistant's `config/` directory for access to the `home-assistant.log` for log collection with the File Monitor Source
1. read-only access to the host's journald files for the Journald Source
1. access to the Supervisor and Home Assistant APIs

Access to the Cribl Edge UI/API is internal, via Home Assistant's _Ingress_ feature and not accessible externally.

## Support

**DANGER: MAY EAT YOUR DATA! Absolutely no warranty or guarantees provided.**

This add-on is maintained by [Paul Dugas] in his spare time and is in no way supported by Cribl, Inc. At the time this was written, Paul is a Senior Staff Software Engineer at Cribl, Inc. serving as the Technical Lead for the Cribl Edge team.

The best place to get access to Paul and the rest of the Edge team is in the `#edge` channel in [Cribl Community Slack]. This project is part of Paul's add-ons repository at <https://github.com/pdugas/hassio-addons/>. Report issues there, please.

[version-shield]: https://img.shields.io/badge/version-4.14.1-blue.svg
[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-no-red.svg
[arm7-shield]: https://img.shields.io/badge/arm7-no-red.svg
[i386-shield]: https://img.shields.io/badge/i386-no-red.svg
[release-shield]: https://img.shields.io/github/v/release/pdugas/hsassio-addons
[builder-shield]: https://img.shields.io/github/actions/workflow/status/pdugas/hassio-addons/builder.yaml?label=builder
[lint-shield]: https://img.shields.io/github/actions/workflow/status/pdugas/hassio-addons/lint.yaml?label=lint
[issues-shield]: https://img.shields.io/github/issues/pdugas/hassio-addons
[Cribl Edge]: https://cribl.io/edge/
[Telemetry Data]: https://docs.cribl.io/edge/licensing/#telemetry-data
[Cribl.Cloud]: https://cribl.cloud/
[Cribl Docs]: https://docs.cribl.io/edge/
[Cribl University]: https://cribl.io/university/
[Cribl Community Slack]: https://cribl-community.slack.com/
[Paul Dugas]: mailto:paul.dugas.cc
