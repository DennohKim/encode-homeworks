module nft_collection::nft_collection {
    use std::string::{String, utf8};
    use std::signer;
    use aptos_framework::object;
    use aptos_token_objects::collection;
    use aptos_token_objects::token;
    use std::option::{Self, Option};

    const COLLECTION_NAME: vector<u8> = b"My Awesome Collection";
    const COLLECTION_DESCRIPTION: vector<u8> = b"A collection of unique digital assets";
    const TOKEN_NAME: vector<u8> = b"My Unique NFT";
    const TOKEN_DESCRIPTION: vector<u8> = b"A one-of-a-kind digital masterpiece";
    const TOKEN_URI: vector<u8> = b"https://artlogic-res.cloudinary.com/w_1200,c_limit,f_auto,fl_lossy,q_auto/ws-artlogicwebsite0889/usr/images/news/main_image/6/nft-bored-ape-yacht-club.png";

    struct NFTCollection has key {
        collection_name: String,
    }

    public entry fun create_collection_and_token(creator: &signer) {
        let creator_address = signer::address_of(creator);
        let royalty = option::none();

        // Create the collection
        let collection = collection::create_fixed_collection(
            creator,
            utf8(COLLECTION_DESCRIPTION),
            1, // max supply
            utf8(COLLECTION_NAME),
            royalty,
            utf8(TOKEN_URI),
        );

        // Create the token
        let token = token::create_named_token(
            creator,
            utf8(COLLECTION_NAME),
            utf8(TOKEN_DESCRIPTION),
            utf8(TOKEN_NAME),
            option::none(), // royalty
            utf8(TOKEN_URI),
        );

        // Add token to the collection
        collection::add_to_collection(&collection, token);

        // Store the collection name in the creator's account
        move_to(creator, NFTCollection {
            collection_name: utf8(COLLECTION_NAME),
        });
    }

    #[view]
    public fun get_collection_name(creator_address: address): String acquires NFTCollection {
        borrow_global<NFTCollection>(creator_address).collection_name
    }
}