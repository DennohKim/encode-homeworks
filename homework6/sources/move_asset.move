module move_asset::homework6 {


struct TokenAsset has key {
// add the key ability
   //add value field
   value: u64
}



public entry fun create_Asset(account : &signer, token_value: u64) {
// create a TokenAsset 
let token_asset = create(token_value);

// move the TokenAsset to the account address 
move_to(account, token_asset);

}

fun create(token_value: u64) : TokenAsset {

TokenAsset {
    value: token_value
}

}

#[view]

public fun view_asset_value(account: address) : u64 acquires TokenAsset { 
    borrow_global<TokenAsset>(account).value
    
}

  #[test_only]
    public fun get_value(token: &TokenAsset): u64 {
        token.value
    }

}