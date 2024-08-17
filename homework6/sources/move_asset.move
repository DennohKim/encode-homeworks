module move_asset::homework6 {


struct TokenAsset has key {
// add the key ability
   //add value field
   value: u64
}



public entry fun create_Asset(account : &signer) {
// create a TokenAsset 
let token_asset = create();

// move the TokenAsset to the account address 
move_to(account, token_asset);

}


fun create() : TokenAsset {
// return a Token Asset with 0 value
TokenAsset {
    value: 0
}

}

  #[test_only]
    public fun get_value(token: &TokenAsset): u64 {
        token.value
    }

}