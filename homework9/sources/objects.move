module working_with_objects::homework9 {
use aptos_framework::object;
use std::signer;
use std::string::{String}; 

// Event structure
#[event]
    struct ExampleObjectCreatedEvent has drop, store {
        my_object: address,
    }


    #[resource_group_member(group = aptos_framework::object::ObjectGroup)]
    struct ExampleObject has key {
        name: String,
        balance: u64,

    }

    public entry fun create_example_object(user: &signer, name : String, balance: u64) {

        // Create a normal object
        let constructor_ref = object::create_object(signer::address_of(user));
        
        // Create a signer for the object
        let object_signer = object::generate_signer(&constructor_ref);
        
        // Move the resource to the object
        move_to(&object_signer, ExampleObject {
            name,
            balance,
        });
        
        // Get the address of the object
        let object_address = object::address_from_constructor_ref(&constructor_ref);
        
        // Emit the event with the object's address
        event::emit(ExampleObjectCreatedEvent {
            my_object: object_address,
        });

    
    }



}