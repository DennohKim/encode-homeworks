#[test_only]
module move_asset::homework6_tests {
    use std::account;
    
    use move_asset::homework6;

    #[test]
    public fun test_create_asset() {
        // Create a test account
        let account = @0x1;
        let test_signer = account::create_signer_for_test(account);

        // Call the create_Asset function
        homework6::create_Asset(&test_signer);

        // Assert that the TokenAsset exists in the account's storage
        assert!(exists<homework6::TokenAsset>(account), 0);

        // Get a reference to the TokenAsset
        let token_asset = borrow_global<homework6::TokenAsset>(account);

        // Assert that the initial value is 0
        assert!(homework6::get_value(token_asset.value == 0, 1));
    }
}