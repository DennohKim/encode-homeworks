module basic_address::homework5 {

 struct Asset has drop {
    value : u64,
    flag : u8
 }

 //add build_asset function

 fun create(value : u64, flag : u8) : Asset {
    // return instance of Asset

   Asset {
        value: value,
        flag: flag
    }
 

 }

 #[test]
 fun test_create() {
    let asset = create(100, 1);
    assert!(asset.value == 100, 0);
    assert!(asset.flag == 1, 0);
 }

}