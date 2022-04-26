from brownie import CameronToken
from helpers import get_account
from web3 import Web3

initial_supply = Web3.toWei(1000, "ether")


def main():
    account = get_account()
    cam_token = CameronToken.deploy(initial_supply, {"from": account})
    print(cam_token.name())
