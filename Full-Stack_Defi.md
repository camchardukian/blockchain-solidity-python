# Section 13 — Full Stack Defi

## Transfers

With ERC-20 tokens we are able to use either _transfer_ or _transferFrom_.

The difference between the two methods is that _transfer_ can only be called from the wallet that owns the tokens, while _transferFrom_ can be called from other wallets.

## Front-End

It’s best practice to keep our front-end code in a separate repo from our smart contracts.

### useDapp

useDApp is a popular framework for rapid DApp development.
