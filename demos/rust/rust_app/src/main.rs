extern crate libc;

extern "C" {
    fn increment_by_one(input: *mut libc::c_int);
}

use libp2p;
use std::error::Error;
#[async_std::main]
async fn main() -> Result<(), Box<dyn Error>> {
    let mut input = 5;
    let old = input;
    unsafe { increment_by_one(&mut input) };
    println!("{} + 1 = {}", old, input);

    println!("start ping");
    libp2p::start_ping().await?;

    Ok(())
}
