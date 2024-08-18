module working_with_objects::objects {
use aptos_framework::object;
use aptos_framework::event; 
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

      /// Seed for my named object, must be globally unique to the creating account
  const NAME: vector<u8> = b"MyNamedObject";


    public entry fun create_example_object(user: &signer, name : String, balance: u64) {

        // Create a normal object
        // let constructor_ref = object::create_object(signer::address_of(user));

          // Create a named object
        let constructor_ref = object::create_named_object(
            user,
            NAME
        );
    
        
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

    #[view]
public fun get_named_object_address(creator: address): address {
    object::create_object_address(&creator, NAME)
}



}