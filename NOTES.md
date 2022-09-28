# Notes


## OpenSea Data Format

**Official References**

OpenSea API (V1) - <https://docs.opensea.io/reference/api-overview>



**Deprecated Notice**

Auto-remove all (market fees) deprecated (duplicated) fields from data - why? why not?


### Asset Contract Model

<https://docs.opensea.io/reference/asset-contract-model>


**dev_seller_fee_basis_points** - deprecated - use 'fees' in the Collection Model

The collector's fees that get paid out to them when sales are made for their collections

**opensea_seller_fee_basis_points** - deprecated - use 'fees' in the Collection Model

The OpenSea fee

**payout_address** - deprecated - use 'fees' in the Collection Model

The payout address for the collection's royalties


What about?

- buyer_fee_basis_points  ==  opensea_buyer_fee_basis_points + dev_buyer_fee_basis_points ???
  - dev_buyer_fee_basis_points
  - opensea_buyer_fee_basis_points
- seller_fee_basis_points  ==  opensea_seller_fee_basis_points + dev_seller_fee_basis_points  ???



### Collection Model

<https://docs.opensea.io/reference/collection-model>

**dev_seller_fee_basis_points** - deprecated - use 'fees' instead

The collector's fees that get paid out to them when sales are made for their collections

**opensea_seller_fee_basis_points**  - deprecated - use 'fees' instead

The OpenSea fee

**payout_address** - deprecated - use 'fees' instead

The payout address for the collection's royalties





