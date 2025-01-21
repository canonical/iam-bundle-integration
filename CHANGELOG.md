# Changelog

## [0.5.0](https://github.com/canonical/iam-bundle-integration/compare/v0.4.1...v0.5.0) (2025-01-21)


### Features

* drop ingress, postgres and openfga deployments, use offers instead ([47ab5f2](https://github.com/canonical/iam-bundle-integration/commit/47ab5f2573b6c1479d3faa55fbff8c7e0d5bb278))


### Bug Fixes

* add send-ca-certificate for oauth tls trust ([7a2981a](https://github.com/canonical/iam-bundle-integration/commit/7a2981ad3eb0efad8b23385fdbf784c6941cfa0b))
* adjust hydra-endpoint-info integrations ([f269bf4](https://github.com/canonical/iam-bundle-integration/commit/f269bf43e780c10daa783b25979d42fd7cfa2aac))
* adjust juju version for external idp ([c93cfb7](https://github.com/canonical/iam-bundle-integration/commit/c93cfb75c6d4a80ca066c2bd3c227d6435d535eb))
* drop postgresql module ([799f101](https://github.com/canonical/iam-bundle-integration/commit/799f101e84d029edd6d251c86199549d4ae73421))

## [0.4.1](https://github.com/canonical/iam-bundle-integration/compare/v0.4.0...v0.4.1) (2024-10-18)


### Bug Fixes

* update config values for psql ([fddb292](https://github.com/canonical/iam-bundle-integration/commit/fddb2922cd08b36511406835b63757802bfe7786))

## [0.4.0](https://github.com/canonical/iam-bundle-integration/compare/v0.3.0...v0.4.0) (2024-10-18)


### Features

* add psql plugins ([aa6e65d](https://github.com/canonical/iam-bundle-integration/commit/aa6e65d358e8378507bc8e1525d9349cfed91dc7))

## [0.3.0](https://github.com/canonical/iam-bundle-integration/compare/v0.2.2...v0.3.0) (2024-09-24)


### Features

* introduce admin ui and related components ([654c444](https://github.com/canonical/iam-bundle-integration/commit/654c44449e1927a05dd49079c6d5d85c74d37e97))

## [0.2.2](https://github.com/canonical/iam-bundle-integration/compare/v0.2.1...v0.2.2) (2024-09-09)


### Bug Fixes

* move to use kratos-info relation ([6a39273](https://github.com/canonical/iam-bundle-integration/commit/6a392731a3060bb68ce400b30f50e3734fd8caa5))

## [0.2.1](https://github.com/canonical/iam-bundle-integration/compare/v0.2.0...v0.2.1) (2024-07-10)


### Bug Fixes

* drop internal ingress integrations ([fd4b5ed](https://github.com/canonical/iam-bundle-integration/commit/fd4b5ed624069e658ad52cd56352b328dbe99c87))
* drop offer ([6d220b6](https://github.com/canonical/iam-bundle-integration/commit/6d220b62e24e82da14075531d79ed13ed8c27f6c))
* drop usage of data.juju_offer due to how it creates map ([e95946c](https://github.com/canonical/iam-bundle-integration/commit/e95946cd34571878a15192a574f2dcebc31e0059))
* flatten down juju integrations ([a3fb82b](https://github.com/canonical/iam-bundle-integration/commit/a3fb82b514b389785712a7b8114de7aa2b4c832e))
* introduce outputs for the offers ([2f8b2a4](https://github.com/canonical/iam-bundle-integration/commit/2f8b2a452777f7da13c59c9391f05856fb6d70c4))
* pass config to applications via var ([3e88585](https://github.com/canonical/iam-bundle-integration/commit/3e8858554c51f0d22e02835155d9945774dfa53e))
* remove obsolete juju provider def ([a0eecd7](https://github.com/canonical/iam-bundle-integration/commit/a0eecd73dc7ee863118d60e934e1326a78c1fb7f))

## [0.2.0](https://github.com/canonical/iam-bundle-integration/compare/v0.1.1...v0.2.0) (2024-04-30)


### Features

* expose kratos-info as juju offer for potential oathkeeper integration ([e5bdc17](https://github.com/canonical/iam-bundle-integration/commit/e5bdc17a86bb4c451719b0b08a3ebb831eba31be))
* use base instead of series for juju applications ([afe948f](https://github.com/canonical/iam-bundle-integration/commit/afe948f9e8e7f0465841a319a61915d80165360e))


### Bug Fixes

* add dependency between application deployments ([afcdc30](https://github.com/canonical/iam-bundle-integration/commit/afcdc30792ee081ced2347dffd30a769d004b417))
* address an issue with channel not being x/y but simply y ([610bcf7](https://github.com/canonical/iam-bundle-integration/commit/610bcf78732ccb605c8f007c5017101f111618a3))
* upgrade to juju 0.11.0 ([f2fdfa4](https://github.com/canonical/iam-bundle-integration/commit/f2fdfa4a53a44306d880b6eaaef711292d2f0200))
* use user friendly keys for mappings ([af1b6da](https://github.com/canonical/iam-bundle-integration/commit/af1b6daa2fe6410ab502ecac7956383972de6603))

## [0.1.1](https://github.com/canonical/iam-bundle-integration/compare/v0.1.0...v0.1.1) (2023-08-25)


### Bug Fixes

* updated hydra_endpoints relation name ([7e98d76](https://github.com/canonical/iam-bundle-integration/commit/7e98d76e99938e56df42e8fd88193e4cdbaa3bec))

## 0.1.0 (2023-07-18)


### Features

* create the iam bundle terraform module ([#1](https://github.com/canonical/iam-bundle-integration/issues/1)) ([22e13bd](https://github.com/canonical/iam-bundle-integration/commit/22e13bd5a1ad8b05a919eb0e2fe687c6826784db))
* provide Makefile, terraform-docs action, release-please action ([#3](https://github.com/canonical/iam-bundle-integration/issues/3)) ([d5fa08a](https://github.com/canonical/iam-bundle-integration/commit/d5fa08a3d2386117b1665cc275badc7b4b7847ed))
