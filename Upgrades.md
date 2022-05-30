# Section 12 — Upgrades

There are three ways to upgrade our smart contracts:

1. Parameterization
1. Migration
1. Proxies

## Parameterization

Parameterization is the simplest way of upgrading a smart contract, but it comes with the disadvantage of not allowing us to add additional storage or new logic.

Another thing to think about is who has access to these setter/updater functions. We can evaluate a smart contract’s degree of decentralization based on who has access to those functions.

## Migration

Via the process of migration, we can adhere to the blockchain philosophy of immutability.

Unfortunately, migration does require a significant amount of effort to convince users to move to our new address/protocol.

## Proxies

Using _delegatecall_ we can share values and code between implementation and proxy contracts and indicate which code should be used in different circumstances.
