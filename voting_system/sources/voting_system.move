// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions
module voting_system::dashboard;

use std::string::String;

// There are two types of structs owned and shared
// Everybody on a blockchain can see it but only owner can change it
// key is an ability
// ability force us to provide id
// UID is gonna also be stored on a blockchain

public struct Proporsal has key {
	id: UID,
	title: String,
	description: String,
	voted_yes_count: u64,
	voted_no_count: u64,
	expiration: u64,
	creator: address,
	voter_registry: vector<address> // -> List of all addresses voted for this proposal
}


public fun create_proposal(
	title: String,
	description: String,
	expiration: u64,
	ctx: &mut TxContext
) {
	let proposal = Proposal {
		id: object::new(ctx: ctx),
		title,
		description,
		voted_yes_count: 0,
		voted_no_count: 0,
		expiration,
		creator: ctx.sender(),
		voter_registry: vector[]
	};

	transfer::share_object(obj: proposal);
}
